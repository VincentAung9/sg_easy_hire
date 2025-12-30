import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperHomeRepository {
  Future<void> updateInterview(Interview interview) async {
    final request = ModelMutations.update(interview);
    final result = await Amplify.API.mutate(request: request).response;
    if (result.hasErrors) {
      throw Exception("${result.errors}");
    }
  }

  //applied job
  Future<void> applyJob(AppliedJob job, Job parentJob) async {
    //we find first, if exist do nothing
    final getRequest = ModelQueries.list(
      AppliedJob.classType,
      where: AppliedJob.JOB
          .eq(parentJob.id)
          .and(AppliedJob.HELPER.eq(job.helper?.id)),
    );
    final getResult = await Amplify.API.query(request: getRequest).response;
    if (getResult.data?.items.isNotEmpty ?? false) {
      throw Exception("You have already applied for this job.");
    }
    final request = ModelMutations.create(job);
    final result = await Amplify.API.mutate(request: request).response;
    if (result.hasErrors) {
      throw Exception("${result.errors}");
    }
    final requestJob = ModelMutations.update(parentJob);
    final resultJob = await Amplify.API.mutate(request: requestJob).response;
    if (resultJob.hasErrors) {
      throw Exception("${resultJob.errors}");
    }
  }

  Future<List<Interview>> getInterviews() async {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);

    // 3. Create the request using the signature you provided
    final request = ModelQueries.list<Interview>(
      Interview.classType,
      where: Interview.HELPER.eq(hiveUser?.id),
    );

    try {
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items ?? [];

      // 4. Local Sort (Since list queries don't support 'sortBy' directly)
      final sortedItems = List<Interview?>.from(items)
        ..sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));

      return sortedItems.whereType<Interview>().toList();
    } on ApiException catch (e) {
      debugPrint('Query failed: $e');
      return [];
    }
  }

  Future<Interview?> getNextInterview() async {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    final currentDateTime = TemporalDateTime(DateTime.now());
    // 3. Create the request using the signature you provided
    final request = ModelQueries.list<Interview>(
      Interview.classType,
      where: Interview.HELPER
          .eq(hiveUser?.id)
          .and(Interview.STATUS.eq(InterviewStatus.ACCEPTED))
          .and(Interview.CONFIRMEDDATETIME.gt(currentDateTime))
          .or(Interview.CONFIRMEDDATETIME.eq(currentDateTime)),
    );

    try {
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items ?? [];

      // 4. Local Sort (Since list queries don't support 'sortBy' directly)
      final sortedItems = List<Interview?>.from(items)
        ..sort((a, b) => a!.createdAt!.compareTo(b!.createdAt!));

      if (sortedItems.isNotEmpty) {
        return sortedItems.whereType<Interview>().first;
      } else {
        return null;
      }
    } on ApiException catch (e) {
      debugPrint('Query failed: $e');
      return null;
    }
  }

  Future<List<AppliedJob>> getAppliedJobs() async {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);

    // 3. Create the request using the signature you provided
    final request = ModelQueries.list<AppliedJob>(
      AppliedJob.classType,
      where: AppliedJob.HELPER.eq(hiveUser?.id),
    );

    try {
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items ?? [];

      // 4. Local Sort (Since list queries don't support 'sortBy' directly)
      final sortedItems = List<AppliedJob?>.from(items)
        ..sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));

      return sortedItems.whereType<AppliedJob>().toList();
    } on ApiException catch (e) {
      debugPrint('Query failed: $e');
      return [];
    }
  }

  Future<List<ViewHelper>> getProfileViews() async {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);

    // 3. Create the request using the signature you provided
    final request = ModelQueries.list<ViewHelper>(
      ViewHelper.classType,
      where: ViewHelper.HELPER.eq(hiveUser?.id),
    );

    try {
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items ?? [];

      // 4. Local Sort (Since list queries don't support 'sortBy' directly)
      final sortedItems = List<ViewHelper?>.from(items)
        ..sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));

      return sortedItems.whereType<ViewHelper>().toList();
    } on ApiException catch (e) {
      debugPrint('Query failed: $e');
      return [];
    }
  }

  //get recommend job
  Future<List<Job>> getRecommendedJobs(String? skills) async {
    if (skills == null || skills.isEmpty) return [];

    final skillsList = skills.split(",");
    final List<QueryPredicate> predicates = skillsList.map((skill) {
      return Job.REQUIREDSKILLS.contains(skill.trim());
    }).toList();

    final groupPredicate = QueryPredicateGroup(
      QueryPredicateGroupType.or,
      predicates,
    );

    // 1. Use the standard helper to generate the variables for us.
    // This correctly serializes the 'QueryPredicateGroup' into a JSON-encodable Map.
    final helperRequest = ModelQueries.list<Job>(
      Job.classType,
      where: groupPredicate,
    );

    const String graphQLDocument = '''
    query GetJobsWithApps(\$filter: ModelJobFilterInput) {
      listJobs(filter: \$filter) {
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

    try {
      // 2. Extract the variables from the helperRequest.
      // This variable map now contains the filter in a format AppSync can read.
      final request = GraphQLRequest<PaginatedResult<Job>>(
        document: graphQLDocument,
        modelType: const PaginatedModelType(Job.classType),
        variables: helperRequest.variables,
        decodePath: 'listJobs',
      );

      final response = await Amplify.API.query(request: request).response;

      if (response.hasErrors) {
        debugPrint('GraphQL Errors: ${response.errors}');
        return [];
      }

      final items = response.data?.items ?? [];

      return items.whereType<Job>().toList()
        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    } on ApiException catch (e) {
      debugPrint('Query failed: $e');
      return [];
    }
  }

  /* Future<List<Job>> getRecommendedJobs(String? skills) async {
    if (skills == null || skills.isEmpty) return [];

    final skillsList = skills.split(",");

    // 1. Create the list of predicates for each skill
    final List<QueryPredicate> predicates = skillsList.map((skill) {
      return Job.REQUIREDSKILLS.contains(skill.trim());
    }).toList();

    // 2. Build the group.
    // This class implements QueryPredicate<Model>, so it fits the 'where' parameter.
    final QueryPredicate groupPredicate = QueryPredicateGroup(
      QueryPredicateGroupType.or,
      predicates,
    );

    // 3. Create the request using the signature you provided
    final request = ModelQueries.list<Job>(
      Job.classType,
      where: groupPredicate,
    );

    try {
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items ?? [];

      // 4. Local Sort (Since list queries don't support 'sortBy' directly)
      final sortedItems = List<Job?>.from(items)
        ..sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));

      return sortedItems.whereType<Job>().toList();
    } on ApiException catch (e) {
      debugPrint('Query failed: $e');
      return [];
    }
  }
 */
  Stream<Interview?> get createInterviews {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    debugPrint("🌈 Interviews stream hive user: ${hiveUser?.id}");
    final subscriptionRequest = ModelSubscriptions.onCreate(
      Interview.classType,
      where: Interview.HELPER.eq(hiveUser?.id),
    );
    return Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () => safePrint('Subscription established'),
        )
        .map((i) {
          debugPrint(
            "🌈 Snapshot: ${i.data} items.",
          );
          return i.data;
        });
  }

  Stream<Interview?> get updateInterviews {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    debugPrint("🌈 Interviews stream hive user: ${hiveUser?.id}");
    final subscriptionRequest = ModelSubscriptions.onUpdate(
      Interview.classType,
      where: Interview.HELPER.eq(hiveUser?.id),
    );
    return Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () => safePrint('Subscription established'),
        )
        .map((i) {
          debugPrint(
            "🌈 Snapshot: ${i.data} items.",
          );
          return i.data;
        });
  }

  //listen profile views
  Stream<ViewHelper?> get profileView {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    debugPrint("🌈 Profile view stream hive user: ${hiveUser?.id}");
    final subscriptionRequest = ModelSubscriptions.onCreate(
      ViewHelper.classType,
      where: ViewHelper.HELPER.eq(hiveUser?.id),
    );
    return Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () => safePrint('Subscription established'),
        )
        .map((i) {
          debugPrint(
            "🌈 Snapshot: ${i.data} items.",
          );
          return i.data;
        });
  }

  Stream<AppliedJob?> get createAppliedJob {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    debugPrint("🌈 Interviews stream hive user: ${hiveUser?.id}");
    final subscriptionRequest = ModelSubscriptions.onCreate(
      AppliedJob.classType,
      where: AppliedJob.HELPER.eq(hiveUser?.id),
    );
    return Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () => safePrint('Subscription established'),
        )
        .map((i) {
          debugPrint(
            "🌈 Snapshot: ${i.data} items.",
          );
          return i.data;
        });
  }

  //listen next interviews
  Stream<Interview?> get createNextInterview {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    debugPrint("🌈 Next interview stream hive user: ${hiveUser?.id}");
    final currentDateTime = TemporalDateTime(DateTime.now());
    final subscriptionRequest = ModelSubscriptions.onCreate(
      Interview.classType,
      where: Interview.HELPER
          .eq(hiveUser?.id)
          .and(Interview.STATUS.eq(InterviewStatus.ACCEPTED))
          .and(Interview.CONFIRMEDDATETIME.gt(currentDateTime))
          .or(Interview.CONFIRMEDDATETIME.eq(currentDateTime)),
    );
    return Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () => safePrint('Subscription established'),
        )
        .map((i) {
          debugPrint(
            "🌈 Snapshot: ${i.data} items.",
          );
          return i.data;
        });
  }

  Stream<Interview?> get updateNextInterview {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    debugPrint("🌈 Next interview stream hive user: ${hiveUser?.id}");
    final currentDateTime = TemporalDateTime(DateTime.now());
    final subscriptionRequest = ModelSubscriptions.onUpdate(
      Interview.classType,
      where: Interview.HELPER
          .eq(hiveUser?.id)
          .and(Interview.STATUS.eq(InterviewStatus.ACCEPTED))
          .and(Interview.CONFIRMEDDATETIME.gt(currentDateTime))
          .or(Interview.CONFIRMEDDATETIME.eq(currentDateTime)),
    );
    return Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () => safePrint('Subscription established'),
        )
        .map((i) {
          debugPrint(
            "🌈 Snapshot: ${i.data} items.",
          );
          return i.data;
        });
  }
}
