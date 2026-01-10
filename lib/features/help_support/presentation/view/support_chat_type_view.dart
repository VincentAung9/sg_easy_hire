import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/models/chat_screen_param.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';
import 'package:sg_easy_hire/core/widgets/button_loading.dart';
import 'package:sg_easy_hire/features/help_support/data/ticket_repository.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_bloc.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_event.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_state.dart';
import 'package:sg_easy_hire/features/help_support/presentation/widget/empty_support_type.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class SupportChatTypeView extends StatelessWidget {
  const SupportChatTypeView({super.key});

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
                      "Select an item",
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
          body: state.status == TicketStateStatus.pending
              ? screenLoading(context: context)
              : (state.modelType == RelatedModelType.HIRED_JOB &&
                    state.hiredJobs.isEmpty)
              ? EmptySupportType(
                  modelType: ticketType,
                  modelTypeIcon: modelTypeIcon,
                )
              : (state.modelType == RelatedModelType.TRANSACTION &&
                    state.transactions.isEmpty)
              ? EmptySupportType(
                  modelType: ticketType,
                  modelTypeIcon: modelTypeIcon,
                )
              : (state.modelType == RelatedModelType.DOCUMENT &&
                    state.documents.isEmpty)
              ? EmptySupportType(
                  modelType: ticketType,
                  modelTypeIcon: modelTypeIcon,
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Choose the specific ${ticketType.toLowerCase()} you need help with',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Category List
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          final item = (items[index]).toJson();
                          return MutationBuilder(
                            mutation: TicketRepository.createChatRoom,
                            builder: (context, mutationState, mutation) {
                              return InkWell(
                                onTap: mutationState.isLoading
                                    ? null
                                    : () async {
                                        //TODO: Create SupportTicket & ChatRoom
                                        //and Go chat details
                                        final ticket = SupportTicket(
                                          subject:
                                              "${ticketType} #${item["code"]}",
                                          description:
                                              state.modelType ==
                                                  RelatedModelType.HIRED_JOB
                                              ? (item["job"]
                                                        as Map<
                                                          String,
                                                          dynamic
                                                        >)["title"]
                                                    as String
                                              : "The helper is asking for $ticketType",
                                          status: TicketStatus.OPEN,
                                          relatedModelID: item["id"] as String,
                                          relatedModelType:
                                              state.modelType
                                                  as RelatedModelType,
                                          user: currentUser,
                                          createdAt: TemporalDateTime(
                                            DateTime.now(),
                                          ),
                                        );
                                        final chatRoom = ChatRoom(
                                          createdAt: TemporalDateTime(
                                            DateTime.now(),
                                          ),
                                          name:
                                              "Support: $ticketType $helperID",
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
                                        if (mutate.isSuccess) {
                                          CachedQuery.instance
                                              .invalidateCache();
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
                                      },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: mutationState.isLoading
                                        ? Colors.grey.shade300
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    spacing: 10,
                                    children: [
                                      /* mutationState.isLoading
                                          ? const ButtonLoading(
                                              color: AppColors.primary,
                                            )
                                          : const SizedBox(), */
                                      state.modelType ==
                                              RelatedModelType.HIRED_JOB
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    12,
                                                  ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${(item["employer"] as Map<String, dynamic>)["avatarURL"]}",
                                                width: 60.w,
                                                height: 60.h,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )
                                          : const SizedBox(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 6,
                                        children: [
                                          Text(
                                            state.modelType ==
                                                    RelatedModelType.HIRED_JOB
                                                ? ((item["job"]
                                                          as Map<
                                                            String,
                                                            dynamic
                                                          >)["title"]
                                                      as String)
                                                : state.modelType ==
                                                      RelatedModelType
                                                          .TRANSACTION
                                                ? "${item["currency"]} ${item["amount"]}"
                                                : "${item["url"]}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "created at: ${formatDateMMMdyyyy((TemporalDateTime.fromString(item["createdAt"] as String)).getDateTimeInUtc().toLocal())}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
