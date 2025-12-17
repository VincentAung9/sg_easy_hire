import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/auth_repository.dart';
import 'package:sg_easy_hire/features/auth/domain/auth_change/auth_change_event.dart';
import 'package:sg_easy_hire/features/auth/domain/auth_change/auth_change_state.dart';

class AuthChangeBloc extends Bloc<AuthChangeEvent, AuthChangeState> {
  final AuthRepository authRepository;
  AuthChangeBloc({required this.authRepository}) : super(AuthChangeState()) {
    on<StartSubscribeAuthChangeEvent>(_onStartSubscribeAuthChange);
  }

  FutureOr<void> _onStartSubscribeAuthChange(
    StartSubscribeAuthChangeEvent event,
    Emitter<AuthChangeState> emit,
  ) async {
    await emit.forEach(
      authRepository.user,
      onData: (user) => state.copyWith(user: user),
    );
  }
}
