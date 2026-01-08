import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';
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
    final helperID = context.read<HelperCoreBloc>().state.currentUser?.id ?? "";
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
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              spacing: 10,
                              children: [
                                state.modelType == RelatedModelType.HIRED_JOB
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
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
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      )
                                    : const SizedBox(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                RelatedModelType.TRANSACTION
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
