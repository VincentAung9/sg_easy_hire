import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/box_keys.dart';
import 'package:sg_easy_hire/models/User.dart';

class HelperCoreProvider {
  factory HelperCoreProvider() => const HelperCoreProvider._();
  const HelperCoreProvider._();

  Future<void> updateUser(User user) async {
    try {
      await Amplify.DataStore.save(user);
      debugPrint("🌈 User is updated");
    } on DataStoreException catch (e) {
      debugPrint("❗️ User Update Error: $e");
    }
  }

  //list profile
  Stream<User?> get user {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    debugPrint("🌈 Current User ID: ${hiveUser?.id}");
    final subscriptionRequest = ModelSubscriptions.onUpdate(
      User.classType,
      where: User.ID.eq(hiveUser?.id),
    );
    return Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () => safePrint('Subscription established'),
        )
        .map((u) {
          if (!(u.data == null)) {
            box.put(userBoxKey, u.data!);
          }
          return u.data;
        });
  }
}
