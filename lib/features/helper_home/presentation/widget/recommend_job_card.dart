import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart'
    hide ApplyJobForUIEvent;
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_bloc.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_event.dart'
    hide ApplyJobEvent;
import 'package:sg_easy_hire/models/ModelProvider.dart';

class RecommendJobCard extends StatelessWidget {
  final Job job;
  const RecommendJobCard({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return BlocSelector<HelperCoreBloc, HelperCoreState, User?>(
      selector: (state) => state.currentUser,
      builder: (context, currentUser) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.cardLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                job.location,
                style: textTheme.titleSmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                job.note ?? "",
                style: textTheme.titleSmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  job.familyMembers == null
                      ? const SizedBox()
                      : JobTagComponent(
                          label: "${job.familyMembers} in family",
                        ),
                  job.childCount == null
                      ? const SizedBox()
                      : JobTagComponent(label: "${job.childCount} children"),
                  job.roomType == null
                      ? const SizedBox()
                      : JobTagComponent(label: job.roomType ?? ""),
                  job.offdays == null
                      ? const SizedBox()
                      : JobTagComponent(label: "Off days: ${job.offdays}"),
                ],
              ),
              const SizedBox(height: 16),
              Chip(
                side: const BorderSide(color: Colors.green),
                label: Text("\$${job.salary}/${job.payPeriod}"),
                backgroundColor: Colors.green[100],
                labelStyle: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
              ),
              const SizedBox(height: 16),
              (job.applications ?? [])
                      .where((ap) => ap.helper?.id == currentUser?.id)
                      .isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[500],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Applied",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            currentUser?.verifyStatus != VerifyStatus.VERIFIED
                            ? null
                            : () {
                                context.read<HelperJobsBloc>().add(
                                  ApplyJobForUIEvent(
                                    oldJob: job,
                                    appliedJob: AppliedJob(
                                      code: nanoid(10),
                                      status: ApplicationStatus.PENDING,
                                      adminActionStatus:
                                          AdminActionStatus.PENDING,
                                      updatedBy: UserRole.HELPER,
                                      job: job,
                                      helper: currentUser,
                                    ),
                                    currentUser: currentUser!,
                                  ),
                                );
                                context.read<HomeBloc>().add(
                                  ApplyJobEvent(
                                    oldJob: job,
                                    appliedJob: AppliedJob(
                                      code: nanoid(10),
                                      status: ApplicationStatus.PENDING,
                                      adminActionStatus:
                                          AdminActionStatus.PENDING,
                                      updatedBy: UserRole.HELPER,
                                      job: job,
                                      helper: currentUser,
                                      createdAt: TemporalDateTime(
                                        DateTime.now(),
                                      ),
                                    ),
                                    currentUser: currentUser,
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                          foregroundColor: Colors.white,
                          minimumSize: const Size(
                            double.infinity,
                            48,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Apply Now",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
