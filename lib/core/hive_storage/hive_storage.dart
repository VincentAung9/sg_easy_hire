import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';

const userBoxKey = 'current_user';

class AuthLocalDataSource {
  final Box<bool> box;

  AuthLocalDataSource(this.box);

  bool get isLoggedIn => box.get(isSignIn) != null;

  Stream<void> get authChanges => box.watch();
}
