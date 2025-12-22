import 'package:sg_easy_hire/models/ModelProvider.dart';

class HomeEvent {}

class StartListenCreateNextInterview extends HomeEvent {}

class StartListenUpdateNextInterview extends HomeEvent {}

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

class StartListenCreateInterviews extends HomeEvent {}

class StartListenUpdateInterviews extends HomeEvent {}

class StartListenProfileView extends HomeEvent {}

class StartGetProfileViews extends HomeEvent {}

class StartGetAppliedJobs extends HomeEvent {}

class StartGetInterviews extends HomeEvent {}

class StartListenCreateProfileView extends HomeEvent {}
