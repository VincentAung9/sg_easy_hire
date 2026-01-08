import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:sg_easy_hire/core/utils/queries.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class TicketRepository {
  Future<List<HiredJob>> getHiredJobs(String helperID) async {
    final request = ModelQueries.list(
      HiredJob.classType,
      where: HiredJob.HELPER.eq(helperID),
    );
    final firstResult = GraphQLRequest<PaginatedResult<HiredJob>>(
      document: hiredJobsQuery,
      modelType: const PaginatedModelType(HiredJob.classType),
      variables: request.variables,
      decodePath: 'listHiredJobs',
    );

    final response = await Amplify.API.query(request: firstResult).response;
    if (response.hasErrors) {
      debugPrint("❗️Query Jobs Error: ${response.errors}");
      return [];
    }
    if (!(response.data == null)) {
      debugPrint(
        "✅ Helper ID: $helperID\nQuery Jobs: ${response.data?.items.length}",
      );
      return response.data?.items.whereType<HiredJob>().toList() ?? [];
    }
    return [];
  }

  Future<List<Transaction>> getTransactions(String helperID) async {
    final request = ModelQueries.list(
      Transaction.classType,
      where: Transaction.TRANSFERBY.eq(helperID),
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.hasErrors) {
      debugPrint("Get Transactions Error: ${response.errors}");
      return [];
    }
    if (!(response.data == null)) {
      return response.data?.items.whereType<Transaction>().toList() ?? [];
    }
    return [];
  }

  Future<List<GeneralDocument>> getDocuments(String helperID) async {
    final request = ModelQueries.list(
      GeneralDocument.classType,
      where: GeneralDocument.USER.eq(helperID),
    );
    final response = await Amplify.API.query(request: request).response;
    if (response.hasErrors) {
      debugPrint("Get General Documents Error: ${response.errors}");
      return [];
    }
    if (!(response.data == null)) {
      return response.data?.items.whereType<GeneralDocument>().toList() ?? [];
    }
    return [];
  }
}
