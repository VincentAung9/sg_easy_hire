import 'dart:async';
import 'package:flutter/material.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<void> _subscription;
  GoRouterRefreshStream(Stream<void> stream) {
    _subscription = stream.listen((_) {
      debugPrint("🌈SignIn Box Event Change Fire");
      notifyListeners();
    });
  }

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
