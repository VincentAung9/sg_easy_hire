import 'package:flutter/material.dart';

class JobTagComponent extends StatelessWidget {
  const JobTagComponent({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.blue[800], fontSize: 12),
      ),
    );
  }
}
