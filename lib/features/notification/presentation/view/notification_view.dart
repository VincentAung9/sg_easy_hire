import 'dart:convert';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/core/widgets/empty_list.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/notification/notification_service.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/NotificationModel.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return Scaffold(
      appBar: AppBar(
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
        title: Text(l10n.notifications),
      ),
      body: QueryBuilder(
        query: NotificationService.getNotifications(currentUser?.id ?? ""),
        builder: (_, state) {
          if (state.isLoading) {
            return screenLoading(context: context);
          }
          if (state.isSuccess && (state.data?.isEmpty ?? false)) {
            return EmptyList(
              icon: FontAwesomeIcons.bell,
              body: l10n.notificationsEmpty,
            );
          }
          debugPrint("🌈 Noti list: ${state.data?.length}");
          return ListView.builder(
            itemCount: state.data?.length ?? 0,
            itemBuilder: (context, index) {
              final noti = (state.data ?? [])[index];
              return NotificationCard(
                noti: noti,
                size: size,
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationModel noti;
  final Size size;
  const NotificationCard({required this.noti, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (noti.data != null && noti.data!.isNotEmpty) {
          try {
            dynamic decoded = jsonDecode(noti.data!);

            // 🔁 Handle double-encoded JSON
            if (decoded is String) {
              decoded = jsonDecode(decoded);
            }

            if (decoded is Map<String, dynamic>) {
              final type = decoded["__typename"];
              switch (type) {
                case "User":
                  context.go(RoutePaths.profile);
                  break;
                case "Interview":
                  context.go(RoutePaths.helperInterviews);
                  break;
                case "JobOffer":
                  context.go(RoutePaths.jobOffers);
                  break;
                default:
                  final t = AppLocalizations.of(context);
                  showWarning(context, t.notificationDetailsUnavailableTitle);
              }
            } else {
              debugPrint("⚠️ Unexpected data format: $decoded");
            }
          } catch (e) {
            debugPrint("❌ Notification data parse error: $e");
          }
        }
      },
      child: Container(
        width: size.width * 0.95,
        constraints: BoxConstraints(
          maxHeight: size.height * 0.25, // 🔑 limit toast height (25% screen)
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryPurple50,
              radius: 28,
              child: Icon(
                notificationModelTypeIcon(noti.notificationType),
                size: 24,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  Text(
                    noti.title ?? "",
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    noti.body ?? "",
                    softWrap: true,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
