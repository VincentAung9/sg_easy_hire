import 'package:sg_easy_hire/models/ChatMessage.dart';

class ChatEvent {}

class StartSubscribeMessageStream extends ChatEvent {
  final String chatRoomID;
  StartSubscribeMessageStream({required this.chatRoomID});
}

class StartSubscribeUpdateMessageStream extends ChatEvent {
  final String chatRoomID;
  StartSubscribeUpdateMessageStream({required this.chatRoomID});
}

class AddNewChatMessage extends ChatEvent {
  final ChatMessage chatMessage;
  AddNewChatMessage({required this.chatMessage});
}

class AddUpdateChatMessage extends ChatEvent {
  final ChatMessage chatMessage;
  AddUpdateChatMessage({required this.chatMessage});
}

class UpdateUnseenMessages extends ChatEvent {
  final String chatRoomID;
  final String receiverID;
  UpdateUnseenMessages({required this.chatRoomID, required this.receiverID});
}

class UpdateUnseenMessage extends ChatEvent {
  final ChatMessage chatMessage;
  UpdateUnseenMessage({required this.chatMessage});
}
