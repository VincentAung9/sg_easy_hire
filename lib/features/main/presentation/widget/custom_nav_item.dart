import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final StatefulNavigationShell navigationShell;

  const CustomNavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = navigationShell.currentIndex == index;
    final color = isSelected ? AppColors.primary : AppColors.textSecondaryLight;
    final fontWeight = isSelected ? FontWeight.bold : FontWeight.w500;

    return Expanded(
      child: InkWell(
        onTap: () => navigationShell.goBranch(index),
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
            ), // smaller vertical padding
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center items vertically
              children: [
                Icon(icon, color: color, size: isSelected ? 24 : 20),
                const SizedBox(
                  height: 5,
                ), // Adjust spacing between icon and text
                AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 200),
                  style: TextStyle(
                    color: color,
                    fontSize: isSelected ? 12 : 11,
                    fontWeight: fontWeight,
                    letterSpacing: isSelected ? 0.2 : 0.1,
                  ),
                  child: Text(label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
