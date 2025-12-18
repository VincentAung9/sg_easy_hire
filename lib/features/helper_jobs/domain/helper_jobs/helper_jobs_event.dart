import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperJobsEvent {}

class GetJobsEvent extends HelperJobsEvent {}

class GetJobTags extends HelperJobsEvent {}

class FavouriteJob extends HelperJobsEvent {
  final Job oldJob;
  final User currentUser;
  FavouriteJob({required this.currentUser, required this.oldJob});
}

class UnfavouriteJob extends HelperJobsEvent {
  final User currentUser;
  final Job oldJob;
  UnfavouriteJob({
    required this.currentUser,
    required this.oldJob,
  });
}

class ChangeJobTag extends HelperJobsEvent {
  final String tag;
  ChangeJobTag({required this.tag});
}

class SearchJobsEvent extends HelperJobsEvent {
  final String query;
  SearchJobsEvent({required this.query});
}

class ApplyJobEvent extends HelperJobsEvent {
  final Job oldJob;
  final AppliedJob appliedJob;
  final User currentUser;
  ApplyJobEvent({
    required this.oldJob,
    required this.appliedJob,
    required this.currentUser,
  });
}
