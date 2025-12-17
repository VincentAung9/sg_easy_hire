import 'package:amplify_flutter/amplify_flutter.dart';

class SignUpReturnType {
  final SignUpResult? result;
  final String? error;
  SignUpReturnType({this.result, this.error});
}