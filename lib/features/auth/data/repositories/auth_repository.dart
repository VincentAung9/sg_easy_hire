import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide AuthProvider;
import 'package:dartz/dartz.dart';
import 'package:sg_easy_hire/features/auth/data/providers/auth_provider.dart';
import 'package:sg_easy_hire/features/auth/models/models.dart';
import 'package:sg_easy_hire/models/User.dart';

class AuthRepository {
  AuthRepository({required this.authProvider});
  final AuthProvider authProvider;
  Future<SignUpReturnType> signUpUserWithPhone(SignUpParam param) async {
    return authProvider.signUpUserWithEmail(param);
  }

  Future<SignInReturnType> signInUserWithPhone(SignInParam param) async {
    return authProvider.signInUserWithEmail(param);
  }

  Future<bool> signOut() async {
    return authProvider.signOut();
  }

  Future<User?> updateUser({required User? user}) async {
    return authProvider.updateUser(user: user);
  }

  Future<Either<String, String>> resendCode({required String phone}) async {
    return authProvider.resendCode(phone);
  }

  Future<SignUpReturnType> confirmCode(ConfirmSignUpParam param) async {
    return authProvider.confirmCode(param);
  }

  Stream<User?> get user {
    final controller = StreamController<User?>();
    Amplify.Hub.listen(HubChannel.Auth, (AuthHubEvent event) async {
      switch (event.type) {
        case AuthHubEventType.signedIn:
          safePrint('User is signed in.');
          final currentUser = await authProvider.getCurrentUser();
          controller.add(currentUser);

        case AuthHubEventType.signedOut:
          safePrint('User is signed out.');
          controller.add(null);

        case AuthHubEventType.sessionExpired:
          safePrint('The session has expired.');
          controller.add(null);

        case AuthHubEventType.userDeleted:
          safePrint('The user has been deleted.');
          controller.add(null);
      }
    });

    return controller.stream;
  }
}
