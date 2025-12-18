import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';

class JobSearchDashboardStateItem extends StatelessWidget {
  const JobSearchDashboardStateItem({
    super.key,
    required this.value,
    required this.label,
  });
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.textWhite80,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
