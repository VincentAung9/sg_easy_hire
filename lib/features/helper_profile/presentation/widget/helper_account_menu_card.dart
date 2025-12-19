import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class HelperAccountMenuCard extends StatelessWidget {
  const HelperAccountMenuCard({super.key, required this.items});
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 10),
        ],
      ),
      child: Column(children: items),
    );
  }
}
