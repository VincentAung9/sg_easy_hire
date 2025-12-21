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
      ///await Amplify.DataStore.stop();
      final result = await Amplify.Auth.signIn(
        username: param.phone, // or email, depending on your setup
        password: param.password,
      );

      safePrint("🌈 Sign in successful. Cleaning local store...");

      ///await Amplify.DataStore.clear();
      // 3. Re-initialize and create user record
      final createdUser = await createUser(role: param.role);

      if (createdUser != null) {
        return SignInReturnType(result: result);
      } else {
        return SignInReturnType(error: "User creation failed");
      }
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
      safePrint("🌈 Creating user");
      final createdUser = await createUser(role: param.role);
      if (createdUser != null) {
        return SignInReturnType(result: result);
      } else {
        return SignInReturnType(error: "User creation failed");
      }
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

  Future<T?> performDataStoreOperation<T>(
    Future<T> Function() operation,
  ) async {
    try {
      // 1. Force refresh/check auth session
      final session = await Amplify.Auth.fetchAuthSession();

      if (!session.isSignedIn) {
        safePrint("User not signed in. Aborting DataStore operation.");
        return null;
      }

      // 2. Execute the operation
      return await operation();
    } on ApiException catch (e) {
      if (e.message.contains('Interrupted')) {
        safePrint("Auth token not ready, retrying in 2 seconds...");
        // ignore: inference_failure_on_instance_creation
        await Future.delayed(const Duration(seconds: 2));
        return await operation(); // Single retry
      }
      rethrow;
    } catch (e) {
      safePrint("Operation failed: $e");
      return null;
    }
  }

  Future<void> syncDataStoreSafely() async {
    try {
      // Force native side to resolve the Cognito session first
      final session = await Amplify.Auth.fetchAuthSession();

      if (session.isSignedIn) {
        // Start the engine
        await Amplify.DataStore.start();

        // Wait a short moment for the subscription websocket to open
        // This specifically prevents the 'Interrupted' semaphore error
        // ignore: inference_failure_on_instance_creation
        await Future.delayed(const Duration(seconds: 1));
      }
    } catch (e) {
      print("Sync Initialization Failed: $e");
    }
  }

  Future<User?> createUser({UserRole? role = UserRole.HELPER}) async {
    try {
      await syncDataStoreSafely();
      final attributes = await getUserAttributes();
      if (attributes == null) return null;
      final box = Hive.box<User>(name: userBox);
      final hiveUser = box.get(userBoxKey);

      // 1. Try Local DataStore first
      final localResults = await Amplify.DataStore.query(
        User.classType,
        where: User.COGNITOID.eq(attributes.cognitoId),
      );

      if (localResults.isNotEmpty) {
        safePrint("✅ User found in Local DataStore");
        return localResults.first;
      }

      // 2. FALLBACK: Query the Cloud directly via API (GraphQL)
      // This bypasses the DataStore sync lag completely
      safePrint("🔍 Not in local DB. Checking Cloud directly...");
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
        box.put(userBoxKey, cloudUser!);
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
      box.put(userBoxKey, newUser);
      await Amplify.DataStore.save(newUser);
      return newUser;
    } catch (e) {
      safePrint("❌ Error: $e");
      return null;
    }
    /*   try {
      // Ensure engine is running
      await syncDataStoreSafely();

      // Get attributes
      final attributes = await getUserAttributes();
      if (attributes == null) return null;

      final box = Hive.box<User>(name: userBox);
      final hiveUser = box.get(userBoxKey);

      // Use your wrapper to handle the "Interrupted" exception automatically
      final oldUserResponse = await Amplify.DataStore.query(
        User.classType,
        where: User.COGNITOID.eq(attributes.cognitoId),
      );
      debugPrint("🌈 Old User Response: ${oldUserResponse.toString()}");
      if (oldUserResponse.isNotEmpty) {
        box.put(userBoxKey, oldUserResponse.first);
        return oldUserResponse.first;
      } else {
        // Create new user object
        final user = User(
          code: nanoid(10),
          cognitoId: attributes.cognitoId,
          role: role ?? UserRole.HELPER,
          fullName: attributes.fullName,
          phone: attributes.phone,
          deviceToken: hiveUser?.deviceToken,
          completeProgress: 0,
        );
        // Save with the same protected wrapper
        await Amplify.DataStore.save(user);
        box.put(userBoxKey, user);
        return user;
      }
    } catch (e) {
      safePrint("🔥 Create user failed: $e");
      return null;
    } */
  }

  Future<User?> updateUser({required User? user}) async {
    try {
      if (user == null) {
        return null;
      }
      await Amplify.DataStore.save(user);
      return user;
    } on DataStoreException catch (e) {
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
      final attrs = await Amplify.Auth.fetchUserAttributes();

      final cognitoID = attrs
          .firstWhere((a) => a.userAttributeKey == CognitoUserAttributeKey.sub)
          .value;
      final user = await Amplify.DataStore.query(
        User.classType,
        where: User.COGNITOID.eq(cognitoID),
      );
      if (user.isEmpty) {
        return null;
      }
      return user.first;
    } on DataStoreException catch (e) {
      safePrint("🔥 Create user failed: $e");
      return null;
    }
  }
}
