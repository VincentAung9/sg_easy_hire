import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/widgets/shimmer_container.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_bloc.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_state.dart';
import 'package:sg_easy_hire/features/helper_jobs/presentation/widget/job_filter_chip.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class FindJobFilterChip extends StatelessWidget {
  const FindJobFilterChip({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Increased height for chips
      child: BlocBuilder<HelperJobsBloc, HelperJobsState>(
        builder: (context, state) {
          if (state.status == HelperJobsStatus.initialPending &&
              state.action == HelperJobsActions.getJobTags) {
            return ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (_, index) => const Padding(
                padding: EdgeInsets.only(right: 8),
                child: ShimmerContainer(width: 100, height: 40),
              ),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.jobTags.length + 1,
            itemBuilder: (_, index) {
              final jobTag = [
                JobTag(name: "All"),
                ...state.jobTags,
              ][index].name;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: JobFilterChip(
                  label: jobTag,
                  isSelected: jobTag == state.selectedJobTag,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
