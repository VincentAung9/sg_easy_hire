import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sg_easy_hire/core/widgets/input_error.dart';

class BuildUploadBox extends StatelessWidget {
  final String label;
  final IconData icon;
  final String subtitle;
  final bool isRequired;
  final bool isOptional;
  final void Function()? onTap;
  final bool isError;
  const BuildUploadBox({
    required this.label,
    required this.icon,
    required this.subtitle,
    this.isRequired = false,
    this.isOptional = false,
    this.isError = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: AppColors.textLabelLight,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
              if (isOptional)
                const TextSpan(
                  text: " (Optional)",
                  style: TextStyle(
                    color: AppColors.textSecondaryLight,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            color: isError ? Colors.red : AppColors.borderDashedLight,
            strokeWidth: 2,
            dashPattern: const [6, 6],
            child: Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 40, color: AppColors.textIconLight),
                    const SizedBox(height: 8),
                    Text(
                      "Click to upload ${label.toLowerCase().split('(').first.trim()}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textLabelLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondaryLight,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        InputError(
          isError: isError,
          error: "$label is required.",
        ),
      ],
    );
  }
}
