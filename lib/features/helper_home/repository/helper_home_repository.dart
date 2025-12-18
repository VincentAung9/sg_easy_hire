import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperHomeRepository {
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
    );
    return response;
  }

  //listen next interviews
  Stream<Interview> get nextInterview {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    final currentDateTime = TemporalDateTime(DateTime.now());
    return Amplify.DataStore.observe(
      Interview.classType,
      where: Interview.HELPER
          .eq(hiveUser?.id)
          .and(Interview.STATUS.eq(InterviewStatus.ACCEPTED))
          .and(Interview.CONFIRMEDDATETIME.gt(currentDateTime))
          .or(Interview.CONFIRMEDDATETIME.eq(currentDateTime)),
    ).map((i) {
      debugPrint("🌈 Next Interview Data Change Event: ${i.item.toJson()}");
      return i.item;
    });
  }
}
