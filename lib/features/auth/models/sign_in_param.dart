import 'package:sg_easy_hire/models/UserRole.dart';

class SignInParam {
  const SignInParam({required this.phone, required this.password,this.role});
  final String phone;
  final String password;
  final UserRole? role;
}
