import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_query/cached_query.dart';
import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/utils/queries.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class NotificationService {
  static Query<List<NotificationModel>?> getNotifications(String helperId) {
    return Query<List<NotificationModel>?>(
      key: "notifications-${DateTime.now().microsecondsSinceEpoch}",
      queryFn: () async {
        try {
          final request = ModelQueries.list(
            NotificationModel.classType,
            where: NotificationModel.RECEIVER.eq(helperId),
          );
          final graphQLRequest =
              GraphQLRequest<PaginatedResult<NotificationModel>>(
                document: notificationModelsQuery,
                modelType: const PaginatedModelType(
                  NotificationModel.classType,
                ),
                variables: request.variables,
                decodePath: 'listNotificationModels',
              );

          final response = await Amplify.API
              .query(request: graphQLRequest)
              .response;
          debugPrint(
            "🔥 Notification Model Response: ${response.errors}\nData: ${response.data?.items.length}",
          );
          final todos = response.data?.items;
          final sorted = (todos ?? [])
            ..sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));
          return sorted.whereType<NotificationModel>().toList();
        } catch (e) {
          debugPrint(
            "🔥 Catch Notification Model Error Response: ${e}",
          );
        }
      },
    );
  }

  static void handlePermissions() async {
    final status = await Amplify.Notifications.Push.getPermissionStatus();
    switch (status) {
      case PushNotificationPermissionStatus.granted:
        // no further action is required, user has already granted permissions
        break;
      case PushNotificationPermissionStatus.denied:
        // further attempts to request permissions will no longer do anything
        //continueWithoutPushNotifications();
        break;
      case PushNotificationPermissionStatus.shouldRequest:
        // go ahead and request permissions from the user
        await Amplify.Notifications.Push.requestPermissions();
        break;
      case PushNotificationPermissionStatus.shouldExplainThenRequest:
        // you should display some explanation to your user before requesting permissions
        //await explainUpcomingPermissionRequest();
        // then request permissions
        await Amplify.Notifications.Push.requestPermissions();
        break;
    }
  }

  static final subscribeNotificationReceivedInForeground = Amplify
      .Notifications
      .Push
      .onNotificationReceivedInForeground
      .listen((notification) {
        safePrint(
          "🔥 onNotificationReceivedInForeground: ${notification.data}",
        );
      });
  static final subscriptionNotificationOpened = Amplify
      .Notifications
      .Push
      .onNotificationOpened
      .listen((notification) {
        safePrint("🔥 onNotificationOpened ${notification.data}");
      });
}
