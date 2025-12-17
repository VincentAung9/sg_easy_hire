import 'package:sg_easy_hire/models/UserRole.dart';

class ConfirmSignUpParam {
  final String phone;
  final String code;
  final String fullName;
  final UserRole role;
  const ConfirmSignUpParam({
    required this.phone,
    required this.code,
    required this.fullName,
    required this.role,
  });
}
