import 'package:amplify_flutter/amplify_flutter.dart';

class SignInReturnType {
  final SignInResult? result;
  final String? error;
  SignInReturnType({this.result, this.error});
}
