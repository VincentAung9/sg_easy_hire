import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperHomeRepository {
  //applied job
  Future<void> applyJob(AppliedJob job) async {
    return Amplify.DataStore.save(job);
  }

  //get recommend job
  Future<List<Job?>?> getRecommendedJobs(String? skills) async {
    if (skills?.isEmpty ?? false) {
      return [];
    }
    final skillsList = skills!.split(",");

    dynamic predicate;

    for (final skill in skillsList) {
      final p = Job.REQUIREDSKILLS.contains(skill);

      if (predicate == null) {
        predicate = p;
      } else {
        predicate = predicate.or(
          p,
        ); // <-- Works only when dynamically typed
      }
    }
    
    final response = await Amplify.DataStore.query(
      Job.classType,
      where: predicate as QueryPredicate,
      sortBy: [Job.CREATEDAT.descending()],
    );
    return response;
  }

  Stream<List<Interview>> get interviews {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    return Amplify.DataStore.observeQuery(
      Interview.classType,
      where: Interview.HELPER.eq(hiveUser?.id),
      sortBy: [Interview.CREATEDAT.descending()],
    ).map((i) {
      debugPrint("🌈 Interviews Data Change Event: ${i.items.length}");
      return i.items;
    });
  }

  //listen profile views
  Stream<List<AppliedJob>> get appliedJobs {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    return Amplify.DataStore.observeQuery(
      AppliedJob.classType,
      where: AppliedJob.HELPER.eq(hiveUser?.id),
      sortBy: [AppliedJob.CREATEDAT.descending()],
    ).map((i) {
      debugPrint("🌈 Applied Job Data Change Event: ${i.items.length}");
      return i.items;
    });
  }

  //listen profile views
  Stream<List<ViewHelper>> get profileView {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    return Amplify.DataStore.observeQuery(
      ViewHelper.classType,
      where: ViewHelper.HELPER.eq(hiveUser?.id),
      sortBy: [ViewHelper.CREATEDAT.descending()],
    ).map((i) {
      debugPrint("🌈 Profile View Data Change Event: ${i.items.length}");
      return i.items;
    });
  }

  //listen next interviews
  Stream<Interview?> get nextInterview {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    final currentDateTime = TemporalDateTime(DateTime.now());
    return Amplify.DataStore.observeQuery(
      Interview.classType,
      where: Interview.HELPER
          .eq(hiveUser?.id)
          .and(Interview.STATUS.eq(InterviewStatus.ACCEPTED))
          .and(Interview.CONFIRMEDDATETIME.gt(currentDateTime))
          .or(Interview.CONFIRMEDDATETIME.eq(currentDateTime)),
      sortBy: [Interview.CONFIRMEDDATETIME.ascending()],
    ).map((i) {
      debugPrint("🌈 Next Interview Data Change Event: ${i.items.toString()}");
      if (i.items.isNotEmpty) {
        return i.items.first;
      }
      return null;
    });
  }
}
