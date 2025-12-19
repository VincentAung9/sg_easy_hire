import 'package:sg_easy_hire/models/ChatMessage.dart';

class ChatEvent {}

class StartSubscribeMessageStream extends ChatEvent {
  final String chatRoomID;
  StartSubscribeMessageStream({required this.chatRoomID});
}

class StartSubscribeChatRoomsStream extends ChatEvent {
  StartSubscribeChatRoomsStream();
}

class AddNewChatMessage extends ChatEvent {
  final ChatMessage chatMessage;
  AddNewChatMessage({required this.chatMessage});
}

class AddUpdateChatMessage extends ChatEvent {
  final ChatMessage chatMessage;
  AddUpdateChatMessage({required this.chatMessage});
}
