import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/features/auth/models/models.dart';
import 'package:sg_easy_hire/models/User.dart';
import 'package:sg_easy_hire/models/UserRole.dart';

class AuthProvider {
  Future<SignUpReturnType> signUpUserWithEmail(SignUpParam param) async {
    try {
      final userAttributes = {
        // Pass the phone number as a required user attribute
        //AuthUserAttributeKey.phoneNumber: param.phone,
        AuthUserAttributeKey.name: param.fullName,
        AuthUserAttributeKey.preferredUsername: param.fullName,
        AuthUserAttributeKey.email: param.phone, //'${param.phone}@gmail.com',
        AuthUserAttributeKey.phoneNumber: "+660993457936",
      };

      final result = await Amplify.Auth.signUp(
        username: param.phone, // Use phone number as the username
        password: param.password,
        options: SignUpOptions(userAttributes: userAttributes),
      );

      debugPrint(
        '🔥 Phone sign up successful. Confirmation code sent to email.',
      );
      return SignUpReturnType(result: result);
    } on AuthException catch (e) {
      debugPrint('🔥 Phone sign up failed: ${e.message}');
      return SignUpReturnType(error: e.message);
    }
  }

  Future<SignInReturnType> signInUserWithEmail(SignInParam param) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: param.phone, // or email, depending on your setup
        password: param.password,
      );

      safePrint("🌈 Sign in successful. Cleaning local store...");
      return SignInReturnType(result: result);
    } on AuthException catch (e) {
      debugPrint('🔥 Email sign in failed: ${e.message}');
      return SignInReturnType(error: e.message);
    }
  }

  Future<SignUpReturnType> signUpUserWithPhone(SignUpParam param) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.phoneNumber: param.phone,
        AuthUserAttributeKey.name: param.fullName,
      };

      final result = await Amplify.Auth.signUp(
        username: param.phone,
        password: param.password,
        options: SignUpOptions(userAttributes: userAttributes),
      );

      debugPrint(
        '🔥 Phone sign up successful. Confirmation code sent to email.',
      );
      return SignUpReturnType(result: result);
    } on AuthException catch (e) {
      debugPrint('🔥 Phone sign up failed: ${e.message}');
      return SignUpReturnType(error: e.message);
    }
  }

  Future<SignInReturnType> signInUserWithPhone(SignInParam param) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: param.phone,
        password: param.password,
      );
      //after signin,we create user if don't have
      return SignInReturnType(result: result);
    } on AuthException catch (e) {
      debugPrint('🔥 Email sign in failed: ${e.message}');
      return SignInReturnType(error: e.message);
    }
  }

  Future<bool> signOut() async {
    try {
      final result = await Amplify.Auth.signOut();
      if (result is CognitoCompleteSignOut) {
        safePrint('Sign out completed successfully');
        return true;
      } else if (result is CognitoFailedSignOut) {
        safePrint('Error signing user out: ${result.exception.message}');
        return false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<UserAttributes?> getUserAttributes() async {
    try {
      final attrs = await Amplify.Auth.fetchUserAttributes();
      safePrint("🌈 User Attributes: ${attrs.toString()}");
      final sub = attrs
          .firstWhere((a) => a.userAttributeKey == AuthUserAttributeKey.sub)
          .value;
      final fullName = attrs
          .firstWhere((e) => e.userAttributeKey == AuthUserAttributeKey.name)
          .value;
      final phone = attrs
          .firstWhere(
            (e) => e.userAttributeKey == AuthUserAttributeKey.phoneNumber,
          )
          .value;
      return UserAttributes(cognitoId: sub, phone: phone, fullName: fullName);
    } catch (e) {
      safePrint("🔥 Attributes Error: ${e.toString()}");
      return null;
    }
  }

  Future<User?> createUser({
    required UserAttributes attributes,
    UserRole? role = UserRole.HELPER,
  }) async {
    try {
      final box = Hive.box<User>(name: userBox);
      final hiveUser = box.get(userBoxKey);
      final request = ModelQueries.list(
        User.classType,
        where: User.COGNITOID.eq(attributes.cognitoId),
      );

      final response = await Amplify.API.query(request: request).response;
      final userList = response.data;
      if (userList != null && userList.items.isNotEmpty) {
        final cloudUser = userList.items.first;
        safePrint(
          "✅ User exists in Cloud (ID: ${cloudUser?.id}). Waiting for Sync...",
        );
        return cloudUser;
      }
      // 3. If Cloud also says no, THEN create new
      safePrint("🆕 No record in Cloud or Local. Creating new...");
      final newUser = User(
        code: nanoid(10),
        cognitoId: attributes.cognitoId,
        role: role ?? UserRole.HELPER,
        fullName: attributes.fullName,
        phone: attributes.phone,
        deviceToken: hiveUser?.deviceToken,
        completeProgress: 0,
      );
      final saveRequest = ModelMutations.create(newUser);
      await Amplify.API.mutate(request: saveRequest).response;
      return newUser;
    } catch (e) {
      safePrint("❌ Error: $e");
      return null;
    }
  }

  Future<User?> updateUser({required User? user}) async {
    try {
      if (user == null) {
        return null;
      }
      final request = ModelMutations.update(user);
      await Amplify.API.mutate(request: request).response;
      return user;
    } catch (e) {
      safePrint("🔥 Update user failed: $e");
      return null;
    }
  }

  Future<Either<String, String>> resendCode(String phone) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: phone);
      return right('A new verification code has been sent to your phone.');
    } on AuthException catch (e) {
      debugPrint('🔥 Resend code failed: ${e.message}');
      return left(e.message);
    }
  }

  Future<SignUpReturnType> confirmCode(ConfirmSignUpParam param) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: param.phone,
        confirmationCode: param.code,
      );

      return SignUpReturnType(result: result);
    } on AuthException catch (e) {
      debugPrint('🔥 Signup confirmation code failed: ${e.message}');
      return SignUpReturnType(error: e.message);
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final attrs = await getUserAttributes();

      final createdUser = await createUser(attributes: attrs!);
      return createdUser;
    } catch (e) {
      safePrint("🔥 Create user failed: $e");
      return null;
    }
  }
}
