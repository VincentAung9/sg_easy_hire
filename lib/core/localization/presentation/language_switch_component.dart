import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sg_easy_hire/core/localization/data/language_switch_model.dart';
import 'package:sg_easy_hire/core/localization/domain/language_switch_cubit.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class LanguageSwitchComponent extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsets? padding;
  const LanguageSwitchComponent({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final color = backgroundColor ?? Colors.transparent;
    final theme = Theme.of(context);
    return Container(
      height: 30.h,
      decoration: theme.extension<ContainerTheme>()?.card.copyWith(
        boxShadow: [],
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border(
          top: BorderSide(
            color: color,
          ),
          bottom: BorderSide(
            color: color,
          ),
          left: BorderSide(
            color: color,
          ),
        ),
      ),
      padding: padding ?? EdgeInsets.zero,
      child: BlocBuilder<LanguageSwitchCubit, String>(
        builder: (context, lang) {
          return DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              customButton: SizedBox(
                width: 80.w,
                child: Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      flags(lang),
                      style: theme.textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 24,
                      color: iconColor ?? Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
              items: languages
                  .map(
                    (LanguageSwitchModel item) => DropdownMenuItem<String>(
                      value: item.lang,
                      child: Row(
                        spacing: 10,
                        children: [
                          Text(
                            item.flag,
                            style: theme.textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.label,
                            style: theme.textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              value: lang,
              onChanged: (value) {
                if (!(value == null)) {
                  context.read<LanguageSwitchCubit>().change(value);
                }
              },
              buttonStyleData: ButtonStyleData(
                /* height: 50,
                width: 80, */
                width: 160.w,
                elevation: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (states) {
                    if (states.contains(WidgetState.pressed)) {
                      // ignore: deprecated_member_use
                      return AppColors.primary.withOpacity(0.25); // click color
                    }
                    if (states.contains(WidgetState.hovered)) {
                      // ignore: deprecated_member_use
                      return Colors.grey.withOpacity(0.15); // hover color
                    }
                    return null;
                  },
                ),
              ),

              iconStyleData: const IconStyleData(
                iconEnabledColor: Colors.grey,
                iconDisabledColor: Colors.grey,
                iconSize: 0,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                width: 140.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(0),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
