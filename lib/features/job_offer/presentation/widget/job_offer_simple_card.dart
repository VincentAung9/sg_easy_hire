import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/job_offer/data/repository/job_repository.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/JobOffer.dart';
import 'package:sg_easy_hire/models/JobOfferStatus.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class JobOfferSimpleCard extends StatelessWidget {
  final JobOffer? offeredJob;
  const JobOfferSimpleCard({super.key, required this.offeredJob});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final interviewStatusUI = getOfferedJobStatusUI(
      offeredJob?.status ?? ApplicationStatus.PENDING,
    );
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHelperInfo(
            imageUrl: offeredJob?.employer?.avatarURL ?? "",
            emoji: "",
            name: offeredJob?.job?.title ?? "",
            details: offeredJob?.job?.note ?? "",
            time: "",
            skills:
                (offeredJob?.job?.requiredSkills ?? []).map((sk) {
                  return {"label": sk, "color": "purple"};
                }).toList() ??
                [] /* [
                  {"label": "Cooking", "color": "purple"},
                  {"label": "Elderly Care", "color": "gray"},
                ] */,
            stats: {
              t.adult: "${offeredJob?.job?.adultCount ?? 0}",
              t.children: "${offeredJob?.job?.childCount ?? 0}",
              t.elderly: "${offeredJob?.job?.elderlyCount ?? 0}",
              t.childrenAre: "${offeredJob?.job?.childAges ?? 0}",
            },
          ),
          const SizedBox(height: 16),
          _buildStatusChip(
            interviewStatusUI.text,
            interviewStatusUI.icon,
            interviewStatusUI.color,
            interviewStatusUI.bgColor,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              context.push(
                RoutePaths.jobDetailFullPath,
                extra: offeredJob?.job,
              );
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              foregroundColor: AppColors.primary,
              side: const BorderSide(
                color: AppColors.primary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              t.viewDetails,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),

          const SizedBox(height: 16),
          offeredJob?.status == ApplicationStatus.REJECTED ||
                  offeredJob?.status == ApplicationStatus.ACCEPTED
              ? const SizedBox()
              : offeredJob?.status == ApplicationStatus.PENDING
              ? Row(
                  children: [
                    Expanded(
                      child: MutationBuilder(
                        mutation: JobService.updateOfferedJob,
                        builder: (context, state, mutate) {
                          return ElevatedButton(
                            onPressed: () async {
                              final mutation = await mutate(
                                offeredJob!.copyWith(
                                  status: ApplicationStatus.ACCEPTED,
                                  updatedBy: UserRole.HELPER,
                                ),
                              );
                              if (mutation.isError) {
                                showSnack(
                                  context,
                                  "Changing job offer status failed!",
                                );
                                return;
                              }
                              if (mutation.isSuccess) {
                                showSnack(
                                  context,
                                  "Job offer status changed successfully!",
                                );
                                return;
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 48),
                              backgroundColor: Colors.green[500],
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: state.isLoading
                                ? const SizedBox(
                                    height: 28,
                                    width: 50,
                                    child: CupertinoActivityIndicator(),
                                  )
                                : Text(
                                    t.interviewStatusAccept,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MutationBuilder(
                        mutation: JobService.updateOfferedJob,
                        builder: (context, state, mutate) {
                          return ElevatedButton(
                            onPressed: () async {
                              final mutation = await mutate(
                                offeredJob!.copyWith(
                                  status: ApplicationStatus.REJECTED,
                                  updatedBy: UserRole.HELPER,
                                ),
                              );
                              if (mutation.isError) {
                                showSnack(
                                  context,
                                  "Changing job offer status failed!",
                                );
                                return;
                              }
                              if (mutation.isSuccess) {
                                showSnack(
                                  context,
                                  "Job offer status changed successfully!",
                                );
                                return;
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 48),
                              backgroundColor: Colors.red[500],
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: state.isLoading
                                ? SizedBox(
                                    height: 28,
                                    width: 50,
                                    child: CupertinoActivityIndicator(),
                                  )
                                : Text(
                                    t.interviewCancel,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

Widget _buildHelperInfo({
  String? emoji,
  String? imageUrl,
  required String name,
  required String details,
  required List<Map<String, String>> skills,
  required Map<String, String> stats,
  String? time,
}) {
  Color getSkillColor(String color) {
    switch (color) {
      case "purple":
        return AppColors.primary;
      case "blue":
        return Colors.blue[600]!;
      case "gray":
        return AppColors.textMutedLight;
      default:
        return AppColors.primary;
    }
  }

  Color getSkillBgColor(String color) {
    switch (color) {
      case "purple":
        return const Color(0xFFF3E8FF);
      case "blue":
        return const Color(0xFFDBEAFE);
      case "gray":
        return const Color(0xFFE5E7EB);
      default:
        return const Color(0xFFF3E8FF);
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // === LEFT: Photo (smaller) ===
      Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: (imageUrl != null && imageUrl.isNotEmpty)
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Text(
                        emoji ?? '',
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Text(
                        emoji ?? '',
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    emoji ?? '',
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
        ),
      ),
      const SizedBox(width: 12),

      // === RIGHT: Name, Details, Skills, STATS ===
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              details,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondaryLight,
              ),
            ),

            time?.isEmpty == true
                ? const SizedBox()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: const Icon(
                          Icons.schedule,
                          size: 16,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          time ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),

            const SizedBox(height: 5),

            // === Skills ===
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills
                  .map(
                    (skill) => _buildChip(
                      skill['label']!,
                      getSkillColor(skill['color']!),
                      getSkillBgColor(skill['color']!),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 7),

            // === Stats Grid (4 columns, tight) ===
            /* GridView.count */ Wrap(
              /* crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                padding: EdgeInsets.only(right: 0),
                childAspectRatio: 1, */
              runSpacing: 20,
              spacing: 20,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.center,
              children: stats.entries
                  .map((entry) => _buildStatItem(entry.key, entry.value))
                  .toList(),
            ),
          ],
        ),
      ),

      // === More Options ===
      Icon(Icons.more_vert, color: Colors.grey[400]),
    ],
  );
}

Widget _buildChip(String label, Color textColor, Color bgColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildStatItem(String label, String value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondaryLight,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 2),
      Text(
        value,
        style: const TextStyle(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _buildSalaryGrid({required String salary, required String offDay}) {
  return /* GridView.count */ Wrap(
    /* crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                padding: EdgeInsets.only(right: 0),
                childAspectRatio: 1, */
    runSpacing: 20,
    spacing: 20,
    alignment: WrapAlignment.start,
    runAlignment: WrapAlignment.center,
    children: [
      Row(
        children: [
          const Text(
            "Salary : ",
            style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14),
          ),

          Text(
            salary,
            style: TextStyle(
              color: Colors.blue[500],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
      Row(
        children: [
          const Text(
            "Off Day : ",
            style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14),
          ),

          Text(
            offDay,
            style: TextStyle(
              color: Colors.green[500],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildDivider({double top = 15}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: top),
    child: Divider(height: 1, color: Colors.grey[200]),
  );
}

Widget _buildStatusChip(
  String label,
  IconData icon,
  Color color,
  Color bgColor,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
