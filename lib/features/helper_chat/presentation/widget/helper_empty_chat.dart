import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

/* class AppColors {
  static const Color primary = Color(0xFF00A699); // Teal primary color
  static const Color background = Color(0xFFF8FAFC); // Light background
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color accent = Color(0xFFFF6B6B); // Coral for the sparkle icon
  static const Color tipBackground = Color(0xFFE0F7F5);
}
 */
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
        /*      const SizedBox(height: 60),

        // Quick Tip card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.tipBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: AppColors.primary,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick Tip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "When an employer is interested in your profile, they'll reach out through messages. Keep your biodata updated!",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    */
      ],
    );
  }
}
