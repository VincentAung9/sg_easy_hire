import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/helper_home/repository/helper_home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HelperHomeRepository repository;
  HomeBloc({
    required this.repository,
  }) : super(HomeState()) {
    on<StartListenNextInterview>(_onStartListenNextInterview);
  }

  FutureOr<void> _onStartListenNextInterview(
    StartListenNextInterview event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        action: HomeStateActions.nextInterview,
        status: HomeStateStatus.pending,
      ),
    );
    return emit.onEach(
      repository.nextInterview,
      onData: (interview) => emit(
        state.copyWith(nextInterview: interview, status: HomeStateStatus.none),
      ),
      onError: (error, _) {
        debugPrint("Listen next interview error: $error");
      },
    );
  }
}
