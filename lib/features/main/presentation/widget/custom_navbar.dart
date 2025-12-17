import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/main/presentation/widget/custom_nav_item.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomNavBar({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.borderLight, width: 1.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Admin Nav Bar
            /*   CustomNavItem(
              icon: Symbols.dashboard,
              label: 'Dashboard',
              index: 0,
            ),
            CustomNavItem(icon: Symbols.work, label: 'Job', index: 1),
            CustomNavItem(
              icon: Symbols.calendar_check,
              label: 'Interview',
              index: 2,
            ),
            CustomNavItem(
              icon: Symbols.manage_accounts,
              label: 'Helper',
              index: 3,
            ),
            CustomNavItem(
              icon: Symbols.manage_accounts_rounded,
              label: 'Employer',
              index: 4,
            ),
            CustomNavItem(icon: Symbols.payment, label: 'Payment', index: 5), */
            //Tranning Center Nav Bar
            // CustomNavItem(icon: Symbols.groups, label: 'Employee', index: 0),
            // // CustomNavItem(icon: Symbols.fact_check, label: 'QC', index: 1),
            // CustomNavItem(icon: Symbols.show_chart, label: 'Progress', index: 1),
            // CustomNavItem(icon: Symbols.notifications, label: 'Notifications', index: 2),
            // CustomNavItem(icon: Symbols.person, label: 'Profile', index: 3),

            //Employer Nav Bar
            //CustomNavItem(icon: Symbols.groups, label: 'Employee', index: 0),
            /*  CustomNavItem(
              icon: Symbols.dashboard,
              label: 'Dashboard',
              routePath: RoutePaths.home,
            ),
            CustomNavItem(icon: Symbols.fact_check, label: 'QC', i),
            CustomNavItem(
              icon: Symbols.show_chart,
              label: 'Progress',
              index: 2,
            ),
            CustomNavItem(
              icon: Symbols.chat_bubble_rounded,
              label: 'Chat',
              index: 3,
            ),
            CustomNavItem(icon: Symbols.person, label: 'Profile', index: 4), */

            // HELPER
            CustomNavItem(
              icon: Symbols.home,
              label: 'Home',
              index: 0,
              navigationShell: navigationShell,
            ),
            CustomNavItem(
              icon: Symbols.search,
              label: 'Find',
              index: 1,
              navigationShell: navigationShell,
            ),
            CustomNavItem(
              icon: Symbols.calendar_check,
              label: 'Interview',
              index: 2,
              navigationShell: navigationShell,
            ),
            CustomNavItem(
              icon: Symbols.chat_bubble_rounded,
              label: 'Chat',
              index: 3,
              navigationShell: navigationShell,
            ),
            CustomNavItem(
              icon: Symbols.person,
              label: 'Profile',
              index: 4,
              navigationShell: navigationShell,
            ),
          ],
        ),
      ),
    );
  }
}
