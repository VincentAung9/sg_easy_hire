import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/repositories.dart';
import 'package:sg_easy_hire/features/auth/domain/verify_code/verify_code_event.dart';
import 'package:sg_easy_hire/features/auth/domain/verify_code/verify_code_state.dart';

class VerifyCodeBloc extends Bloc<VerifyCodeEvent, VerifyCodeState> {
  final AuthRepository authRepository;
  VerifyCodeBloc({required this.authRepository}) : super(VerifyCodeState()) {
    on<PressVerifyCodeEvent>(_onPressVerifyCode);
    on<ResendCodeEvent>(_onResendCode);
  }

  FutureOr<void> _onPressVerifyCode(
    PressVerifyCodeEvent event,
    Emitter<VerifyCodeState> emit,
  ) async {
    emit(
      state.copyWith(
        actions: VerifyActions.verify,
        status: VerifyStatus.loading,
      ),
    );
    final result = await authRepository.confirmCode(event.param);
    if (result.error?.isNotEmpty ?? false) {
      emit(
        state.copyWith(
          status: VerifyStatus.failure,
          actions: VerifyActions.verify,
          signUpReturnType: result,
        ),
      );
    } else {
      emit(
        state.copyWith(
          actions: VerifyActions.verify,
          status: VerifyStatus.success,
          signUpReturnType: result,
        ),
      );
    }
  }

  FutureOr<void> _onResendCode(
    ResendCodeEvent event,
    Emitter<VerifyCodeState> emit,
  ) async {
    emit(
      state.copyWith(
        actions: VerifyActions.resendCode,
        status: VerifyStatus.loading,
      ),
    );
    final result = await authRepository.resendCode(phone: event.phone);
    result.fold(
      (error) => emit(
        state.copyWith(
          actions: VerifyActions.resendCode,
          status: VerifyStatus.failure,
        ),
      ),
      (success) => emit(
        state.copyWith(
          actions: VerifyActions.resendCode,
          status: VerifyStatus.success,
        ),
      ),
    );
  }
}
