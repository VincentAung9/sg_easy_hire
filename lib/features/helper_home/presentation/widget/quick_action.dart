import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimaryLight,
            fontWeight: FontWeight.bold,
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            Expanded(
              flex: 2,
              child: GridView.count(
                padding: const EdgeInsets.only(top: 15),
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  ActionItem(
                    icon: Icons.person_outline,
                    label: "Update Biodata",
                    color: AppColors.primary,
                    onPressed: () => context.go(RoutePaths.personalInformation),
                  ),
                  ActionItem(
                    icon: Icons.psychology_alt,
                    label: "Personality Test",
                    color: AppColors.primary,
                    onPressed: () =>
                        context.goNamed(RouteNames.personalityTest),
                  ),
                  ActionItem(
                    icon: Icons.description,
                    label: "Guidelines",
                    color: AppColors.primary,
                    onPressed: () {},
                  ),
                  ActionItem(
                    icon: Icons.upload_file,
                    label: "Upload Documents",
                    color: AppColors.primary,
                    onPressed: () =>
                        context.goNamed(RouteNames.uploadDocuments),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1.1 / 2, // Match height of 2 grid items
                child: InkWell(
                  onTap: () => context.goNamed(RouteNames.jobs),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                            (0.3 * 255).toInt(),
                            (AppColors.primary.r * 255).round(),
                            (AppColors.primary.g * 255).round(),
                            (AppColors.primary.b * 255).round(),
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha((0.2 * 255).toInt()),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Search Jobs",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
