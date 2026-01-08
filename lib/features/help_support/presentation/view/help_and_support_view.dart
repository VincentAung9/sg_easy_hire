import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/features/help_support/presentation/widget/widget.dart';

class HelpAndSupportView extends StatelessWidget {
  const HelpAndSupportView({super.key});

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
        title: const Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            /* TextField(
              decoration: InputDecoration(
                hintText: 'Search for help...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ), */
            const SizedBox(height: 24),

            // Support Available Badge
            const SupportAvailable(),
            const SizedBox(height: 32),

            // Contact Us Section
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SupportCardContact(
              icon: Icons.chat_bubble_outline,
              title: 'Live Chat',
              subtitle: 'Chat with admin',
              buttonText: 'Start Chat',
              onTap: () => context.push(RoutePaths.helperSupportChat),
            ),
            SupportCardContact(
              icon: Icons.phone,
              title: 'Phone Support',
              subtitle: '+1 (800) 123-4567',
              buttonText: 'Call Now',
              onTap: () {},
            ),
            SupportCardContact(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'support@helperapp.com',
              buttonText: 'Send Email',
              onTap: () {},
            ),
            const SizedBox(height: 32),

            // Quick Links
            const Text(
              'Quick Links',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SupportQuickLink(
                  onTap: () => context.go(RoutePaths.helperGuideline),
                  icon: Icons.description,
                  label: 'View Guidelines',
                ),
                SupportQuickLink(
                  onTap: () => context.go(RoutePaths.uploadDocuments),
                  icon: Icons.upload_file,
                  label: 'Update Documents',
                ),
                SupportQuickLink(
                  onTap: () => context.push(RoutePaths.helperProfileUpdate),
                  icon: Icons.edit,
                  label: 'Edit Profile',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Frequently Asked Questions
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const FAQItem(
              question: 'How do I update my biodata?',
              answer:
                  "Go to your profile section and click on 'Edit Biodata'. You can update your personal information, work experience, and skills from there.",
            ),
            const FAQItem(
              question: 'How do I apply for a job?',
              answer:
                  "Browse available jobs in the Jobs section. Click on any job listing to view details, then tap 'Apply Now' to submit your application.",
            ),
            const FAQItem(
              question: 'How do interviews work?',
              answer:
                  "Once an employer is interested, they'll schedule an interview. You'll receive a notification and can view all interview details in the Interviews section.",
            ),
            const FAQItem(
              question: 'How do I message an employer?',
              answer:
                  "After being matched with an employer, you can access the Messages section to communicate directly with them.",
            ),
            const FAQItem(
              question: 'What documents do I need to upload?',
              answer:
                  "Required documents typically include ID, passport, work permit, and any relevant certifications. Check the Documents section for specific requirements.",
            ),
            const SizedBox(height: 40),

            // Still Need Help?
            Center(
              child: Column(
                children: [
                  const Icon(Icons.help_outline, size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Still need help?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Admin is available 24/7 to assist you',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.push(RoutePaths.helperSupportChat),
                    icon: const Icon(Icons.chat),
                    label: const Text('Start Live Chat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
