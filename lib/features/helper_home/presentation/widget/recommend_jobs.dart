import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';
import 'package:sg_easy_hire/models/User.dart';

class RecommendedJobs extends StatelessWidget {
  const RecommendedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return BlocListener<HelperCoreBloc, HelperCoreState>(
      listener: (_, state) {
        if (state.currentUser?.skills?.isNotEmpty ?? false) {
          //everytime skills changed, need to retrieve recommended jobs
          context.read<HomeBloc>().add(
            GetRecommendJobsEvent(
              skills: state.currentUser?.skills?.join(",") ?? "",
            ),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (_, state) {
          if (state.action == HomeStateActions.recommendJob &&
              state.status == HomeStateStatus.pending) {
            return const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerContainer(width: 150, height: 30),
                    ShimmerContainer(width: 80, height: 20),
                  ],
                ),
                SizedBox(height: 16),
                JobCardShimmer(),
              ],
            );
          }
          if (state.recommendJobs.isEmpty ||
              (state.action == HomeStateActions.recommendJob &&
                  (state.status == HomeStateStatus.none ||
                      state.status == HomeStateStatus.failure))) {
            return const SizedBox();
          }
          //first recommended jobs
          final job = state.recommendJobs;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Recommended Jobs",
                    style: TextStyle(
                      color: textPrimaryLight,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<BottomNavCubit>().changeIndex(1);
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardLight,
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
                      job?.title ?? "",
                      style: TextStyle(
                        color: textPrimaryLight,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      job?.location ?? "",
                      style: TextStyle(
                        color: textSecondaryLight,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      job?.additionalRequirements ?? "",
                      style: TextStyle(
                        color: textSecondaryLight,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        job?.familyMembers == null
                            ? const SizedBox()
                            : JobTag(
                                label: "${job?.familyMembers} in family",
                              ),
                        job?.childrenCount == null
                            ? const SizedBox()
                            : JobTag(label: "${job?.childrenCount} children"),
                        job?.roomType == null
                            ? const SizedBox()
                            : JobTag(label: job?.roomType ?? ""),
                        job?.offDays == null
                            ? const SizedBox()
                            : JobTag(label: "Off days: ${job?.offDays}"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Chip(
                      label: Text("\$${job?.salary}/${job?.payPeriod}"),
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
                    BlocSelector<HelperAuthCubic, HelperAuthState, User?>(
                      selector: (state) => state.user,
                      builder: (context, currentUser) {
                        return QueryBuilder(
                          query: JobService.getAppliedJob(
                            ApplyJobParam(
                              jobId: job?.id ?? "",
                              helperId: currentUser?.id ?? "",
                            ),
                          ),
                          builder: (_, state) {
                            return state.data != null
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
                                      onPressed: () async {
                                        await JobService.applyJob
                                            .mutate(
                                              ApplyJobParam(
                                                jobId: job?.id ?? "",
                                                helperId: currentUser?.id ?? "",
                                              ),
                                            )
                                            .then(
                                              (state) => {
                                                if (state.isSuccess &&
                                                    state.data == true)
                                                  {
                                                    CachedQuery.instance
                                                        .invalidateCache(
                                                          key:
                                                              'applyjob-${job?.id ?? ""}-${currentUser?.id ?? ""}',
                                                        ),
                                                  },
                                              },
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
                                  );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
