import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/widgets/input_error.dart';

class CustomFormDropDown extends StatelessWidget {
  final String label;
  final String placeholder;
  final List<String> items;
  final bool isRequired;
  final void Function(String?) onChanged;
  final String? initialValue;
  final bool isFirstTimePressed;
  const CustomFormDropDown({
    required this.label,
    required this.placeholder,
    required this.items,
    this.isRequired = false,
    required this.isFirstTimePressed,
    required this.onChanged,
    required this.initialValue,
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
        DropdownButtonFormField<String>(
          validator: (v) {
            if (isRequired && (v == null || v.isEmpty)) {
              return "";
            } else {
              return null;
            }
          },
          initialValue: initialValue,
          hint: Text(
            placeholder,
            style: const TextStyle(color: AppColors.inputPlaceholderLight),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: onChanged,
          style: const TextStyle(
            color: AppColors.textPrimaryLight,
            fontSize: 16,
            fontFamily: 'Inter',
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cardLight,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
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

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2.0,
              ),
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondaryLight,
          ),
        ),

        InputError(
          padding: EdgeInsets.zero,
          isError: isRequired && isFirstTimePressed && initialValue == null,
          error: "$label is required",
        ),
      ],
    );
  }
}
