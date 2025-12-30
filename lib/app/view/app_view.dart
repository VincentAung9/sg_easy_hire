import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/localization/domain/language_switch_cubit.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart';
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
  bool isInitialized = false;

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
              return MaterialApp.router(
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
              );
            },
          );
        },
      ),
    );
  }
}
