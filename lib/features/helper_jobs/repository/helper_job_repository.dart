import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';
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
    //we find first, if exist do nothing
    final getRequest = ModelQueries.list(
      AppliedJob.classType,
      where: AppliedJob.JOB
          .eq(job.job?.id)
          .and(AppliedJob.HELPER.eq(job.helper?.id)),
    );
    final getResult = await Amplify.API.query(request: getRequest).response;
    if (getResult.data?.items.isNotEmpty ?? false) {
      throw Exception("You have already applied for this job.");
    }
    final offerJobResponse = await Amplify.API
        .query(
          request: ModelQueries.list(
            JobOffer.classType,
            where: JobOffer.JOB
                .eq(job.job?.id)
                .and(JobOffer.HELPER.eq(job.helper?.id)),
          ),
        )
        .response;
    if (offerJobResponse.data?.items.isNotEmpty ?? false) {
      throw Exception("Employer have already offered you.");
    }
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
                .or(Job.FAMILYMEMBERS.eq(int.tryParse(query))),
          );
    } else if (query.isNotEmpty) {
      filter = Job.TITLE
          .contains(query)
          .or(Job.LOCATION.contains(query))
          .or(Job.FAMILYMEMBERS.eq(int.tryParse(query)));
    } else if (tag != "All") {
      filter = Job.TAGS.contains(tag);
    }
    final firstRequest = ModelQueries.list<Job>(
      Job.classType,
      limit: limit,
      where: filter,
    );
    const String graphQLDocument = '''
  query GetJobsWithApps(\$filter: ModelJobFilterInput, \$limit: Int, \$nextToken: String) {
    listJobs(filter: \$filter, limit: \$limit, nextToken: \$nextToken) {
        items {
         createdAt
    updatedAt
  id
  code
  title
  location
  salary
  currency
  payPeriod
  familyMembers
  childCount
  adultCount
  childAges
  elderlyCount
  homeType
  roomType
  requiredSkills
  note
  accommodation
  offdays
  tags
  requiredPersonalityType
  status
  creatorID
  creator {
  id
  fullName
  avatarURL
  }
          applications {
            items {
             id
  code
  status
  adminActionStatus
  updatedBy
  completedProcesses
  helper {
  id
  }
            }
          }
          savedJobs {
          items{
            id
            user {
            id
            }
          }}
           jobsOffer{
          items{
          id
          helper {
          id
          }
          }
          }
        }
        nextToken
      }
    }
  ''';

    // final firstResult = await Amplify.API.query(request: firstRequest).response;
    final firstResult = GraphQLRequest<PaginatedResult<Job>>(
      document: graphQLDocument,
      modelType: const PaginatedModelType(Job.classType),
      variables: firstRequest.variables,
      decodePath: 'listJobs',
    );

    final response = await Amplify.API.query(request: firstResult).response;
    if (response.hasErrors) {
      debugPrint("❗️Query Jobs Error: ${response.errors}");
    }
    return response.data;
  }
}
