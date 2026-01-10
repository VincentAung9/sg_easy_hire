import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/models/chat_screen_param.dart';
import 'package:sg_easy_hire/core/router/route_paths.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/core/widgets/button_loading.dart';
import 'package:sg_easy_hire/features/help_support/data/ticket_repository.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_bloc.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_event.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_state.dart';
import 'package:sg_easy_hire/features/help_support/presentation/view/helper_support_chat_view.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class SupportOtherTypeView extends StatefulWidget {
  const SupportOtherTypeView({super.key});

  @override
  State<SupportOtherTypeView> createState() => _SupportOtherTypeViewState();
}

class _SupportOtherTypeViewState extends State<SupportOtherTypeView> {
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    final helperID = currentUser?.id ?? "";
    final type = GoRouterState.of(context).extra! as RelatedModelType;
    context.read<TicketBloc>().add(
      SelectTicketType(modelType: type, helperID: helperID),
    );

    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        final modelTypeIcon = relatedModelTypeToIcon(
          state.modelType as RelatedModelType,
        );
        final ticketType = relatedModelTypeToString(
          state.modelType as RelatedModelType,
        );
        final items = state.modelType == RelatedModelType.HIRED_JOB
            ? state.hiredJobs
            : state.modelType == RelatedModelType.TRANSACTION
            ? state.transactions
            : state.documents;
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leadingWidth: 30,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(RoutePaths.home);
                }
              },
            ),
            title: Row(
              spacing: 8,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryPurple50,
                  radius: 20,
                  child: Icon(
                    modelTypeIcon,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticketType,
                    ),
                    const Text(
                      "Enter ticket title",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          backgroundColor: Colors.grey[50],
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Describe Your Issue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Enter a brief title for your support ticket",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: textEditingController,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Enter a brief title";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        disabledBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  MutationBuilder(
                    mutation: TicketRepository.createChatRoom,
                    builder: (context, mutationState, mutation) {
                      return SizedBox(
                        width: 200.w,
                        child: ElevatedButton(
                          onPressed: mutationState.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    final ticket = SupportTicket(
                                      subject: "Other #${currentUser?.code}",
                                      description: textEditingController.text,
                                      status: TicketStatus.OPEN,
                                      relatedModelID: currentUser?.id,
                                      relatedModelType:
                                          RelatedModelType.GENERAL,
                                      user: currentUser,
                                      createdAt: TemporalDateTime(
                                        DateTime.now(),
                                      ),
                                    );
                                    final chatRoom = ChatRoom(
                                      createdAt: TemporalDateTime(
                                        DateTime.now(),
                                      ),
                                      name: "Support: Other ${currentUser?.id}",
                                      userA: currentUser,
                                      userB: state.admin,
                                      supportTicket: ticket,
                                    );
                                    final mutate = await mutation(
                                      CreateTicketParam(
                                        ticket: ticket,
                                        chatRoom: chatRoom,
                                      ),
                                    );
                                    if (mutate.data == false) {
                                      showError(
                                        context,
                                        "Something was wrong!",
                                      );
                                      return;
                                    }
                                    if (mutate.isSuccess) {
                                      CachedQuery.instance.invalidateCache();
                                      context.go(
                                        RoutePaths.helperChatDetail,
                                        extra: ChatScreenParam(
                                          userRole: UserRole.HELPER,
                                          chatRoom: chatRoom,
                                          finalReceiverUser: state.admin!,
                                          sender: currentUser!,
                                        ),
                                      );
                                    }
                                  }
                                },
                          child: mutationState.isLoading
                              ? SizedBox(
                                  height: 30,
                                  width: 200.w,
                                  child: const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text("Start Chat"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
