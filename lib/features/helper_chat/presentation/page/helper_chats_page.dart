import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_bloc.dart';
import 'package:sg_easy_hire/features/chat/domain/chat_event.dart';
import 'package:sg_easy_hire/features/chat/repository/chat_repository.dart';
import 'package:sg_easy_hire/features/helper_chat/presentation/view/helper_chats_view.dart';

class HelperChatsPage extends StatelessWidget {
  const HelperChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatBloc(repository: ChatRepository())
            ..add(StartSubscribeChatRoomsStream()),
      child: const HelperChatsView(),
    );
  }
}
