import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_query/cached_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:sg_easy_hire/core/utils/queries.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class CreateTicketParam {
  final SupportTicket ticket;
  final ChatRoom chatRoom;
  CreateTicketParam({
    required this.ticket,
    required this.chatRoom,
  });
}

class TicketRepository {
  static Mutation<bool, CreateTicketParam> createChatRoom =
      Mutation<bool, CreateTicketParam>(
        mutationFn: (param) async {
          try {
            final response = await createTicketAndChatRoom(
              param.ticket,
              param.chatRoom,
            );
            return response;
          } catch (e) {
            safePrint('🔥 Create chat room failed: $e');
            return false;
          }
        },
      );
  Future<User?> getAdminUser() async {
    try {
      final request = ModelQueries.list(
        User.classType,
        where: User.ROLE.eq(UserRole.ADMIN),
      );
      final response = await Amplify.API.query(request: request).response;
      if (response.hasErrors) {
        return null;
      }
      if (!(response.data == null)) {
        final admin = response.data!.items.first;
        return admin;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> createTicketAndChatRoom(
    SupportTicket ticket,
    ChatRoom chatRoom,
  ) async {
    try {
      final ticketRequest = ModelMutations.create(ticket);
      final ticketResponse = await Amplify.API
          .mutate(request: ticketRequest)
          .response;
      if (ticketResponse.hasErrors) {
        debugPrint("🔥 Ticket Response Error: ${ticketResponse.errors}");
        return false;
      }
      final chatRoomRequest = ModelMutations.create(chatRoom);
      final chatRoomResponse = await Amplify.API
          .mutate(request: chatRoomRequest)
          .response;
      if (ticketResponse.hasErrors || chatRoomResponse.hasErrors) {
        return false;
      }
      if (!(ticketResponse.data == null) && !(chatRoomResponse.data == null)) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("🔥 SupportTicket & ChatRoom Error: $e");
      return false;
    }
  }

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
