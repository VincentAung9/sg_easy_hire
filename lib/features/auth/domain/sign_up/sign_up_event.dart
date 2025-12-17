import 'package:sg_easy_hire/features/auth/models/sign_up_param.dart';

class SignUpEvent {}

class SignUpPressEvent extends SignUpEvent {
  SignUpPressEvent({required this.param});
  final SignUpParam param;
}
