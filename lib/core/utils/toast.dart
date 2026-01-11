import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void showSuccess(BuildContext context, String message) {
  showToastWidget(
    context: context,
    animation: StyledToastAnimation.slideFromRight,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    Container(
      height: 60,
      width: 80.sw,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.green.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Center(
        child: Row(
          spacing: 6,
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}

void showWarnning(BuildContext context, String message) {
  showToastWidget(
    context: context,
    animation: StyledToastAnimation.slideFromRight,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    Container(
      height: 60,
      width: 80.sw,
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
      child: Center(
        child: Row(
          spacing: 6,
          children: [
            const Icon(Icons.warning, color: Colors.white, size: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}

void showError(BuildContext context, String message) {
  showToastWidget(
    context: context,
    animation: StyledToastAnimation.slideFromRight,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.top,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    Container(
      height: 60,
      width: 80.sw,
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
      child: Center(
        child: Row(
          spacing: 6,
          children: [
            const Icon(Icons.error, color: Colors.white, size: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    ),
  );
}
