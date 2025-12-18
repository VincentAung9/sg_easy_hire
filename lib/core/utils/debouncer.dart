import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(VoidCallback callback) {
    // 1. Cancel the previous timer if it exists.
    _timer?.cancel();

    // 2. Start a new timer.
    // The callback will only execute after the 'delay' if no new calls are made.
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}
