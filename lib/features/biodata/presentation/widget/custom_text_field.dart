import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isRequired;
  final IconData? suffixIcon;
  final bool isFirstTimePressed;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool? isReadOnly;
  final void Function()? onTap;
  const CustomTextField({
    required this.label,
    required this.placeholder,
    required this.controller,
    required this.isFirstTimePressed,
    this.suffixIcon,
    this.onTap,
    this.isRequired = false,
    this.isReadOnly = false,
    this.keyboardType,
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
              color: AppColors.textSecondaryLight,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: " *",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: isReadOnly ?? false,
          controller: controller,
          keyboardType: keyboardType,
          onTap: onTap,

          style: const TextStyle(color: AppColors.textPrimaryLight),

          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: AppColors.inputPlaceholderLight),
            filled: true,
            fillColor: AppColors.cardLight,
            suffixIcon: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    color: AppColors.textSecondaryLight,
                    size: 20,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
        ),

        InputError(
          isError: isRequired && isFirstTimePressed && controller.text.isEmpty,
          error: "$label is required",
        ),
      ],
    );
  }
}
