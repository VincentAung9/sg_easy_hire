import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/route_paths.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class HelperInterviewTabBar extends StatelessWidget {
  const HelperInterviewTabBar({
    super.key,
    required this.selectedIndex,
  });
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => context.go(RoutePaths.helperInterviewPending),
              style: TextButton.styleFrom(
                backgroundColor: selectedIndex == 0
                    ? AppColors.primary
                    : Colors.transparent,
                foregroundColor: selectedIndex == 0
                    ? Colors.white
                    : Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                "Pending",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Expanded(
            child: TextButton(
              onPressed: () => context.go(RoutePaths.helperInterviewAccepted),
              style: TextButton.styleFrom(
                backgroundColor: selectedIndex == 1
                    ? AppColors.primary
                    : Colors.transparent,
                foregroundColor: selectedIndex == 1
                    ? Colors.white
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                "Accepted",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          Expanded(
            child: TextButton(
              onPressed: () => context.go(RoutePaths.helperInterviewCompleted),
              style: TextButton.styleFrom(
                backgroundColor: selectedIndex == 2
                    ? AppColors.primary
                    : Colors.transparent,
                foregroundColor: selectedIndex == 2
                    ? Colors.white
                    : Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                "Completed",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () => context.go(RoutePaths.helperInterviewsCancelled),
              style: TextButton.styleFrom(
                backgroundColor: selectedIndex == 2
                    ? AppColors.primary
                    : Colors.transparent,
                foregroundColor: selectedIndex == 2
                    ? Colors.white
                    : Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                "Cancelled",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
