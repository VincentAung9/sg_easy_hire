import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/auth_repository.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_up/sign_up_event.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.authRepository}) : super(SignUpState()) {
    on<SignUpPressEvent>(_onSignUpPress);
  }
  final AuthRepository authRepository;

  FutureOr<void> _onSignUpPress(
    SignUpPressEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isPending: true));
    final result = await authRepository.signUpUserWithPhone(event.param);
    if (result.error != null || (result.error?.isNotEmpty ?? false)) {
      emit(
        state.copyWith(
          isPending: false,
          isError: true,
          signUpReturnType: result,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isPending: false,
          isSuccess: true,
          signUpReturnType: result,
        ),
      );
    }
  }
}
