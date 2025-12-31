import 'dart:convert';
import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_query/cached_query.dart';
import 'package:sg_easy_hire/core/utils/queries.dart';
import 'package:sg_easy_hire/models/ChatMessage.dart';
import 'package:sg_easy_hire/models/ChatRoom.dart';
import 'package:sg_easy_hire/models/ChatStatus.dart';
import 'package:sg_easy_hire/models/Job.dart';
import 'package:sg_easy_hire/models/User.dart';

class ChatRepository {
  static Future<Job?> getJob(String userId) async {
    try {
      final request = ModelQueries.list(
        Job.classType,
        where: Job.CREATOR.eq(userId),
      );

      final response = await Amplify.API.query(request: request).response;
      final job = response.data?.items.firstOrNull;
      return job;
    } catch (e) {
      safePrint("🔥 Get job preferences failed: $e");
      return null;
    }
  }

  static Query<User> getFinalEmployerUser(User user) {
    return Query<User>(
      key: {"main": 'employer-user-${user.id}'},
      queryFn: () async {
        log("🔥 GETTING....Final Employer User: ${user.toString()}");
        try {
          final userResponse = await Amplify.API
              .query(
                request: ModelQueries.get(
                  User.classType,
                  UserModelIdentifier(id: user.id),
                ),
              )
              .response;
          final jobResult = await getJob(user.id);
          log("🔥 Final Employer JOB RESULT: ${user.toString()}");
          if (jobResult == null) {
            log("🔥 Final Employer User: ${user.toString()}");
            return user;
          }
          final finalUser = userResponse.data!.copyWith(
            createdJobs: [jobResult],
          );
          log("🔥 Final Employer User: ${finalUser.toString()}");
          return finalUser;
        } catch (e) {
          log("🔥 Final Employer User Error: ${e.toString()})}");
          return user;
        }
      },
    );
  }

  static Future<List<ChatMessage?>> getUnseenMessages(
    String roomID,
    String receiverID,
  ) async {
    final request = ModelQueries.list(
      ChatMessage.classType,
      where: ChatMessage.CHATROOM
          .eq(roomID)
          .and(ChatMessage.RECEIVER.eq(receiverID))
          .and(ChatMessage.STATUS.ne(ChatStatus.SEEN)),
    );
    final response = await Amplify.API.query(request: request).response;

    final chatMessages = response.data?.items;
    final finalData = (chatMessages ?? [])
      ..sort((a, b) => b!.createdAt!.compareTo(b.createdAt!));
    return finalData;
  }

  static Future<List<ChatMessage?>> getChatMessages(String roomID) async {
    final request = ModelQueries.list(
      ChatMessage.classType,
      where: ChatMessage.CHATROOM.eq(roomID),
    );
    final response = await Amplify.API.query(request: request).response;

    final chatMessages = response.data?.items;
    final finalData = (chatMessages ?? [])
      ..sort((a, b) => a!.createdAt!.compareTo(b!.createdAt!));
    return finalData;
  }

  static Query<List<ChatRoom?>?> getChatRooms(String userID) {
    return Query<List<ChatRoom?>?>(
      key: 'chat-rooms',
      queryFn: () async {
        final response = await Amplify.API
            .query(
              request: GraphQLRequest<String>(
                document: chatRoomsQuery,
                variables: {"userID": userID},
              ),
            )
            .response;
        if (response.hasErrors ||
            response.errors.isNotEmpty ||
            response.data == null) {
          return [];
        }
        final chatRooms =
            // ignore: avoid_dynamic_calls
            ((jsonDecode(response.data ?? "")
                        as Map<String, dynamic>)["listChatRooms"]["items"]
                    as List<dynamic>)
                .map((ch) => ChatRoom.fromJson(ch as Map<String, dynamic>))
                .toList();
        final finalData = chatRooms
          ..sort((a, b) {
            final da = a.createdAt;
            final db = b.createdAt;

            if (da == null && db == null) return 0;
            if (da == null) return -1;
            if (db == null) return 1;

            // ASC: oldest → newest
            return da.compareTo(db);
          });
        return finalData;
      },
    );
  }

  static Mutation<bool, ChatRoom> createChatRoom = Mutation<bool, ChatRoom>(
    mutationFn: (param) async {
      try {
        final request = ModelMutations.create(param);
        final response = await Amplify.API.mutate(request: request).response;

        final createdChatRoom = response.data;
        if (createdChatRoom == null) {
          safePrint('errors: ${response.errors}');
          return false;
        }
        return true;
      } catch (e) {
        safePrint('🔥 Create chat room failed: $e');
        return false;
      }
    },
  );

  static Mutation<bool, ChatRoom> deleteChatRoom = Mutation<bool, ChatRoom>(
    mutationFn: (param) async {
      try {
        final request = ModelMutations.delete(param);
        final response = await Amplify.API.mutate(request: request).response;
        if (response.data == null) {
          safePrint('errors: ${response.errors}');
          return false;
        }
        return true;
      } catch (e) {
        safePrint('🔥 delete chat room failed: $e');
        return false;
      }
    },
  );

  static Future<ChatMessage?> sendMessage(ChatMessage message) async {
    try {
      final request = ModelMutations.create(message);
      final response = await Amplify.API.mutate(request: request).response;
      if (response.hasErrors ||
          response.errors.isNotEmpty ||
          response.data == null) {
        return null;
      }
      return response.data;
    } catch (e) {
      safePrint('🔥 Send message failed: $e');
      return null;
    }
  }

  static Future<ChatMessage?> updateMessage(ChatMessage message) async {
    try {
      final request = ModelMutations.update(message);
      final response = await Amplify.API.mutate(request: request).response;
      if (response.hasErrors ||
          response.errors.isNotEmpty ||
          response.data == null) {
        return null;
      }
      return response.data;
    } catch (e) {
      safePrint('🔥 Send message failed: $e');
      return null;
    }
  }
}
