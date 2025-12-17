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
  Stream<User> get user {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    debugPrint("🌈 Current User ID: ${hiveUser?.id}");
    return Amplify.DataStore.observe(
      User.classType,
      where: User.ID.eq(hiveUser?.id),
    ).map((u) {
      debugPrint("🌈 Current User Data Change Event: ${u.item.toJson()}");
      box.put(userBoxKey, u.item);
      return u.item;
    });
  }
}
