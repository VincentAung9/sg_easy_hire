import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_bloc.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_event.dart';
import 'package:sg_easy_hire/models/ChatMessage.dart';
import 'package:sg_easy_hire/models/ChatRoom.dart';
import 'package:sg_easy_hire/models/ChatStatus.dart';
import 'package:sg_easy_hire/models/User.dart';

class ChatMessageInput extends StatefulWidget {
  final ChatRoom chatRoom;
  final User sender;
  final User receiver;
  const ChatMessageInput({
    super.key,
    required this.chatRoom,
    required this.sender,
    required this.receiver,
  });

  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  TextEditingController chatTextController = TextEditingController();
  @override
  void dispose() {
    chatTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        8,
      ).copyWith(bottom: 8 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: chatTextController,
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: const TextStyle(color: AppColors.textSecondaryLight),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (chatTextController.text.isNotEmpty) {
                //send chatText message
                context.read<ChatBloc>().add(
                  AddNewChatMessage(
                    chatMessage: ChatMessage(
                      content: jsonEncode({"text": chatTextController.text}),
                      chatRoom: widget.chatRoom,
                      sender: widget.sender,
                      receiver: widget.receiver,
                      status: ChatStatus.SENT,
                      createdAt: TemporalDateTime(DateTime.now()),
                    ),
                  ),
                );
                //clear text
                chatTextController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(40, 40),
              padding: EdgeInsets.zero,
            ),
            child: const Icon(Icons.send, size: 20),
          ),
        ],
      ),
    );
  }
}
