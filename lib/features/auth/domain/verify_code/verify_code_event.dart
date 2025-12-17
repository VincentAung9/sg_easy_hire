import 'package:sg_easy_hire/features/auth/models/confirm_sign_up_param.dart';

class VerifyCodeEvent {}

class PressVerifyCodeEvent extends VerifyCodeEvent {
  final ConfirmSignUpParam param;
  PressVerifyCodeEvent({required this.param});
}

class ResendCodeEvent extends VerifyCodeEvent {
  final String phone;
  ResendCodeEvent({required this.phone});
}
