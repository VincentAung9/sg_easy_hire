import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/auth_repository.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_out/sign_out_event.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_out/sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  SignOutBloc({required this.authRepository}) : super(SignOutState()) {
    on<SignOutPressEvent>(_onSignOut);
  }
  final AuthRepository authRepository;

  FutureOr<void> _onSignOut(
    SignOutPressEvent event,
    Emitter<SignOutState> emit,
  ) async {
    emit(state.copyWith(isPending: true));
    final result = await authRepository.signOut();
    if (result) {
      emit(state.copyWith(isPending: false, isSuccess: true));
    } else {
      emit(state.copyWith(isPending: false, isError: true));
    }
  }
}
