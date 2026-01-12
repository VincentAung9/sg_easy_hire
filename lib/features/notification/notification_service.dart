import 'package:amplify_flutter/amplify_flutter.dart';

class NotificationService {
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
