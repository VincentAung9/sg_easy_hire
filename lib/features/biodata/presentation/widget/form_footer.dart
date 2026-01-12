import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sg_easy_hire/core/localization/domain/language_switch_cubit.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';

class FormFooter extends StatelessWidget {
  final void Function()? onSave;
  final void Function()? onNext;
  final String? nextBtnString;
  final bool isNextLoading;
  final bool isSaveLoading;
  const FormFooter({
    required this.onNext,
    required this.onSave,
    required this.isNextLoading,
    required this.isSaveLoading,
    this.nextBtnString,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final my = context.read<LanguageSwitchCubit>().state == 'my';
    return Container(
      height: 100.h,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.cardLight, // bg-white
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ), // border-slate-200
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: my ? 2 : 1,
              child: OutlinedButton(
                onPressed: isSaveLoading | isNextLoading ? null : onSave,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: Colors.transparent),
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // rounded-lg
                  ),
                ),
                child: isSaveLoading
                    ? const ButtonLoading(
                        height: 20,
                        width: 20,
                        color: AppColors.primary,
                      )
                    : Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.saveDraft,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: isNextLoading || isSaveLoading ? null : onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: isNextLoading
                      ? const ButtonLoading(
                          height: 10,
                          width: 20,
                        )
                      : Text(
                          nextBtnString ?? t.next,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
