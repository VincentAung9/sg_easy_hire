import 'package:sg_easy_hire/models/ModelProvider.dart';

class HomeEvent {}

class StartListenNextInterview extends HomeEvent {}

class GetRecommendJobsEvent extends HomeEvent {
  final String skills;
  GetRecommendJobsEvent({required this.skills});
}

class ApplyJobEvent extends HomeEvent {
  final Job oldJob;
  final AppliedJob appliedJob;
  final User currentUser;
  ApplyJobEvent({
    required this.oldJob,
    required this.appliedJob,
    required this.currentUser,
  });
}

class StartListenProfileView extends HomeEvent {}

class StartListenAppliedJobs extends HomeEvent {}

class StartListenInterviews extends HomeEvent {}
