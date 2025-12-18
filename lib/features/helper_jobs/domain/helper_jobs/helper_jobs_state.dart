import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

part 'helper_jobs_state.freezed.dart';

enum HelperJobsActions {
  applyJob,
  getJobs,
  getJobTags,
  favouriteJob,
  unfavouriteJob,
  none,
}

enum HelperJobsStatus {
  initialPending,
  subPending,
  pending,
  failure,
  success,
  none,
}

@freezed
class HelperJobsState with _$HelperJobsState {
  factory HelperJobsState({
    @Default(HelperJobsActions.getJobs) HelperJobsActions action,
    @Default(HelperJobsStatus.initialPending) HelperJobsStatus status,
    @Default([]) List<Job> jobs,
    @Default([]) List<JobTag> jobTags,
    @Default(0) int page,
    @Default(10) int limit,
    @Default(true) bool hasNext,
    @Default('') String query,
    @Default('All') String selectedJobTag,
  }) = _HelperJobsState;
}
