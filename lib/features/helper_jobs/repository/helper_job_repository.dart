import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperJobRepository {
  Future<void> unfavouriteJob(SavedJob job) async {
    final result = await Amplify.DataStore.query(
      SavedJob.classType,
      where: SavedJob.JOB.eq(job.job?.id).and(SavedJob.USER.eq(job.user?.id)),
    );
    if (result.isNotEmpty) {
      return Amplify.DataStore.delete(result.first);
    } else {
      throw Exception();
    }
  }

  Future<void> favouriteJob(SavedJob job) async {
    return Amplify.DataStore.save(job);
  }

  Future<void> applyJob(AppliedJob job) async {
    return Amplify.DataStore.save(job);
  }

  Future<List<JobTag>> getJobTags() async {
    return Amplify.DataStore.query(
      JobTag.classType,
      sortBy: [JobTag.CREATEDAT.descending()],
    );
  }

  Future<List<Job>> getJobs({
    required int page,
    required int limit,
    String query = "",
    String tag = "All",
  }) async {
    QueryPredicate? filter;
    if (query.isNotEmpty && tag != "All") {
      filter = Job.TAGS
          .contains(tag)
          .and(
            Job.TITLE
                .contains(query)
                .or(Job.LOCATION.contains(query))
                .or(Job.FAMILYMEMBERS.contains(query)),
          );
    } else if (query.isNotEmpty) {
      filter = Job.TITLE
          .contains(query)
          .or(Job.LOCATION.contains(query))
          .or(Job.FAMILYMEMBERS.contains(query));
    } else if (tag != "All") {
      filter = Job.TAGS.contains(tag);
    }
    return Amplify.DataStore.query(
      Job.classType,
      where: filter,
      sortBy: [Job.CREATEDAT.descending()],
      pagination: QueryPagination(
        page: page,
        limit: limit,
      ),
    );
  }
}
