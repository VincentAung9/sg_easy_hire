import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ToastFuture? _activeToast;
void _dismissToast() {
  final toast = _activeToast;
  if (toast == null) return;
  if (!toast.isShow) return;

  toast.dismiss();
  _activeToast = null;
}

void showSuccess(BuildContext context, String message) {
  _dismissToast();
  final size = MediaQuery.of(context).size;
  _activeToast = showToastWidget(
    context: context,
    isIgnoring: false,
    animation: StyledToastAnimation.slideFromRight,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    Container(
      height: 60,
      width: size.width * 0.9, // 80% of screen width
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const InkWell(
              onTap: _dismissToast,
              child: Icon(
                Icons.clear,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showWarning(BuildContext context, String message) {
  _dismissToast();
  final size = MediaQuery.of(context).size;
  _activeToast = showToastWidget(
    context: context,
    isIgnoring: false,
    animation: StyledToastAnimation.slideFromRight,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    Container(
      height: 60,
      width: size.width * 0.9,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amber,
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const InkWell(
              onTap: _dismissToast,
              child: Icon(
                Icons.clear,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showError(BuildContext context, String message) {
  _dismissToast();
  final size = MediaQuery.of(context).size;
  _activeToast = showToastWidget(
    context: context,
    isIgnoring: false,
    animation: StyledToastAnimation.slideFromRight,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    Container(
      height: 60,
      width: size.width * 0.9,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const InkWell(
              onTap: _dismissToast,
              child: Icon(
                Icons.clear,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showNoti(BuildContext context, String title, String body) {
  _dismissToast();
  final size = MediaQuery.of(context).size;
  _activeToast = showToastWidget(
    context: context,
    isIgnoring: false,
    animation: StyledToastAnimation.slideFromRight,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 30),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    Container(
      height: 86,
      width: size.width * 0.9, // 80% of screen width
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.bell,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const InkWell(
                  onTap: _dismissToast,
                  child: Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Expanded(
                child: Text(
                  body,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
