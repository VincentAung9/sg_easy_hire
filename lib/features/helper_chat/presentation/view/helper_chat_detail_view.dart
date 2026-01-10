import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/models/chat_screen_param.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_bloc.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_event.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_state.dart';
import 'package:sg_easy_hire/features/helper_chat/presentation/widget/chat_message_input.dart';
import 'package:sg_easy_hire/models/ChatMessage.dart';
import 'package:sg_easy_hire/models/ChatRoom.dart';
import 'package:sg_easy_hire/models/User.dart';
import 'package:sg_easy_hire/models/UserRole.dart';

class HelperChatDetailView extends StatelessWidget {
  const HelperChatDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatScreenParam = GoRouterState.of(context).extra as ChatScreenParam;
    final ChatRoom chatRoom = chatScreenParam.chatRoom;
    final User finalReceiverUser = chatScreenParam.finalReceiverUser;
    final User sender = chatScreenParam.sender;
    final UserRole userRole = chatScreenParam.userRole;
    return BlocProvider(
      create: (_) => ChatBloc(currentUserID: sender.id)
        ..add(StartSubscribeMessageStream(chatRoomID: chatRoom.id))
        ..add(StartSubscribeUpdateMessageStream(chatRoomID: chatRoom.id))
        ..add(
          UpdateUnseenMessages(chatRoomID: chatRoom.id, receiverID: sender.id),
        ),
      child: ChatView(
        chatRoom: chatRoom,
        finalReceiverUser: finalReceiverUser,
        sender: sender,
        userRole: userRole,
      ),
    );
  }
}

class ChatView extends StatefulWidget {
  final ChatRoom chatRoom;
  final User finalReceiverUser;
  final User sender;
  final UserRole userRole;
  const ChatView({
    super.key,
    required this.chatRoom,
    required this.finalReceiverUser,
    required this.sender,
    required this.userRole,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Note: The 'Inter' font family should be set in your app's main theme.
    return Scaffold(
      backgroundColor: AppColors.cardLight, // The chat area itself is white
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.chatMessages.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(
                  _scrollController.position.maxScrollExtent,
                );
              }
            });
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverAppBar(),
              widget.chatRoom.supportTicket == null
                  ? _buildSliverActionButtons()
                  : const SliverToBoxAdapter(
                      child: SizedBox(),
                    ),
              _buildChatList(state, context, widget.sender),
            ],
          );
        },
      ),
      bottomNavigationBar: ChatMessageInput(
        chatRoom: widget.chatRoom,
        receiver: widget.finalReceiverUser,
        sender: widget.sender,
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      backgroundColor: AppColors.primary,
      pinned: false,
      floating: true,
      automaticallyImplyLeading: false, // We have a custom back button
      flexibleSpace: FlexibleSpaceBar(
        background: Builder(
          builder: (context) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8B5CF6),
                  Color(0xFF4F46E5),
                ], // purple-600 to indigo-500
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    InkWell(
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(RoutePaths.helperChats);
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withAlpha(230),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Back to Messages",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Profile Info
                    Row(
                      children: [
                        // Profile image loaded via cache + network with placeholder
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  widget.finalReceiverUser.avatarURL ?? "",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Text(
                                    "🤔",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Text(
                                    "🤔",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.chatRoom.supportTicket == null
                                  ? widget.finalReceiverUser.fullName
                                  : widget.chatRoom.supportTicket?.subject ??
                                        "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            !(widget.chatRoom.supportTicket == null)
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.primary,
                                    ),
                                    child: Text(
                                      widget
                                              .chatRoom
                                              .supportTicket
                                              ?.description ??
                                          "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  )
                                : Text(
                                    widget.userRole == UserRole.EMPLOYER
                                        ? "${widget.finalReceiverUser.nationality ?? ""} • ${widget.finalReceiverUser.totalExperiences ?? "0"} exp"
                                        : "${widget.finalReceiverUser.phone}",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverActionButtons() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverActionButtonsDelegate(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.cardLight,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!, width: 1),
            ),
          ),
          child: Row(
            children: [
              /* widget.userRole == UserRole.EMPLOYER
                  ? Expanded(
                      child: _buildActionButton(
                        "View Biodata",
                        Icons.person_outline,
                        Colors.grey[700]!,
                        Colors.white,
                        Border.all(color: Colors.grey[300]!),
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BioData(
                                user: widget.finalReceiverUser,
                                name:
                                    widget
                                        .finalReceiverUser
                                        .personalInformation
                                        ?.fullName ??
                                    "",
                                nationality:
                                    widget
                                        .finalReceiverUser
                                        .personalInformation
                                        ?.nationality ??
                                    "",
                                experience:
                                    widget
                                        .finalReceiverUser
                                        .jobPreferences
                                        ?.experience ??
                                    "",
                                imageUrl:
                                    widget
                                        .finalReceiverUser
                                        .uploadedDocuments
                                        ?.profilePhoto ??
                                    widget.finalReceiverUser.avatarURL ??
                                    "",
                                skills:
                                    widget
                                        .finalReceiverUser
                                        .jobPreferences
                                        ?.skills ??
                                    const [],
                                stats: ({
                                  "Age":
                                      "${calculateAge(widget.finalReceiverUser.personalInformation?.dateOfBirth ?? "")}",
                                  "Height":
                                      "${widget.finalReceiverUser.personalInformation?.height}cm",
                                  "Weight":
                                      "${widget.finalReceiverUser.personalInformation?.weight}kg",
                                  "Exp":
                                      widget
                                          .finalReceiverUser
                                          .jobPreferences
                                          ?.experience ??
                                      "",
                                }),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  :  */
              Expanded(
                child: _buildActionButton(
                  "View Job",
                  Icons.person_outline,
                  Colors.grey[700]!,
                  Colors.white,
                  Border.all(color: Colors.grey[300]!),
                  () {
                    context.go(
                      RoutePaths.jobDetailFullPath,
                      extra: widget.finalReceiverUser.createdJobs!.first,
                    );
                  },
                ),
              ),

              const SizedBox(width: 8),
              const SizedBox(width: 8),
              /* widget.userRole == UserRole.EMPLOYER
                  ? Expanded(
                      child: _buildActionButton(
                        "Interview",
                        Icons.calendar_today_outlined,
                        Colors.white,
                        primaryColor,
                        null,
                      ),
                    )
                  : const SizedBox(), */
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color textColor,
    Color bgColor,
    BoxBorder? border,
    void Function() onPressed,
  ) {
    return Builder(
      builder: (context) {
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 16, color: textColor),
          label: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: bgColor,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: border?.top, // A bit of a hack to use the border
          ),
        );
      },
    );
  }

  Widget _buildChatList(ChatState state, BuildContext context, User sender) {
    return state.status == ChatMessageStatus.loading
        ? SliverToBoxAdapter(child: screenLoading(context: context))
        : SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildDateChip(
                  formatDateMMMdyyyy(
                    widget.chatRoom.createdAt?.getDateTimeInUtc().toLocal() ??
                        DateTime.now(),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoBubble(
                  widget.chatRoom.supportTicket == null
                      ? "Interview completed. You can now chat with ${widget.finalReceiverUser.fullName}"
                      : '''Hello! You've opened a support ticket for "${widget.chatRoom.supportTicket?.description}". How can I assist you today?''',
                ),
                const SizedBox(height: 16),
                ...state.chatMessages.map(
                  (cm) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildMessageBubble(
                      chatMessage: cm!,
                      isSender: cm.sender?.id == sender.id,
                    ),
                  ),
                ),
              ]),
            ),
          );
  }

  Widget _buildDateChip(String text) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBubble(String text) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildMessageBubble({
    bool isSender = false,
    required ChatMessage chatMessage,
  }) {
    return Row(
      mainAxisAlignment: isSender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSender) ...[
          SizedBox(
            width: 40,
            height: 40,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: chatMessage.sender?.avatarURL ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Text("🤔", style: TextStyle(fontSize: 18)),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Text("🤔", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Column(
          crossAxisAlignment: isSender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 260),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSender
                    ? AppColors.senderBubbleColor
                    : AppColors.receiverBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isSender
                      ? const Radius.circular(12)
                      : Radius.zero,
                  bottomRight: isSender
                      ? Radius.zero
                      : const Radius.circular(12),
                ),
              ),
              child: Text(
                // ignore: avoid_dynamic_calls
                jsonDecode(chatMessage.content)["text"] as String? ?? "",
                style: TextStyle(
                  color: isSender ? Colors.white : AppColors.textPrimaryLight,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 4,
              children: [
                Text(
                  timeAgo(
                    chatMessage.createdAt ?? TemporalDateTime(DateTime.now()),
                  ),
                  style: const TextStyle(
                    color: AppColors.textSecondaryLight,
                    fontSize: 12,
                  ),
                ),
                isSender ? getChatStatus(chatMessage.status) : const SizedBox(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// Custom delegate for the sticky action buttons
class _SliverActionButtonsDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverActionButtonsDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 64.0; // Height of the action bar container

  @override
  double get minExtent => 64.0; // Height of the action bar container

  @override
  bool shouldRebuild(_SliverActionButtonsDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
