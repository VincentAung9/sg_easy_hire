import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/route_paths.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';

class HelperInterviewTabBar extends StatelessWidget {
  const HelperInterviewTabBar({
    super.key,
    required this.selectedIndex,
  });
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
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
              onPressed: () => context.goNamed(
                RouteNames.helperInterviews,
                queryParameters: {"status": RoutePaths.helperInterviewPending},
              ),
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
              child: Text(
                t.helperInterviews_tabPending,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Expanded(
            child: TextButton(
              onPressed: () => context.goNamed(
                RouteNames.helperInterviews,
                queryParameters: {"status": RoutePaths.helperInterviewAccepted},
              ),
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
              child: Text(
                t.helperInterviews_tabAccepted,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Expanded(
            child: TextButton(
              onPressed: () => context.goNamed(
                RouteNames.helperInterviews,
                queryParameters: {
                  "status": RoutePaths.helperInterviewCompleted,
                },
              ),
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
              child: Text(
                t.helperInterviews_tabCompletedCancelled,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          /*   Expanded(
            child: TextButton(
              onPressed: () => context.goNamed(
                RouteNames.helperInterviews,
                queryParameters: {
                  "status": RoutePaths.hellperInterviewCancelled,
                },
              ),
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
          ), */
        ],
      ),
    );
  }
}
