import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/l10n/gen/app_localizations.dart';
import 'package:sg_easy_hire/models/Job.dart';

class HelperJobDetailsView extends StatelessWidget {
  const HelperJobDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final job = GoRouterState.of(context).extra! as Job;
    final avgRating = averageRating(
      job.creator?.reviewedByUser ?? [],
    ).toStringAsFixed(1);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (job.isActive ?? true)
                ? HiringStatus(
                    title: t.activelyHiring,
                    bgColor: Color(0xFFD1FAE5),
                    textColor: Color(0xFF10B981),
                  )
                : HiringStatus(
                    title: t.positionClosed,
                    bgColor: Color(0xFFFEE2E2),
                    textColor: Color(0xFFEF4444),
                  ),
            Text(
              t.postedTimeAgo(timeAgo(job.createdAt!)),
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Job Title Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            job.location,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 24),
                          const Icon(
                            Icons.work_outline,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            job.jobType ?? t.fullTime,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoChip(
                            Icons.attach_money,
                            t.salary,
                            '${job.currency ?? 'SGD'} ${job.salary}/${job.payPeriod}',
                          ),
                          _buildInfoChip(
                            Icons.calendar_today,
                            t.startDate,
                            job.startDate == null
                                ? t.immediate
                                : DateTime.tryParse(job.startDate!) == null
                                ? job.startDate ?? ""
                                : formatDateMMMdy(
                                    DateTime.parse(job.startDate!),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoChip(
                            Icons.description_outlined,
                            t.contract,
                            job.contract ?? '2 years',
                          ),
                          _buildInfoChip(
                            Icons.people_outline,
                            t.applicants,
                            '${(job.applications ?? []).length} ${t.applied}',
                            iconColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Employer Information
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(t.employerInformation),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: job.creator?.avatarURL ?? "",
                            imageBuilder: (_, provider) => CircleAvatar(
                              radius: 28,
                              backgroundImage: provider,
                            ),
                            errorWidget: (_, __, ___) => CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColors.primary,
                              child: Text(
                                job.creator?.fullName.toUpperCase()[0] ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.creator?.fullName ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 18,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      job.creator?.location ?? "-",
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  Text(
                                    avgRating,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${job.creator?.hiredCount ?? 0} hires',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Job Description
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(t.jobDescription),
                      const SizedBox(height: 12),
                      Text(
                        job.note ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Responsibilities
                (job.responsibilities ?? []).isNotEmpty
                    ? _buildCheckListCard(
                        label: t.responsibilities,
                        job.responsibilities!,
                        iconColor: AppColors.primary,
                      )
                    : const SizedBox(),

                SizedBox(
                  height: (job.responsibilities ?? []).isNotEmpty ? 24 : 0,
                ),

                // Requirements
                _buildCheckListCard(
                  label: t.requirements,
                  job.requiredSkills ?? [],
                ),

                const SizedBox(height: 24),

                // Benefits (from Image ID: 2)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(t.otherInfo),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 5,
                        children: [
                          job.offdays == null
                              ? const SizedBox()
                              : Chip(
                                  label: Text("${t.offDay}: ${job.offdays}"),
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
                          job.childCount == null
                              ? const SizedBox()
                              : Chip(
                                  label: Text(
                                    "${t.children}: ${job.childCount}",
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
                          job.childAges == null
                              ? const SizedBox()
                              : Chip(
                                  label: Text(
                                    "${t.childrenAre} ${job.childAges}",
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
                          job.adultCount == null
                              ? const SizedBox()
                              : Chip(
                                  label: Text(
                                    "${t.adult}: ${job.adultCount}",
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
                          job.elderlyCount == null
                              ? const SizedBox()
                              : Chip(
                                  label: Text(
                                    "${t.elderly}: ${job.elderlyCount}",
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
                          job.homeType == null
                              ? const SizedBox()
                              : Chip(
                                  label: Text(
                                    "${t.homeType}: ${job.homeType}",
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
                          job.roomType == null
                              ? const SizedBox()
                              : Chip(
                                  label: Text(
                                    "${t.roomType}: ${job.roomType}",
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String label,
    String value, {
    Color? iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor ?? AppColors.primary, size: 20),
        const SizedBox(width: 8),
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

  Widget _buildCheckListCard(
    List<String> items, {
    Color iconColor = AppColors.primary,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(label),

          const SizedBox(height: 12),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, color: iconColor, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class HiringStatus extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String title;
  const HiringStatus({
    required this.title,
    required this.bgColor,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// To preview:
// void main() => runApp(const MaterialApp(home: HelperJobDetailsView()));
