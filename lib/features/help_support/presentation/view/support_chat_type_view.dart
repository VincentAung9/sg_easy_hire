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
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class SupportChatTypeView extends StatelessWidget {
  const SupportChatTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
          context,
          state.modelType as RelatedModelType,
        );

        final items = state.modelType == RelatedModelType.HIRED_JOB
            ? state.hiredJobs
            : state.modelType == RelatedModelType.TRANSACTION
            ? state.transactions
            : state.documents;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.canPop()
                  ? context.pop()
                  : context.go(RoutePaths.home),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryPurple50,
                  child: Icon(
                    modelTypeIcon,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ticketType),
                    Text(
                      l10n.supportChatTitleSelectItem,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: state.status == TicketStateStatus.pending
              ? screenLoading(context: context)
              : items.isEmpty
              ? EmptySupportType(
                  modelType: ticketType,
                  modelTypeIcon: modelTypeIcon,
                )
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        l10n.supportChooseSpecific(
                          ticketType.toLowerCase(),
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          final item = items[index].toJson();
                          return ListTile(
                            title: Text(
                              state.modelType == RelatedModelType.HIRED_JOB
                                  ? (item["job"]
                                                as Map<
                                                  String,
                                                  dynamic
                                                >)["title"]
                                            as String? ??
                                        ""
                                  : state.modelType ==
                                        RelatedModelType.TRANSACTION
                                  ? "${item["currency"]} ${item["amount"]}"
                                  : item["url"] as String? ?? '',
                            ),
                            subtitle: Text(
                              l10n.supportCreatedAt(
                                formatDateMMMdyyyy(
                                  TemporalDateTime.fromString(
                                    item["createdAt"] as String,
                                  ).getDateTimeInUtc().toLocal(),
                                ),
                              ),
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
