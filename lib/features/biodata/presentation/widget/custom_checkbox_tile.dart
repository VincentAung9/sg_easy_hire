import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String inputKey;
  final String label;
  final void Function()? onTap;
  final Map<String, bool> items;
  final void Function(bool?)? onChanged;
  const CustomCheckboxTile({
    required this.inputKey,
    required this.label,
    required this.items,
    required this.onChanged,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // rounded-lg
        side: const BorderSide(color: AppColors.borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ), // p-3
          child: Row(
            children: [
              Checkbox(
                value: items[inputKey],
                onChanged: onChanged,
                activeColor: AppColors.primary,
                side: const BorderSide(
                  color: Color(0xFF94a3b8), // slate-400
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF334155), // slate-700
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
