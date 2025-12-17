import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/features/auth/models/sign_up_return.dart';

part 'verify_code_state.freezed.dart';

enum VerifyStatus { initial, loading, needCodeRequest, success, failure }

enum VerifyActions { none, verify, resendCode }

@freezed
class VerifyCodeState with _$VerifyCodeState {
  factory VerifyCodeState({
    SignUpReturnType? signUpReturnType,
    @Default(VerifyStatus.initial) VerifyStatus status,
    @Default(VerifyActions.none) VerifyActions actions,
  }) = _VerifyCodeState;
}
