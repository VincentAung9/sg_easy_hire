import 'package:sg_easy_hire/features/auth/models/sign_in_param.dart';

class SignInEvent {}

class SignInPressEvent extends SignInEvent {
  SignInPressEvent({required this.signInParam});
  SignInParam signInParam;
}

class SignInResendCodeEvent extends SignInEvent {
  final String phone;
  SignInResendCodeEvent({required this.phone});
}
