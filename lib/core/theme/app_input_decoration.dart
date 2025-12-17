import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';

class AppInputDecoration {
  static InputDecoration phone({
    required String placeholder,
    BorderRadius? borderRadius,
  }) => InputDecoration(
    hintText: placeholder,
    hintStyle: const TextStyle(color: AppColors.secondaryTextColor),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius:
          borderRadius ??
          const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius:
          borderRadius ??
          const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius:
          borderRadius ??
          const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
      borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
    ),
  );

  static InputDecoration auth({required String placeholder}) => phone(
    placeholder: placeholder,
    borderRadius: const BorderRadius.all(Radius.circular(12)),
  );
}
