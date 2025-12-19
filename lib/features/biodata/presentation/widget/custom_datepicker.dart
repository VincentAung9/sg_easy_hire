import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_text_field.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final bool isFirstTimePressed;
  final void Function(DateTime? result) onChange;
  const CustomDatePicker({
    required this.initialDate,
    required this.onChange,
    required this.isFirstTimePressed,
    super.key,
  });
  Future<DateTime?> _showDatePicker({
    required BuildContext context,
    required DateTime? initialDate,
  }) {
    return showGeneralDialog<DateTime?>(
      context: context,
      barrierDismissible: true,
      fullscreenDialog: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),

      pageBuilder: (ctx, anim1, anim2) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(0),

          content: CalendarDatePicker2(
            config: CalendarDatePicker2Config(),
            value: [initialDate],
            onValueChanged: (dates) => Navigator.pop(context, dates.first),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      isFirstTimePressed: isFirstTimePressed,
      onTap: () async {
        debugPrint("🌈 ON CLICK...");
        final result = await _showDatePicker(
          context: context,
          initialDate: initialDate,
        );
        if (!(result == null)) {
          onChange(result);
        }
      },
      controller: TextEditingController(
        text: initialDate == null
            ? ""
            : DateFormat('dd/MM/yyyy').format(initialDate!),
      ),
      label: "Date of Birth",
      placeholder: "dd/mm/yyyy",
      isRequired: true,
      isReadOnly: true,
      suffixIcon: Icons.calendar_today_outlined,
    );
  }
}
