import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class CountryCodeDropdown extends StatelessWidget {
  const CountryCodeDropdown({
    required this.onChanged,
    required this.selectedCountryCode,
    super.key,
  });
  final void Function(CountryCode) onChanged;
  final CountryCode? selectedCountryCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 52,
      decoration: theme.extension<ContainerTheme>()?.card.copyWith(
        boxShadow: [],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        border: const Border(
          top: BorderSide(
            color: AppColors.borderLight,
          ),
          bottom: BorderSide(
            color: AppColors.borderLight,
          ),
          left: BorderSide(
            color: AppColors.borderLight,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<CountryCode>(
          isExpanded: true,

          items: countryCodeList
              .map(
                (CountryCode item) => DropdownMenuItem<CountryCode>(
                  value: item,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        item.flag,
                        style: theme.textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        item.code,
                        style: theme.textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          value: selectedCountryCode,
          onChanged: (value) {
            if (!(value == null)) {
              onChanged(value);
            }
          },
          buttonStyleData: const ButtonStyleData(
            height: 50,
            width: 80,
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            iconEnabledColor: Colors.grey,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 100,
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
      ),
      /* DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCountryCode,
          items: countryCodes.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (v) {
            if (v != null) {
              onChanged(v);
            }
          },
          style: theme.textTheme.bodyLarge,
          icon: const Icon(
            Icons.expand_more,
            color: AppColors.secondaryTextColor,
          ),
        ),
      ), */
    );
  }



}
