import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_out/sign_out_bloc.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_out/sign_out_event.dart';
import 'package:sg_easy_hire/features/helper_profile/presentation/widget/widget.dart';
import 'package:sg_easy_hire/features/job_offer/domain/joboffer_count_cubit.dart';

// 🔹 Reusable Animated Confirm Dialog
Future<bool?> _showAnimatedConfirmDialog({
  required BuildContext context,
  required String title,
  required Color titleColor,
  required String content,
  required IconData icon,
  required String confirmText,
  required Color confirmColor,
}) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (ctx, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, __) {
      final curvedValue = Curves.easeInOut.transform(anim.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -50, 0.0)
          ..scale(anim.value),
        child: Opacity(
          opacity: anim.value,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ),
            content: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.kSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton.icon(
                onPressed: () async {
                  //logout request
                  //TODO:GO TO SIGN IN
                  Navigator.of(ctx).pop(true);
                },
                icon: Icon(icon, color: Colors.white),
                label: Text(
                  confirmText,
                  style: const TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: confirmColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class HelperProfileView extends StatelessWidget {
  const HelperProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const HelperAccountSettingHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const HelperAccountJobSearch(),
                const SizedBox(height: 8),
                HelperAccountMenuCard(
                  items: [
                    HelperAccountMenuItem(
                      onTap: () => context.push(RoutePaths.personalInformation),
                      icon: Icons.person_outline,
                      iconBgColor: Colors.blue[100]!,
                      iconColor: AppColors.primary,
                      title: "Biodata",
                      subtitle: "Name, contact, nationality",
                    ),
                    HelperAccountMenuItem(
                      onTap: () => context.push(RoutePaths.uploadDocuments),
                      icon: Icons.description_outlined,
                      iconBgColor: Colors.blue[100]!,
                      iconColor: AppColors.primary,
                      title: "Documents",
                      subtitle: "Passport, certificates, medical",
                    ),
                    HelperAccountMenuItem(
                      onTap: () => context.push(RoutePaths.preferences),
                      icon: Icons.tune_outlined,
                      iconBgColor: Colors.blue[100]!,
                      iconColor: AppColors.primary,
                      title: "Preferences",
                      subtitle: "Salary, location, duties",
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                HelperAccountMenuCard(
                  items: [
                    HelperAccountMenuItem(
                      onTap: () => context.push(RoutePaths.jobOffers),
                      icon: Icons.work_outline,
                      iconBgColor: Colors.orange[100]!,
                      iconColor: Colors.orange[500]!,
                      title: "Job Offers",
                      subtitle: "View offers received from employers",
                      trailing: BlocBuilder<JobofferCountCubit, int>(
                        builder: (context, offerCount) {
                          return offerCount == 0
                              ? const SizedBox()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red[500],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "$offerCount New",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    /* HelperAccountMenuItem(
                      icon: Icons.bar_chart_outlined,
                      iconBgColor: Colors.green[100]!,
                      iconColor: Colors.green[500]!,
                      title: "Progress Tracking",
                      subtitle: "View hiring process status",
                      showDivider: false,
                    ), */
                  ],
                ),
                const SizedBox(height: 8),
                HelperAccountMenuCard(
                  items: [
                    HelperAccountMenuItem(
                      onTap: () => context.push(RoutePaths.helpSupport),
                      icon: Icons.help_outline,
                      iconBgColor: Colors.grey[200]!,
                      iconColor: AppColors.textGrayLight,
                      title: "Help & Support",
                      subtitle: "FAQs, contact agency",
                    ),
                    HelperAccountMenuItem(
                      onTap: () => context.push(RoutePaths.helperProfileUpdate),
                      icon: Icons.settings_outlined,
                      iconBgColor: Colors.grey[200]!,
                      iconColor: AppColors.textGrayLight,
                      title: "Settings",
                      subtitle: "Profile Manage",
                    ),
                    HelperAccountMenuItem(
                      icon: Icons.logout_outlined,
                      iconBgColor: Colors.grey[200]!,
                      iconColor: AppColors.textGrayLight,
                      title: "Log Out",
                      showDivider: false,
                      onTap: () async {
                        final confirmed = await _showAnimatedConfirmDialog(
                          context: context,
                          title: 'Logout',
                          titleColor: AppColors.kSecondaryColor,
                          content: 'Are you sure you want to logout?',
                          icon: Icons.logout,
                          confirmText: 'Logout',
                          confirmColor: AppColors.kSecondaryColor,
                        );
                        if (confirmed == true) {
                          context.read<SignOutBloc>().add(SignOutPressEvent());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logged out!')),
                          );
                          context.go(RoutePaths.helperSignin);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                HelperAccountMenuCard(
                  items: [
                    HelperAccountMenuItem(
                      icon: Icons.delete_outline,
                      iconBgColor: Colors.red[100]!,
                      iconColor: Colors.red[500]!,
                      title: "Delete Account",
                      subtitle: "Permanently remove your account",
                      showDivider: false,
                      onTap: () async {
                        final confirmed = await _showAnimatedConfirmDialog(
                          context: context,
                          title: 'Delete Account',
                          titleColor: Colors.red,
                          content:
                              'Are you sure you want to delete your account? This action cannot be undone.',
                          icon: Icons.delete,
                          confirmText: 'Delete',
                          confirmColor: Colors.red,
                        );
                        if (confirmed == true) {
                          context.read<SignOutBloc>().add(
                            DeleteAccountPressEvent(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Deleted account!')),
                          );
                          context.go(RoutePaths.helperSignin);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
