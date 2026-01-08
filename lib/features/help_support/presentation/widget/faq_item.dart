import 'package:flutter/material.dart';

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;
  const FAQItem({required this.question, required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      collapsedShape: const RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      tilePadding: const EdgeInsets.all(5),
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 16),
      title: Text(question, style: const TextStyle(fontSize: 16)),
      children: [
        Text(
          answer,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
