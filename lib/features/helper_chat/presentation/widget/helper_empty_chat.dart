import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/help_support/presentation/widget/support_card_contact.dart';

class HelperEmptyChat extends StatelessWidget {
  const HelperEmptyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        // Chat icon with gradient circle and sparkle
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.15),
                    AppColors.background.withOpacity(0.0),
                  ],
                ),
              ),
            ),
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 60,
                color: AppColors.primary,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.auto_awesome,
                size: 32,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Title
        Text(
          'No conversations yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),

        // Subtitle
        Text(
          'Apply to jobs and connect with employers to start chatting. Your conversations will appear here.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Browse Jobs button
        Container(
          width: double.infinity,
          height: 45.h,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () => context.go(RoutePaths.jobs),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.work_outline, size: 24),
                SizedBox(width: 12),
                Text(
                  'Browse Jobs',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Update Profile button
        Container(
          width: double.infinity,
          height: 45.h,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: OutlinedButton(
            onPressed: () => context.push(RoutePaths.personalInformation),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              side: BorderSide(
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, color: AppColors.textPrimary),
                const SizedBox(width: 12),
                Text(
                  'Update Biodata',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SupportCardContact(
            icon: FontAwesomeIcons.message,
            title: 'Admin Support',
            description: "24/7 Customer Service",
            subtitle: 'Need help? Chat with our support team',
            badgeText: 'Support',
            onTap: () => context.push(RoutePaths.helperSupportChat),
          ),
        ),
      ],
    );
  }
}
