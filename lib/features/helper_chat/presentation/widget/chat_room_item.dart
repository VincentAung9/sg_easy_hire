import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';
import 'package:sg_easy_hire/models/ChatMessage.dart';
import 'package:sg_easy_hire/models/ChatRoom.dart';
import 'package:sg_easy_hire/models/ChatStatus.dart';
import 'package:sg_easy_hire/models/User.dart';

class ChatRoomItem extends StatelessWidget {
  const ChatRoomItem({
    super.key,
    required this.chatRoom,
    required this.currentUser,
  });
  final ChatRoom chatRoom;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    final unreadCount = (chatRoom.chatMessages ?? [])
        .where(
          (cm) =>
              cm.status != ChatStatus.SEEN && cm.receiver?.id == currentUser.id,
        )
        .length;
    ChatMessage? lastChatMessage =
        ((chatRoom.chatMessages ?? [])..sort((a, b) {
              final da = a.createdAt;
              final db = b.createdAt;

              if (da == null && db == null) return 0;
              if (da == null) return -1;
              if (db == null) return 1;

              // ASC: oldest → newest
              return da.compareTo(db);
            }))
            .isNotEmpty
        ? chatRoom.chatMessages!.last
        : null;
    final String lastMessage = !(lastChatMessage == null)
        ? (jsonDecode(lastChatMessage.content) as Map<String, dynamic>)["text"]
                  as String? ??
              ""
        : "";
    final messageColor = unreadCount > 0 ? Colors.green : null;
    final receiverUser = chatRoom.userA?.id == currentUser.id
        ? chatRoom.userB!
        : chatRoom.userA!;
    safePrint("🌈 RECEIVER: ${receiverUser.toString()}");
    return InkWell(
      onTap: () {
        },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardLight,
          borderRadius: BorderRadius.circular(16), // rounded-lg
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            buildProfileAvatar(imageUrl: receiverUser.avatarURL),
            /*    Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: emoji != null ? emojiBgColor : iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: emoji != null
                        ? Text(emoji ?? "", style: const TextStyle(fontSize: 24))
                        : Icon(icon, color: iconColor, size: 28),
                  ),
                ),
               */
            const SizedBox(width: 16),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          receiverUser.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          timeAgo(
                            chatRoom.createdAt ??
                                TemporalDateTime(DateTime.now()),
                          ),
                          style: const TextStyle(
                            color: AppColors.textSecondaryLight,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          lastMessage.isNotEmpty
                              ? lastMessage
                              : " Interview completed on ${formatDateMMMdyyyy(chatRoom.createdAt!.getDateTimeInUtc().toLocal())}",
                          style: TextStyle(
                            color: messageColor ?? AppColors.textGrayLight,
                            fontSize: 14,
                            fontWeight: messageColor != null
                                ? FontWeight.w500
                                : FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.green[500],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
