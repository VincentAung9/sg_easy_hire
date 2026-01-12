import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/features/help_support/presentation/widget/widget.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';

class HelpAndSupportView extends StatelessWidget {
  const HelpAndSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
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
        title: Text(l10n.helpAndSupport),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            const SupportAvailable(),
            const SizedBox(height: 32),

            Text(
              l10n.contactUs,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SupportCardContact(
              icon: FontAwesomeIcons.message,
              title: l10n.adminSupport,
              description: l10n.customerService247,
              subtitle: l10n.needHelpChat,
              badgeText: l10n.support,
              onTap: () => context.push(RoutePaths.helperSupportChat),
            ),

            const SizedBox(height: 32),

            Text(
              l10n.quickLinks,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  child: SupportQuickLink(
                    onTap: () => context.go(RoutePaths.helperGuideline),
                    icon: Icons.description,
                    label: l10n.viewGuidelines,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.3,
                  child: SupportQuickLink(
                    onTap: () => context.go(RoutePaths.uploadDocuments),
                    icon: Icons.upload_file,
                    label: l10n.updateDocuments,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.3,
                  child: SupportQuickLink(
                    onTap: () => context.push(RoutePaths.helperProfileUpdate),
                    icon: Icons.edit,
                    label: l10n.editProfile,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Text(
              l10n.frequentlyAskedQuestions,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            FAQItem(
              question: l10n.faqUpdateBiodataQ,
              answer: l10n.faqUpdateBiodataA,
            ),
            FAQItem(
              question: l10n.faqApplyJobQ,
              answer: l10n.faqApplyJobA,
            ),
            FAQItem(
              question: l10n.faqInterviewQ,
              answer: l10n.faqInterviewA,
            ),
            FAQItem(
              question: l10n.faqMessageEmployerQ,
              answer: l10n.faqMessageEmployerA,
            ),
            FAQItem(
              question: l10n.faqDocumentsQ,
              answer: l10n.faqDocumentsA,
            ),

            const SizedBox(height: 40),

            Center(
              child: Column(
                children: [
                  const Icon(Icons.help_outline, size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    l10n.stillNeedHelp,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(l10n.adminAvailable247),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.push(RoutePaths.helperSupportChat),
                    icon: const Icon(Icons.chat),
                    label: Text(l10n.startLiveChat),
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
