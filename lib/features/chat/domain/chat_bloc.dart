import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:cached_query/cached_query.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_event.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_state.dart';
import 'package:sg_easy_hire/features/chat/repository/chat_repository.dart';
import 'package:sg_easy_hire/models/ChatMessage.dart';
import 'package:sg_easy_hire/models/ChatStatus.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String currentUserID;
  ChatBloc({required this.currentUserID}) : super(ChatState()) {
    on<StartSubscribeMessageStream>(_onStartSubscribeMessage);
    on<StartSubscribeUpdateMessageStream>(_onStartSubscribeUpdateMessage);
    on<AddNewChatMessage>(_onAddChatMessage);
    on<UpdateUnseenMessages>(_onUpdateUnseenMessages);
    on<UpdateUnseenMessage>(_onUpdateUnseenMessage);
  }

  FutureOr<void> _onStartSubscribeMessage(
    StartSubscribeMessageStream event,
    Emitter<ChatState> emit,
  ) async {
    //get previous messages
    debugPrint(
      "🔥 Start Subscribe Chat Messages: ChatRoomID: ${event.chatRoomID}....",
    );
    emit(state.copyWith(status: ChatMessageStatus.loading));
    final previousMessageResponse = await ChatRepository.getChatMessages(
      event.chatRoomID,
    );
    debugPrint(
      "🔥 Previous Chat Messages: ${previousMessageResponse.length}....",
    );
    emit(
      state.copyWith(
        status: ChatMessageStatus.success,
        chatMessages: previousMessageResponse,
      ),
    );

    final subscriptionRequest = ModelSubscriptions.onCreate(
      ChatMessage.classType,
      where: ChatMessage.CHATROOM.eq(event.chatRoomID),
    );
    final Stream<GraphQLResponse<ChatMessage>> operation = Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () =>
              safePrint('✉️ Chat Message subscription established'),
        );
    await emit.forEach(
      operation,
      onData: (event) {
        final data = [...state.chatMessages, event.data];
        if (!(event.data == null) &&
            event.data?.receiver?.id == currentUserID) {
          //need to update message status
          add(UpdateUnseenMessage(chatMessage: event.data!));
        }
        return state.copyWith(chatMessages: data);
      },
      onError: (_, __) {
        return state;
      },
    );
  }

  FutureOr<void> _onAddChatMessage(
    AddNewChatMessage event,
    Emitter<ChatState> emit,
  ) async {
    final create = await ChatRepository.sendMessage(event.chatMessage);
    debugPrint(
      "🔥 Created New Chat Message's room id: ${create?.chatRoom?.id}",
    );
    if (create == null) {
      //that means error,so we need to add message locally
      final data = [...state.chatMessages, event.chatMessage];
      emit(state.copyWith(chatMessages: data));
    }
  }

  FutureOr<void> _onUpdateUnseenMessages(
    UpdateUnseenMessages event,
    Emitter<ChatState> emit,
  ) async {
    //if there have message that not read, update them
    final unseenMessages = await ChatRepository.getUnseenMessages(
      event.chatRoomID,
      event.receiverID,
    );
    if (unseenMessages.isNotEmpty) {
      //loop and. update
      for (var message in unseenMessages) {
        if (message == null) continue;
        await ChatRepository.updateMessage(
          message.copyWith(status: ChatStatus.SEEN),
        );
      }
      //update cache invalidate
      CachedQuery.instance.invalidateCache();
    }
  }

  FutureOr<void> _onStartSubscribeUpdateMessage(
    StartSubscribeUpdateMessageStream event,
    Emitter<ChatState> emit,
  ) async {
    final subscriptionRequest = ModelSubscriptions.onUpdate(
      ChatMessage.classType,
      where: ChatMessage.CHATROOM.eq(event.chatRoomID),
    );
    final Stream<GraphQLResponse<ChatMessage>> operation = Amplify.API
        .subscribe(
          subscriptionRequest,
          onEstablished: () =>
              safePrint('✉️ Update Chat Message subscription established'),
        );
    await emit.forEach(
      operation,
      onData: (event) {
        if (!(event.data == null)) {
          //find message
          //update it
          safePrint('✉️ Update Chat Message logic start......');
          final index = state.chatMessages.indexWhere(
            (cm) => cm?.id == event.data?.id,
          );
          if (index != -1) {
            //update
            List<ChatMessage?> preList = List.from(state.chatMessages);
            preList[index] = event.data;
            safePrint(
              '✉️ Update Chat Message event data: ${event.data.toString()}......',
            );
            return state.copyWith(chatMessages: preList);
          }
          return state;
        } else {
          return state;
        }
      },
      onError: (_, __) {
        return state;
      },
    );
  }

  FutureOr<void> _onUpdateUnseenMessage(
    UpdateUnseenMessage event,
    Emitter<ChatState> emit,
  ) async {
    await ChatRepository.updateMessage(
      event.chatMessage.copyWith(status: ChatStatus.SEEN),
    );
  }
}
