import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

part 'chat_state.freezed.dart';

enum ChatStateActions { chatRoom, chatMessage, sendMessage }

enum ChatStateStatus { loading, success, failure, none }

@freezed
class ChatState with _$ChatState {
  factory ChatState({
    @Default([]) List<ChatRoom> chatRooms,
    @Default([]) List<ChatMessage> chatMessages,
    @Default(ChatStateActions.chatRoom) ChatStateActions action,
    @Default(ChatStateStatus.none) ChatStateStatus status,
  }) = _ChatState;
}
