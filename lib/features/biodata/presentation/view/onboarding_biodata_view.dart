import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';

class OnboardingBiodataView extends StatefulWidget {
  const OnboardingBiodataView({super.key});

  @override
  State<OnboardingBiodataView> createState() => _OnboardingBiodataViewState();
}

class _OnboardingBiodataViewState extends State<OnboardingBiodataView> {
  Box<bool> signBox = Hive.box<bool>(name: signInBox);
  @override
  void initState() {
    signBox.delete(isFirstTimeLoggedIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                _buildHeader(t),
                const SizedBox(height: 32),
                _buildTimeEstimateCard(t),
                const SizedBox(height: 24),
                _buildWhatWeAskCard(t),
                const SizedBox(height: 24),
                _buildImportantInfoCard(t),
                // const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
            _buildBackButton(
              context,
            ), // Back button positioned over the content
          ],
        ),
      ),
      bottomNavigationBar: _buildFooter(context),
    );
  }

  Widget _buildHeader(AppLocalizations t) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.assignment, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 16),
        Text(
          t.onboardingTitle,
          style: const TextStyle(
            color: AppColors.textPrimaryLight,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          t.onboardingSubtitle,
          style: const TextStyle(
            color: AppColors.textSecondaryLight,
            fontSize: 15,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTimeEstimateCard(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // blue-50
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.schedule, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.estimatedTimeTitle,
                  style: const TextStyle(
                    color: Color(0xFF1E40AF), // blue-800
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t.estimatedTimeDesc,
                  style: const TextStyle(
                    color: Color(0xFF1D4ED8), // blue-700
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatWeAskCard(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.list_alt,
                color: AppColors.textSecondaryLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                t.whatWeAskTitle,
                style: const TextStyle(
                  color: AppColors.textPrimaryLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildChecklistItem(t.askPersonalInfo),
          const SizedBox(height: 12),
          _buildChecklistItem(t.askContactFamily),
          const SizedBox(height: 12),
          _buildChecklistItem(t.askMedicalFood),
          const SizedBox(height: 12),
          _buildChecklistItem(t.askLanguageSkills),
          const SizedBox(height: 12),
          _buildChecklistItem(t.askWorkPreference),
          const SizedBox(height: 12),
          _buildChecklistItem(
            t.askDocuments,
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textSecondaryLight,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImportantInfoCard(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB), // yellow-50
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)), // yellow-200
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_amber,
                color: Color(0xFFF59E0B),
              ), // yellow-500
              const SizedBox(width: 8),
              Text(
                t.importantInfoTitle,
                style: const TextStyle(
                  color: Color(0xFFB45309), // yellow-800
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildBulletPoint(
            "${t.infoSkip_part1} ${t.infoSkip_bold} ${t.infoSkip_part2}",
            isBold: [t.infoSkip_bold],
          ),
          const SizedBox(height: 8),
          _buildBulletPoint(
            "${t.infoMandatory_part1} ${t.infoMandatory_bold} ${t.infoMandatory_part2}",
            isBold: [t.infoMandatory_bold],
          ),
          const SizedBox(height: 8),
          _buildBulletPoint(
            t.infoApplyLater,
          ),
          const SizedBox(height: 8),
          _buildBulletPoint(
            "${t.infoViews_part1} ${t.infoViews_bold} ${t.infoViews_part2}",
            isBold: [t.infoViews_bold],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, {List<String> isBold = const []}) {
    List<TextSpan> spans = [];
    String tempText = text;

    if (isBold.isEmpty) {
      spans.add(TextSpan(text: text));
    } else {
      // This is a simplified way to handle bolding.
      // A more complex parser would be needed for multiple bold sections.
      for (var boldText in isBold) {
        if (tempText.contains(boldText)) {
          var parts = tempText.split(boldText);
          if (parts.isNotEmpty) {
            spans.add(TextSpan(text: parts[0]));
            spans.add(
              TextSpan(
                text: boldText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
            tempText = parts.length > 1 ? parts[1] : "";
          }
        }
      }
      if (tempText.isNotEmpty) {
        spans.add(TextSpan(text: tempText));
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "• ",
          style: TextStyle(color: Color(0xFFB45309), fontSize: 14),
        ), // yellow-700
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFFB45309), // yellow-700
                fontSize: 14,
                fontFamily: 'Inter',
              ),
              children: spans,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.go(RoutePaths.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                foregroundColor: AppColors.textSecondaryLight,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                t.skip,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.go(RoutePaths.personalInformation),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                t.getStarted,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: CircleAvatar(
        backgroundColor: Colors.black26,
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(RoutePaths.home),
          tooltip: 'Back',
        ),
      ),
    );
  }
}
