import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/features/helper_core/provider/helper_core_provider.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:sg_easy_hire/models/User.dart';

part 'helper_core_event.dart';

class HelperCoreBloc extends Bloc<HelperCoreEvent, HelperCoreState> {
  final Box<User> box = Hive.box<User>(name: userBox);
  final HelperCoreProvider provider;
  HelperCoreBloc({required this.provider}) : super(const HelperCoreState()) {
    on<GetInitialUserData>(_getInitialUserData);
    on<StartSubscribeToUser>(_onStartSubscribeToUser);
    on<StartSubscribeToHiveUser>(_onStartSubscribeToHiveUser);
    on<UpdateDeviceToken>(_onUpdateDeviceToken);
  }

  FutureOr<void> _onStartSubscribeToUser(
    StartSubscribeToUser event,
    Emitter<HelperCoreState> emit,
  ) {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    emit(
      state.copyWith(currentUser: hiveUser),
    );
    if (hiveUser == null) {
      debugPrint("❗️ User : $hiveUser");
      return null;
    }
    return emit.onEach(
      provider.user(hiveUser.id),
      onData: (u) async {
        debugPrint("🌈 User Event: ${u?.toJson()}");
        if (u != null) {
          final currentUser = await provider.getUser(u.id);
          if (currentUser != null) {
            debugPrint("🌈 CURRENT USER Event: ${currentUser.toJson()}");
            emit(
              state.copyWith(
                currentUser: currentUser,
              ),
            );
          }
        }
      },
      onError: (error, _) {
        debugPrint("❗️ Subscribe To User Error: ${error.toString()}");
      },
    );
  }

  FutureOr<void> _onStartSubscribeToHiveUser(
    StartSubscribeToHiveUser event,
    Emitter<HelperCoreState> emit,
  ) {
    return emit.onEach(
      box.watch(),
      onData: (_) {
        final u = box.get(userBoxKey);
        debugPrint("🌈 Hive User Event: ${u?.toJson()}");
        emit(state.copyWith(currentUser: box.get(userBoxKey)));
      },
      onError: (error, _) {
        debugPrint("❗️ Subscribe To Hive User Error: ${error.toString()}");
      },
    );
  }

  FutureOr<void> _getInitialUserData(
    GetInitialUserData event,
    Emitter<HelperCoreState> emit,
  ) async {
    final user = await provider.getUser(event.id);
    if (user != null) {
      emit(state.copyWith(currentUser: user));
    }
  }

  FutureOr<void> _onUpdateDeviceToken(
    UpdateDeviceToken event,
    Emitter<HelperCoreState> emit,
  ) async {
    if (state.currentUser == null) return;
    await provider.updateUser(
      state.currentUser!.copyWith(deviceToken: event.token),
    );
  }
}
