import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide AuthProvider;
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/features/auth/data/providers/auth_provider.dart';
import 'package:sg_easy_hire/features/auth/models/models.dart';
import 'package:sg_easy_hire/models/User.dart';

class AuthRepository {
  AuthRepository({required this.authProvider}) {
    _initAuthListener();
  }

  final AuthProvider authProvider;

  StreamSubscription<AuthHubEvent>? _hubSubscription;

  // 1. Create a single broadcast controller as a class member
  final _userController = StreamController<User?>.broadcast();

  // 2. Expose only the stream
  Stream<User?> get user => _userController.stream;

  void _initAuthListener() {
    final box = Hive.box<User>(name: userBox);
    final signBox = Hive.box<bool>(name: signInBox);

    // Seed the stream immediately with the current Hive value
    // so the UI isn't empty on app start
    _userController.add(box.get(userBoxKey));
    _hubSubscription?.cancel();
    _hubSubscription = Amplify.Hub.listen(HubChannel.Auth, (
      AuthHubEvent event,
    ) async {
      switch (event.type) {
        case AuthHubEventType.signedIn:
          signBox.put(isFirstTimeLoggedIn, true);
          signBox.put(isSignIn, true);
          safePrint('🌈 Hub: Signed In');
          final currentUser = await authProvider.getCurrentUser();
          if (currentUser != null) {
            box.put(userBoxKey, currentUser);
          }
          _userController.add(currentUser);
          break; // Use breaks!

        case AuthHubEventType.signedOut:
          safePrint('🌈 Hub: Signed Out Event (${event.type})');
          signBox.delete(isSignIn);
          box.delete(userBoxKey);
          break;
        case AuthHubEventType.sessionExpired:
          break;
        case AuthHubEventType.userDeleted:
          safePrint('🌈 Hub: Cleared Session (${event.type})');
          signBox.put(isSignIn, false);
          box.delete(userBoxKey);
          _userController.add(null);
          break;
      }
    });
  }

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
}
