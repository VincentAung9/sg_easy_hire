import 'package:flutter/material.dart';

class RadioOption extends StatelessWidget {
  final String title;
  final String value;
  final bool isSelected;
  final String? groupValue;
  final void Function()? onTap;
  final void Function(String?)? onChanged;
  const RadioOption({
    required this.title,
    required this.value,
    required this.isSelected,
    required this.groupValue,
    required this.onTap,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(12.0), // p-4 in HTML
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: isSelected ? const Color(0xFF0052FF) : Colors.grey[300]!,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: const Color(0xFF0052FF),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
