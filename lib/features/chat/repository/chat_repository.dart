import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sg_easy_hire/models/ChatMessage.dart';
import 'package:sg_easy_hire/models/ChatRoom.dart';
import 'package:sg_easy_hire/models/ChatStatus.dart';

class ChatRepository {
  Future<List<ChatMessage?>> getUnseenMessages(
    String roomID,
    String receiverID,
  ) async {
    return Amplify.DataStore.query(
      ChatMessage.classType,
      where: ChatMessage.CHATROOM
          .eq(roomID)
          .and(ChatMessage.RECEIVER.eq(receiverID))
          .and(ChatMessage.STATUS.ne(ChatStatus.SEEN)),
      sortBy: [ChatMessage.CREATEDAT.descending()],
    );
  }

  Stream<List<ChatMessage>> chatMessages(String roomID) {
    return Amplify.DataStore.observeQuery(
      ChatMessage.classType,
      where: ChatMessage.CHATROOM.eq(roomID),
      sortBy: [ChatMessage.CREATEDAT.descending()],
      
    ).map((i) => i.items);
  }

  Stream<List<ChatRoom>> chatRooms(String userID) {
    return Amplify.DataStore.observeQuery(
      ChatRoom.classType,
      where: ChatRoom.USERA.eq(userID).or(ChatRoom.USERB.eq(userID)),
      sortBy: [ChatRoom.CREATEDAT.descending()],
    ).map((i) => i.items);
  }

  Future<void> createChatRoom(ChatRoom chatRoom) async {
    return Amplify.DataStore.save(chatRoom);
  }

  Future<void> deleteChatRoom(ChatRoom chatRoom) async {
    final newChatRoom = await Amplify.DataStore.query(
      ChatRoom.classType,
      where: ChatRoom.ID.eq(chatRoom.id),
    );
    if (newChatRoom.isNotEmpty) {
      return Amplify.DataStore.delete(newChatRoom.first);
    }
    throw Exception("Chat room not found");
  }

  Future<void> sendMessage(ChatMessage message) async {
    return Amplify.DataStore.save(message);
  }

  Future<void> updateMessage(ChatMessage message) async {
    return Amplify.DataStore.save(message);
  }
}
