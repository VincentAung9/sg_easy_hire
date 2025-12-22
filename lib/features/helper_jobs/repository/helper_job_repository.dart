import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperJobRepository {
  Future<void> unfavouriteJob(SavedJob job) async {
    final request = ModelMutations.delete(job);
    await Amplify.API.mutate(request: request).response;
  }

  Future<void> favouriteJob(SavedJob job) async {
    final request = ModelMutations.create(job);
    await Amplify.API.mutate(request: request).response;
  }

  Future<void> applyJob(AppliedJob job) async {
    final request = ModelMutations.create(job);
    await Amplify.API.mutate(request: request).response;
  }

  /* final sortedItems = List<Job?>.from(items)
        ..sort((a, b) {
          if (a?.createdAt == null || b?.createdAt == null) return 0;
          // Use getDateTime() to compare TemporalDateTime
          return b!.createdAt!.getDateTimeInUtc().compareTo(
            a!.createdAt!.getDateTimeInUtc(),
          );
        });

      // 5. Filter nulls and return List<Job>
      return sortedItems.whereType<Job>().toList(); */

  Future<List<JobTag>> getJobTags() async {
    final request = ModelQueries.list(
      JobTag.classType,
    );
    final response = await Amplify.API.query(request: request).response;
    final items = response.data?.items ?? [];

    // 4. Local Sort (Since list queries don't support 'sortBy' directly)
    final sortedItems = List<JobTag?>.from(items)
      ..sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));

    return sortedItems.whereType<JobTag>().toList();
  }

  Future<PaginatedResult<Job>?> getJobs({
    int limit = 10,
    PaginatedResult<Job>? previousResult,
    String query = "",
    String tag = "All",
  }) async {
    if (!(previousResult == null) && (previousResult.hasNextResult)) {
      final secondRequest = previousResult.requestForNextResult;
      final secondResult = await Amplify.API
          .query(request: secondRequest!)
          .response;
      return secondResult.data;
    }

    QueryPredicate? filter;

    // 1. Logic remains the same (This is already a QueryPredicate)
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
    final firstRequest = ModelQueries.list<Job>(
      Job.classType,
      limit: limit,
      where: filter,
    );
    final firstResult = await Amplify.API.query(request: firstRequest).response;
    return firstResult.data;
  }
}
