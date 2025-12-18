import 'package:flutter/material.dart';

class CountDownSeparator extends StatelessWidget {
  const CountDownSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        ":",
        style: TextStyle(
          color: Colors.grey[300],
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
