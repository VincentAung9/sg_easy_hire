import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/Interview.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

part 'home_state.freezed.dart';

enum HomeStateActions { recommendJob, nextInterview, none }

enum HomeStateStatus { pending, success, failure, none }

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    Interview? nextInterview,
    @Default([]) List<Job> recommendJobs,
    @Default(HomeStateActions.none) HomeStateActions action,
    @Default(HomeStateStatus.none) HomeStateStatus status,
  }) = _HomeState;
}
