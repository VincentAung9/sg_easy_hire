import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/chat/repository/chat_repository.dart';
import 'package:sg_easy_hire/features/helper_chat/presentation/widget/chat_room_item.dart';
import 'package:sg_easy_hire/features/helper_chat/presentation/widget/helper_empty_chat.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/models/User.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';

class HelperChatsView extends StatelessWidget {
  const HelperChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    /*  final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final currentUser = context.read<HelperCoreBloc>().state.currentUser; */
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22, // 3xl
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70, // pt-12 + pb-6
      ),
      body: BlocSelector<HelperCoreBloc, HelperCoreState, User?>(
        selector: (state) => state.currentUser,
        builder: (context, currentUser) {
          return currentUser?.id == null || currentUser?.id.isEmpty == true
              ? screenLoading(context: context)
              : QueryBuilder(
                  query: ChatRepository.getChatRooms(currentUser?.id ?? ""),
                  builder: (context, state) {
                    return state.isLoading
                        ? screenLoading(context: context)
                        : (state.data?.isEmpty ?? false)
                        ? const HelperEmptyChat()
                        : ListView.builder(
                            padding: EdgeInsets.all(16),
                            itemCount: (state.data ?? []).length,
                            itemBuilder: (context, index) {
                              final chatRoom = (state.data ?? [])[index];
                              return ChatRoomItem(
                                chatRoom: chatRoom!,
                                currentUser: currentUser!,
                              );
                            },
                          );
                  },
                );
        },
      ),
    );
  }
}
