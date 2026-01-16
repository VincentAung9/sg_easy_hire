import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_query/cached_query.dart';
import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/utils/queries.dart';
import 'package:sg_easy_hire/models/JobOffer.dart';

class ApplyJobParam {
  final String jobId;
  final String helperId;
  ApplyJobParam({required this.jobId, required this.helperId});
}

class OfferJobParam {
  final String jobId;
  final String helperId;
  final String employerId;
  OfferJobParam({
    required this.jobId,
    required this.helperId,
    required this.employerId,
  });
}

class JobService {
  //---------Offer Job
  static Mutation<bool, JobOffer> updateOfferedJob = Mutation<bool, JobOffer>(
    mutationFn: (param) async {
      try {
        final request = ModelMutations.update(param);
        final response = await Amplify.API.mutate(request: request).response;
        //also update interview

        final updatedJobOffered = response.data;
        if (updatedJobOffered == null) {
          safePrint('errors: ${response.errors}');
          return false;
        }
        await CachedQuery.instance.invalidateCache();
        return true;
      } catch (e) {
        safePrint('🔥 Offer Job Failed: $e');
        return false;
      }
    },
  );

  static Query<List<JobOffer?>?> getJobOffers(String helperId) {
    return Query<List<JobOffer?>?>(
      key: "joboffers-${DateTime.now().microsecondsSinceEpoch}",
      queryFn: () async {
        try {
          final request = ModelQueries.list(
            JobOffer.classType,
            where: JobOffer.HELPER.eq(helperId),
          );
          final graphQLRequest = GraphQLRequest<PaginatedResult<JobOffer>>(
            document: jobOffersQuery,
            modelType: const PaginatedModelType(JobOffer.classType),
            variables: request.variables,
            decodePath: 'listJobOffers',
          );

          final response = await Amplify.API
              .query(request: graphQLRequest)
              .response;
          debugPrint(
            "🔥 Job Offer Error Response: ${response.errors}\nData: ${response.data}",
          );
          final todos = response.data?.items;
          final sorted = (todos ?? [])
            ..sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));
          return sorted;
        } catch (e) {
          debugPrint(
            "🔥 Catch Job Offer Error Response: ${e}",
          );
        }
      },
    );
  }
}
