import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/helper_user_stream.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';

class AppView extends StatefulWidget {
  final GoRouter router;
  const AppView({
    required this.router,
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    subscribeUserOr(context);
    super.initState();
  }

  /*   @override
  void initState() {
    super.initState();
    subscribeNotification();
    subscribeAuthToken();
  }

  Future<void> subscribeNotification() async {
    try {
      NotificationService.subscribeNotificationReceivedInForeground.onData((
        message,
      ) {
        safePrint(
          "🔥 subscriptionNotificationOpened: ${message.data.containsKey("pinpoint.jsonBody")}",
        );
        if (!message.data.containsKey("pinpoint.jsonBody")) {
          //mean not chat noti
          showNoti(context, message.title ?? "", message.body ?? "");
        }
        context.read<NotificationCountCubit>().increaseCount();
        cachedClearAll();
        if (message.title?.startsWith("You’ve Got a Job Offer") == true) {
          //if offered job status === PENDING
          //increase new count for helper job offers
          context.read<JobofferCountCubit>().increaseCount();
        }
        /*    final userId = context.read<HelperAuthCubic>().state.user?.id;
        safePrint("🪪 UserID: $userId");
        if (message.data.isNotEmpty &&
            message.data.containsKey("receiverID") &&
            message.data["receiverID"] == userId) {
          //make chat logic
        } */
      });
      NotificationService.subscriptionNotificationOpened.onData((message) {
        safePrint("🔥 subscriptionNotificationOpened: ${message.data}");
      });
    } catch (e) {
      safePrint("🔥 Subscripe notification error: $e");
    }
  }

  Future<void> subscribeAuthToken() async {
    try {
      Amplify.Notifications.Push.onTokenReceived.listen((token) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        safePrint("🌈TOKEN: $token");
        final user = context.read<HelperAuthCubic>().state.user;
        await AuthService.updateUser(user: user?.copyWith(token: token));
      });
    } catch (e) {
      safePrint("🌈Subscribe Auth Token Error: $e");
    }
  }
 */
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: const Locale('my'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('my'),
          ],
          routerConfig: widget.router,
        );
      },
    );
  }
}
