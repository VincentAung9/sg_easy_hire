import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_event.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_state.dart';
import 'package:sg_easy_hire/features/chat/repository/chat_repository.dart';
import 'package:sg_easy_hire/models/ChatRoom.dart';
import 'package:sg_easy_hire/models/User.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;
  ChatBloc({required this.repository}) : super(ChatState()) {
    on<StartSubscribeMessageStream>(_onStartSubscribeMessage);
    on<AddNewChatMessage>(_onAddChatMessage);
    on<StartSubscribeChatRoomsStream>(_onChatRoomStream);
  }

  FutureOr<void> _onStartSubscribeMessage(
    StartSubscribeMessageStream event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ChatStateStatus.loading,
        action: ChatStateActions.chatMessage,
      ),
    );
    await emit.onEach(
      repository.chatMessages(event.chatRoomID),
      onData: (cm) => state.copyWith(
        chatMessages: cm,
        status: ChatStateStatus.success,
        action: ChatStateActions.chatMessage,
      ),
      onError: (_, __) {
        emit(
          state.copyWith(
            status: ChatStateStatus.failure,
            action: ChatStateActions.chatMessage,
          ),
        );
      },
    );
  }

  FutureOr<void> _onAddChatMessage(
    AddNewChatMessage event,
    Emitter<ChatState> emit,
  ) async {
    List<ChatRoom> oldChatRooms = List.from(state.chatRooms);
    List<ChatRoom> newChatRooms = List.from(state.chatRooms);
    final roomIndex = newChatRooms.indexWhere(
      (cr) => cr.id == event.chatMessage.chatRoom?.id,
    );
    final targetRoom = newChatRooms[roomIndex];
    newChatRooms[roomIndex] = targetRoom.copyWith(
      chatMessages: [...(targetRoom.chatMessages ?? []), event.chatMessage],
    );
    emit(state.copyWith(chatRooms: newChatRooms));
    try {
      await repository.sendMessage(event.chatMessage);
      emit(
        state.copyWith(
          status: ChatStateStatus.success,
          action: ChatStateActions.sendMessage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          chatRooms: oldChatRooms,
          status: ChatStateStatus.failure,
          action: ChatStateActions.sendMessage,
        ),
      );
    }
  }

  FutureOr<void> _onChatRoomStream(
    StartSubscribeChatRoomsStream event,
    Emitter<ChatState> emit,
  ) async {
    final box = Hive.box<User>(name: userBox);
    final hiveUser = box.get(userBoxKey);
    emit(
      state.copyWith(
        status: ChatStateStatus.loading,
        action: ChatStateActions.chatRoom,
      ),
    );
    if (hiveUser == null) {
      emit(
        state.copyWith(
          status: ChatStateStatus.failure,
          action: ChatStateActions.chatRoom,
        ),
      );
      return;
    }
    await emit.onEach(
      repository.chatRooms(hiveUser.id),
      onData: (cr) {
        emit(
          state.copyWith(
            chatRooms: cr,
            status: ChatStateStatus.success,
            action: ChatStateActions.chatRoom,
          ),
        );
      },
      onError: (_, __) {
        emit(
          state.copyWith(
            status: ChatStateStatus.failure,
            action: ChatStateActions.chatRoom,
          ),
        );
      },
    );
  }
}
