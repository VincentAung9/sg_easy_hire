import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/features/auth/models/sign_up_return.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  factory SignUpState({
    SignUpReturnType? signUpReturnType,
    @Default(false) bool isPending,
    @Default(false) bool isError,
    @Default(false) bool isSuccess,
  }) = _SignUpState;
}
