import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_bloc.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_state.dart';
import 'package:sg_easy_hire/features/helper_chat/presentation/widget/chat_room_item.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';

class HelperChatsView extends StatelessWidget {
  const HelperChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          "Messages",
          style: textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70, // pt-12 + pb-6
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return state.action == ChatStateActions.chatRoom &&
                  state.status == ChatStateStatus.loading
              ? screenLoading(context: context)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.chatRooms.length,
                  itemBuilder: (context, index) {
                    final chatRoom = state.chatRooms[index];
                    return ChatRoomItem(
                      chatRoom: chatRoom,
                      currentUser: currentUser!,
                    );
                  },
                );
        },
      ),
    );
  }
}
