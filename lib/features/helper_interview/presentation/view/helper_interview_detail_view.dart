import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/models/Interview.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

/* class AppColors {
  static const Color primary = Color(0xFF00A699); // Teal primary color
  static const Color background = Color(0xFFF8FAFC);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color lightGray = Color(0xFFF1F5F9);
  static const Color borderColor = Color(0xFFE2E8F0);
  static const Color pendingBg = Color(0xFFFFF4E5);
  static const Color pendingText = Color(0xFFFB923C);
} */

class HelperInterviewDetailView extends StatelessWidget {
  const HelperInterviewDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final interview = GoRouterState.of(context).extra as Interview;
    final originalInterviewStatus = getInterviewStatusUI(interview.status);
    final dateLabel = interview.confirmedDateTime == null
        ? 'Date Options'
        : 'Date';
    final interviewDate = interview.confirmedDateTime == null
        ? interview.interviewDateOptions!
              .map(
                (dop) => formatDateMMMdyyyy(
                  dop.getDateTimeInUtc().toLocal(),
                ),
              )
              .join("\n")
        : formatDateMMMdyyyy(
            interview.confirmedDateTime!.getDateTimeInUtc().toLocal(),
          );

    final timeLabel = interview.confirmedDateTime == null
        ? 'Time Options'
        : 'Time';
    final interviewTime = interview.confirmedDateTime == null
        ? interview.interviewDateOptions!
              .map(
                (dop) => formatTimeHMMA(
                  dop.getDateTimeInUtc().toLocal(),
                ),
              )
              .join("\n")
        : formatTimeHMMA(
            interview.confirmedDateTime!.getDateTimeInUtc().toLocal(),
          );
    final avgRating = averageRating(
      interview.employer?.reviewedByUser ?? [],
    ).toStringAsFixed(1);
    final reviewCount = (interview.employer?.reviewedByUser ?? []).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interview Details',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              interview.job?.title ?? "",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: originalInterviewStatus.bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              originalInterviewStatus.text,
              style: TextStyle(
                color: originalInterviewStatus.color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 14),

            // Video Interview Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.videocam_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Video Interview',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Date, Time, Duration
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),

                    child: Row(
                      children: [
                        Expanded(
                          child: _buildInfoRow(
                            Icons.calendar_today,
                            dateLabel,
                            interviewDate,
                          ),
                        ),
                        Expanded(
                          child: _buildInfoRow(
                            Icons.access_time,
                            timeLabel,
                            interviewTime,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),

                    child: _buildInfoRow(
                      Icons.timer_outlined,
                      'Duration',
                      '30 minutes',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Interview Notes
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      // borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Interview Notes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          interview.job?.note ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Employer Information
            _buildSectionTitle('Employer Information'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: interview.employer?.avatarURL ?? "",
                        imageBuilder: (_, provider) => CircleAvatar(
                          radius: 24,
                          backgroundImage: provider,
                        ),
                        errorWidget: (_, __, ___) => CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.primary,
                          child: Text(
                            interview.employer?.fullName.toUpperCase()[0] ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                Text(
                                  interview.employer?.fullName ?? "",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                interview.employer?.verifyStatus ==
                                        VerifyStatus.VERIFIED
                                    ? const Icon(
                                        Icons.verified,
                                        color: Colors.amber,
                                        size: 20,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '$avgRating • $reviewCount reviews',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            /*     Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: AppColors.textSecondary,
                                ),
                                const  SizedBox(width: 4),
                                Text(
                                 interview.employer?. 'Tampines, Singapore',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                           */
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  _buildContactRow(
                    Icons.person_outline,
                    'Contact:',
                    interview.employer?.employerContact?.mobile ?? "-",
                  ),
                  const SizedBox(height: 12),
                  _buildContactRow(
                    Icons.email_outlined,
                    'Email:',
                    interview.employer?.email ?? "-",
                  ),
                  const SizedBox(height: 12),
                  _buildContactRow(
                    Icons.email_outlined,
                    'Address:',
                    interview.employer?.employerContact?.adress ?? "-",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Job Details
            _buildSectionTitle('Job Details'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    interview.job?.title ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SGD ${interview.job?.salary}/${interview.job?.payPeriod}',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    interview.job?.note ?? "",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Requirements:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...(interview.job?.requiredSkills ?? []).map(
                    _buildRequirement,
                  ),
                  interview.job?.requiredPersonalityType == null
                      ? const SizedBox()
                      : _buildRequirement(
                          "Personality type: ${interview.job?.requiredPersonalityType}",
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 5,
                    children: [
                      interview.job?.offdays == null
                          ? const SizedBox()
                          : Chip(
                              label: Text("Off Day: ${interview.job?.offdays}"),
                              backgroundColor: const Color.fromARGB(
                                255,
                                225,
                                228,
                                234,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                      interview.job?.childCount == null
                          ? const SizedBox()
                          : Chip(
                              label: Text(
                                "Children: ${interview.job?.childCount}",
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                225,
                                228,
                                234,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                      interview.job?.childAges == null
                          ? const SizedBox()
                          : Chip(
                              label: Text(
                                "Children are ${interview.job?.childAges}",
                              ),
                              backgroundColor: Color.fromARGB(
                                255,
                                225,
                                228,
                                234,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                      interview.job?.adultCount == null
                          ? const SizedBox()
                          : Chip(
                              label: Text(
                                "Adult: ${interview.job?.adultCount}",
                              ),
                              backgroundColor: Color.fromARGB(
                                255,
                                225,
                                228,
                                234,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                      interview.job?.elderlyCount == null
                          ? const SizedBox()
                          : Chip(
                              label: Text(
                                "Elderly: ${interview.job?.elderlyCount}",
                              ),
                              backgroundColor: Color.fromARGB(
                                255,
                                225,
                                228,
                                234,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                      interview.job?.homeType == null
                          ? const SizedBox()
                          : Chip(
                              label: Text(
                                "Home Type: ${interview.job?.homeType}",
                              ),
                              backgroundColor: Color.fromARGB(
                                255,
                                225,
                                228,
                                234,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                      interview.job?.roomType == null
                          ? const SizedBox()
                          : Chip(
                              label: Text(
                                "Room Type: ${interview.job?.roomType}",
                              ),
                              backgroundColor: Color.fromARGB(
                                255,
                                225,
                                228,
                                234,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              padding: const EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Icon(Icons.info_outline, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// To preview:
// void main() => runApp(const MaterialApp(home: HelperInterviewDetailView()));
