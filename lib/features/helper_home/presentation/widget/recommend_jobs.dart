import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/route_paths.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/recommend_job_card.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/Job.dart';

class RecommendedJobs extends StatelessWidget {
  const RecommendedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return BlocBuilder<HomeBloc, HomeState>(
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
        List<Job> jobs = state.recommendJobs.isNotEmpty
            ? state.recommendJobs.length > 1
                  ? [state.recommendJobs[0], state.recommendJobs[1]]
                  : [state.recommendJobs.first]
            // ignore: inference_failure_on_collection_literal
            : [];
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.jobSearchDashboard_recommendedJobs,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.go(RoutePaths.jobs);
                    },
                    child: Text(
                      t.jobSearchDashboard_viewAllJobs,
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...jobs.map(
              (j) => RecommendJobCard(
                job: j,
              ),
            ),
          ],
        );
      },
    );
  }
}
