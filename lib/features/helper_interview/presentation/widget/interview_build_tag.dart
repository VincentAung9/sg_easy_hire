import 'package:flutter/material.dart';

class InterviewBuildTag extends StatelessWidget {
  const InterviewBuildTag({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE), // blue-100
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF2563EB), // blue-600
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
