import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class InterviewDetailItem extends StatelessWidget {
  final String label;
  final String value;
  const InterviewDetailItem({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondaryLight,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textTheme.titleSmall?.copyWith(
              color: AppColors.textPrimaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
