import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class CustomCheckboxItem extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  const CustomCheckboxItem({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardLight,
          border: Border.all(color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(
                color: AppColors.checkboxBorderLight,
                width: 2,
              ),
              visualDensity: VisualDensity.standard,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimaryLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
