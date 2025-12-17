import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/auth_repository.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_in/sign_in_event.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_in/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this.authRepository}) : super(SignInState()) {
    on<SignInPressEvent>(_onSignInPress);
    on<SignInResendCodeEvent>(_onSignInResendCode);
  }
  final AuthRepository authRepository;

  FutureOr<void> _onSignInPress(
    SignInPressEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SignInStatus.loading,
        action: SignInActions.signin,
      ),
    );
    final response = await authRepository.signInUserWithPhone(
      event.signInParam,
    );
    if (response.error != null || (response.error?.isNotEmpty ?? false)) {
      emit(
        state.copyWith(
          status: SignInStatus.failure,
          action: SignInActions.signin,
          signInReturnType: response,
        ),
      );
    } else if (response.result?.nextStep.signInStep ==
        AuthSignInStep.confirmSignUp) {
      emit(
        state.copyWith(
          status: SignInStatus.needCodeRequest,
          action: SignInActions.signin,
          signInReturnType: response,
          requestCodeMessage:
              'Your sign-up isn’t complete. Please verify your phone number to continue.',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: SignInStatus.success,
          action: SignInActions.signin,
          signInReturnType: response,
        ),
      );
    }
  }

  FutureOr<void> _onSignInResendCode(
    SignInResendCodeEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SignInStatus.loading,
        action: SignInActions.resendCode,
      ),
    );
    final response = await authRepository.resendCode(phone: event.phone);
    response.fold(
      (error) => emit(
        state.copyWith(
          status: SignInStatus.failure,
          requestCodeMessage: error,
          action: SignInActions.resendCode,
        ),
      ),
      (success) => emit(
        state.copyWith(
          status: SignInStatus.success,
          action: SignInActions.resendCode,
          requestCodeMessage: success,
        ),
      ),
    );
  }
}
