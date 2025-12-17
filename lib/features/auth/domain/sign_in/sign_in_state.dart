import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/features/auth/models/models.dart';

part 'sign_in_state.freezed.dart';

enum SignInStatus { initial, loading, needCodeRequest, success, failure }

enum SignInActions { none, signin, resendCode }

@freezed
class SignInState with _$SignInState {
  factory SignInState({
    SignInReturnType? signInReturnType,
    String? requestCodeMessage,
    @Default(SignInStatus.initial) SignInStatus status,
    @Default(SignInActions.none) SignInActions action,
  }) = _SignInState;
}
