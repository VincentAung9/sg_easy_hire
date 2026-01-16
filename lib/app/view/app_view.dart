import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/box_keys.dart';
import 'package:sg_easy_hire/core/localization/domain/language_switch_cubit.dart';
import 'package:sg_easy_hire/core/router/app_router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';
import 'package:sg_easy_hire/core/utils/toast.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart';
import 'package:sg_easy_hire/features/notification/notification_count_cubit.dart';
import 'package:sg_easy_hire/features/notification/notification_service.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_bloc.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_event.dart';
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
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool isInitialized = false;
  @override
  void initState() {
    super.initState();
    NotificationService.handlePermissions();
    subscribeNotification();
    subscribeAuthToken();
  }

  Future<void> subscribeNotification() async {
    try {
      NotificationService.subscribeNotificationReceivedInForeground.onData((
        message,
      ) {
        safePrint(
          "🔥 subscriptionNotificationOnData: ${message.data.containsKey("pinpoint.jsonBody")}",
        );
        if (!message.data.containsKey("pinpoint.jsonBody")) {
          //mean not chat noti
          showNoti(
            AppRouter.rootNavigatorKey.currentContext!,
            message.title ?? "",
            message.body ?? "",
          );
        }
        AppRouter.rootNavigatorKey.currentContext!
            .read<NotificationCountCubit>()
            .increaseCount();
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
        Hive.box<String>(name: tokenBox).put(tokenKey, token);
        safePrint("🌈TOKEN: $token");
        context.read<HelperCoreBloc>().add(UpdateDeviceToken(token: token));
      });
    } catch (e) {
      safePrint("🌈Subscribe Auth Token Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("🌈App View Build..........");
    return BlocListener<HelperCoreBloc, HelperCoreState>(
      listener: (context, state) {
        if (state.currentUser?.skills?.isNotEmpty ?? false) {
          //everytime skills changed, need to retrieve recommended jobs
          debugPrint("🌈 Getting recommended job........");
          context.read<HomeBloc>().add(
            GetRecommendJobsEvent(
              skills: state.currentUser?.skills?.join(",") ?? "",
            ),
          );
        }
        if (!isInitialized && !(state.currentUser == null)) {
          debugPrint(
            "🔥-------🌈 Only one time User in App View State: ${state.currentUser}",
          );
          context.read<HelperCoreBloc>().add(
            GetInitialUserData(id: state.currentUser!.id),
          );
          context.read<HelperCoreBloc>().add(StartSubscribeToUser());
          context.read<PersonalityTestBloc>()
            ..add(GetQuestions())
            ..add(GetUserAnswers())
            ..add(GetTypeMeta());
          context.read<HomeBloc>()
            ..add(StartListenCreateNextInterview())
            ..add(StartListenUpdateNextInterview())
            ..add(StartGetProfileViews())
            ..add(StartListenCreateProfileView())
            ..add(StartGetAppliedJobs())
            ..add(StartListenAppliedJobs())
            ..add(StartGetInterviews())
            ..add(StartGetNextInterview())
            ..add(StartListenCreateInterviews())
            ..add(StartListenUpdateInterviews());

          setState(() {
            isInitialized = true;
          });
        }
      },
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocBuilder<LanguageSwitchCubit, String>(
            builder: (context, lan) {
              return StyledToast(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  locale: Locale(lan),
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
