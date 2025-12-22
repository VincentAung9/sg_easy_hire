import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';

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
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildTimeEstimateCard(),
                const SizedBox(height: 24),
                _buildWhatWeAskCard(),
                const SizedBox(height: 24),
                _buildImportantInfoCard(),
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

  Widget _buildHeader() {
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
        const Text(
          "Help Us Know You Better",
          style: TextStyle(
            color: AppColors.textPrimaryLight,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          "Complete your profile to increase your chances of finding the perfect job",
          style: TextStyle(
            color: AppColors.textSecondaryLight,
            fontSize: 15,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTimeEstimateCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // blue-50
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.schedule, color: AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Estimated Time: 10-15 minutes",
                  style: TextStyle(
                    color: Color(0xFF1E40AF), // blue-800
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "This questionnaire helps employers understand your skills, experience, and preferences to match you with suitable job opportunities.",
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

  Widget _buildWhatWeAskCard() {
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
          const Row(
            children: [
              Icon(
                Icons.list_alt,
                color: AppColors.textSecondaryLight,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "What We'll Ask About:",
                style: TextStyle(
                  color: AppColors.textPrimaryLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildChecklistItem("Personal information (name, age, nationality)"),
          const SizedBox(height: 12),
          _buildChecklistItem("Contact details and family background"),
          const SizedBox(height: 12),
          _buildChecklistItem("Medical history and food preferences"),
          const SizedBox(height: 12),
          _buildChecklistItem("Languages spoken and skills"),
          const SizedBox(height: 12),
          _buildChecklistItem("Work experience and job preferences"),
          const SizedBox(height: 12),
          _buildChecklistItem(
            "Document uploads (passport, certificates, photo)",
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

  Widget _buildImportantInfoCard() {
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
          const Row(
            children: [
              Icon(Icons.warning_amber, color: Color(0xFFF59E0B)), // yellow-500
              SizedBox(width: 8),
              Text(
                "Important Information",
                style: TextStyle(
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
            "You can skip any questions you're not ready to answer",
            isBold: ["skip any questions"],
          ),
          const SizedBox(height: 8),
          _buildBulletPoint(
            "Mandatory fields (*) are required for your biodata to be visible to employers",
            isBold: ["Mandatory fields (*)"],
          ),
          const SizedBox(height: 8),
          _buildBulletPoint(
            "If you skip now, you'll be asked to complete this when applying for jobs",
          ),
          const SizedBox(height: 8),
          _buildBulletPoint(
            "Complete profiles get 3x more views from employers",
            isBold: ["3x more views"],
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
              child: const Text(
                "Skip for Now",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
              child: const Text(
                "Let's Get Started",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
