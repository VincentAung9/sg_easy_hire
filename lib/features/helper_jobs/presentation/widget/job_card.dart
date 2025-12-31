import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart'
    hide ApplyJobEvent;
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_bloc.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_event.dart'
    hide ApplyJobForUIEvent;
import 'package:sg_easy_hire/models/Job.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocSelector<HelperCoreBloc, HelperCoreState, User?>(
      selector: (state) => state.currentUser,
      builder: (context, currentUser) {
        final isApplied = (job.applications ?? [])
            .where((ap) => ap.helper?.id == currentUser?.id)
            .isNotEmpty;
        final savedJobs = (job.savedJobs ?? [])
            .where((sj) => sj.user?.id == currentUser?.id)
            .toList();
        final isFavourite = savedJobs.isNotEmpty;
        final savedJob = isFavourite ? savedJobs.first : null;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
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
                          job.creator?.fullName ?? "",
                          style: textTheme.titleSmall?.copyWith(
                            color: AppColors.textMutedLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text("\$${job.salary}"),
                        side: BorderSide.none,
                        backgroundColor: Colors.green[100],
                        labelStyle: TextStyle(
                          color: Colors.green[600],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                      const SizedBox(width: 12),

                      InkWell(
                        onTap: () => isFavourite
                            ? context.read<HelperJobsBloc>().add(
                                UnfavouriteJob(
                                  currentUser: currentUser!,
                                  oldJob: job,
                                  savedJob: savedJob!,
                                ),
                              )
                            : context.read<HelperJobsBloc>().add(
                                FavouriteJob(
                                  currentUser: currentUser!,
                                  oldJob: job,
                                ),
                              ),
                        child: Icon(
                          !isFavourite ? Icons.favorite_border : Icons.favorite,
                          color: isFavourite
                              ? Colors.red[500]
                              : Colors.grey[300],
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                job.note ?? "",
                style: textTheme.titleSmall?.copyWith(
                  height: 1.5,
                  color: AppColors.textGrayLight,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5,
                children: [
                  ...List.generate((job.requiredSkills ?? []).length, (index) {
                    final skill = (job.requiredSkills ?? [])[index];
                    return Chip(
                      label: Text(skill),
                      backgroundColor: AppColors.chipBackground,
                      labelStyle: textTheme.labelSmall?.copyWith(
                        color: AppColors.chipColor,
                      ),
                      padding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.transparent),
                      ),
                    );
                  }),
                  job.offdays == null
                      ? const SizedBox()
                      : Chip(
                          label: Text(job.offdays ?? ""),
                          backgroundColor: Colors.grey.shade200,
                          labelStyle: textTheme.labelSmall?.copyWith(
                            color: AppColors.textGrayLight,
                          ),
                          padding: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                ],
              ),

              Divider(color: Colors.grey[100]),

              job.createdAt == null
                  ? const SizedBox()
                  : Text(
                      timeAgo(job.createdAt!),
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          context.go(RoutePaths.jobDetailFullPath, extra: job),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondaryLight,
                        side: BorderSide(color: Colors.grey[200]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "View Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: isApplied
                        ? ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[500],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                          )
                        : ElevatedButton(
                            onPressed:
                                currentUser?.verifyStatus !=
                                    VerifyStatus.VERIFIED
                                ? null
                                : () {
                                    context.read<HomeBloc>().add(
                                      ApplyJobForUIEvent(
                                        oldJob: job,
                                        appliedJob: AppliedJob(
                                          code: nanoid(10),
                                          status: ApplicationStatus.PENDING,
                                          adminActionStatus:
                                              AdminActionStatus.PENDING,
                                          helper: currentUser,
                                          job: job,
                                          createdAt: TemporalDateTime(
                                            DateTime.now(),
                                          ),
                                        ),
                                        currentUser: currentUser!,
                                      ),
                                    );
                                    context.read<HelperJobsBloc>().add(
                                      ApplyJobEvent(
                                        oldJob: job,
                                        appliedJob: AppliedJob(
                                          code: nanoid(10),
                                          status: ApplicationStatus.PENDING,
                                          adminActionStatus:
                                              AdminActionStatus.PENDING,
                                          helper: currentUser,
                                          job: job,
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Apply Now",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
