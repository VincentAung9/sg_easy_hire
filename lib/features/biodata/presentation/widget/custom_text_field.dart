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
  final int maxLines;
  final TextStyle? labelStyle;
  final String? Function(String?)? customValidator;
  final bool? customIsError;
  final String? customError;
  const CustomTextField({
    required this.label,
    required this.placeholder,
    required this.controller,
    required this.isFirstTimePressed,
    this.suffixIcon,
    this.onTap,
    this.isRequired = false,
    this.isReadOnly = false,
    this.maxLines = 1,
    this.keyboardType,
    this.labelStyle,
    this.customValidator,
    this.customIsError,
    this.customError,
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
            style:
                labelStyle ??
                const TextStyle(
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
          maxLines: maxLines,
          readOnly: isReadOnly ?? false,
          controller: controller,
          keyboardType: keyboardType,
          onTap: onTap,

          style: const TextStyle(color: AppColors.textPrimaryLight),
          validator:
              customValidator ??
              (v) {
                if (isRequired && (v?.isEmpty ?? false)) {
                  return "";
                } else {
                  return null;
                }
              },
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: AppColors.inputPlaceholderLight),
            filled: true,
            fillColor: AppColors.cardLight,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
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
          padding: EdgeInsets.zero,
          isError:
              customIsError ??
              isRequired && isFirstTimePressed && controller.text.isEmpty,
          error: customError ?? "$label is required",
        ),
      ],
    );
  }
}
