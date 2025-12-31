import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/ChatMessage.dart';

part 'chat_state.freezed.dart';

enum ChatMessageStatus { none, loading, success, failed }

@freezed
abstract class ChatState with _$ChatState {
  factory ChatState({
    @Default([]) List<ChatMessage?> chatMessages,
    @Default(ChatMessageStatus.none) ChatMessageStatus status,
  }) = _ChatState;
}
