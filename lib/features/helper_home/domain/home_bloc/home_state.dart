import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

part 'home_state.freezed.dart';

enum HomeStateActions {
  recommendJob,
  nextInterview,
  applyJob,
  interview,
  profileViews,
  none,
}

enum HomeStateStatus { pending, success, failure, none }

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    Interview? nextInterview,
    @Default([]) List<ViewHelper> profileViews,
    @Default([]) List<AppliedJob> appliedJobs,
    @Default([]) List<Interview> interviews,
    @Default([]) List<Interview> pending,
    @Default([]) List<Interview> accepted,
    @Default([]) List<Interview> completed,
    @Default([]) List<Interview> cancelled,
    @Default([]) List<Job> recommendJobs,
    @Default(HomeStateActions.none) HomeStateActions action,
    @Default(HomeStateStatus.none) HomeStateStatus status,
  }) = _HomeState;
}
