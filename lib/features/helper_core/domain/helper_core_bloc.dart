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
    on<StartSubscribeToUser>(_onStartSubscribeToUser);
    on<StartSubscribeToHiveUser>(_onStartSubscribeToHiveUser);
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
    return emit.onEach(
      provider.user,
      onData: (u) => emit(state.copyWith(currentUser: u)),
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
      onData: (u) => emit(state.copyWith(currentUser: box.get(userBoxKey))),
      onError: (error, _) {
        debugPrint("❗️ Subscribe To Hive User Error: ${error.toString()}");
      },
    );
  }
}
