class HomeEvent {}

class StartListenNextInterview extends HomeEvent {}

class GetRecommendJobsEvent extends HomeEvent {
  final String skills;
  GetRecommendJobsEvent({required this.skills});
}
