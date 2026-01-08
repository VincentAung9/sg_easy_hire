import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperSupportChatView extends StatelessWidget {
  const HelperSupportChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RoutePaths.home);
            }
          },
        ),
        title: const Text('Support Chat'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Online Support Indicator
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primaryPurple50,
                  child: Icon(
                    FontAwesomeIcons.circleCheck,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Support Online',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Ready to help you',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(FontAwesomeIcons.clock, color: Colors.grey[600]),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Prompt Text
          const Text(
            'What do you need help with?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Select a category to start chatting with our support team',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Category List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                SupportCategoryTile(
                  onTap: () {
                    context.push(
                      RoutePaths.supportChatType,
                      extra: RelatedModelType.HIRED_JOB,
                    );
                  },
                  icon: Icons.work_outline,
                  title: 'Hired Jobs',
                  subtitle: 'Issues related to your current or past employment',
                ),
                SupportCategoryTile(
                  onTap: () {
                    context.push(
                      RoutePaths.supportChatType,
                      extra: RelatedModelType.TRANSACTION,
                    );
                  },
                  icon: Icons.payment,
                  title: 'Transaction',
                  subtitle: 'Payment, salary, or financial concerns',
                ),
                SupportCategoryTile(
                  onTap: () {
                    context.push(
                      RoutePaths.supportChatType,
                      extra: RelatedModelType.DOCUMENT,
                    );
                  },
                  icon: Icons.description_outlined,
                  title: 'Documents',
                  subtitle: 'Document verification or upload issues',
                ),
                SupportCategoryTile(
                  onTap: () {
                    context.push(
                      RoutePaths.supportChatType,
                      extra: RelatedModelType.ACCOUNT,
                    );
                  },
                  icon: Icons.person_outline,
                  title: 'Account',
                  subtitle: 'Profile, settings, or account access',
                ),
                SupportCategoryTile(
                  onTap: () {
                    context.push(
                      RoutePaths.supportChatType,
                      extra: RelatedModelType.GENERAL,
                    );
                  },
                  icon: Icons.help_outline,
                  title: 'Other',
                  subtitle: 'General inquiries or other issues',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SupportCategoryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final void Function()? onTap;

  const SupportCategoryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryPurple50,
                child: Icon(icon, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
