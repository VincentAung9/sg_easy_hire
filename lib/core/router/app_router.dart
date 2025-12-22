import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/hive_storage/hive_storage.dart';
import 'package:sg_easy_hire/core/router/go_refresh_stream.dart';
import 'package:sg_easy_hire/core/router/route_names.dart' show RouteNames;
import 'package:sg_easy_hire/core/router/route_paths.dart';
import 'package:sg_easy_hire/features/auth/models/confirm_sign_up_param.dart';
import 'package:sg_easy_hire/features/biodata/presentation/page/contact_family_page.dart';
import 'package:sg_easy_hire/features/biodata/presentation/page/food_handling_page.dart';
import 'package:sg_easy_hire/features/biodata/presentation/page/job_preference_page.dart';
import 'package:sg_easy_hire/features/biodata/presentation/page/language_spoken_page.dart';
import 'package:sg_easy_hire/features/biodata/presentation/page/medical_history_page.dart';
import 'package:sg_easy_hire/features/biodata/presentation/page/onboarding_biodata_page.dart';
import 'package:sg_easy_hire/features/biodata/presentation/page/personal_info_page.dart';
import 'package:sg_easy_hire/features/biodata/presentation/page/upload_document_page.dart';
import 'package:sg_easy_hire/features/helper_auth/pages/sign_in_page.dart';
import 'package:sg_easy_hire/features/helper_auth/pages/sign_up_page.dart';
import 'package:sg_easy_hire/features/helper_chat/presentation/page/helper_chats_page.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/page/helper_home_page.dart';
import 'package:sg_easy_hire/features/helper_interview/presentation/page/helper_interviews_page.dart';
import 'package:sg_easy_hire/features/helper_jobs/presentation/page/helper_jobs_page.dart';
import 'package:sg_easy_hire/features/helper_profile/presentation/page/helper_profile_page.dart';
import 'package:sg_easy_hire/features/main/presentation/page/main_page.dart';
import 'package:sg_easy_hire/features/verify_code/pages/verify_code_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(
        debugLabel: 'root',
      );
  static GoRouter createRouter(AuthLocalDataSource auth) {
    return GoRouter(
      refreshListenable: GoRouterRefreshStream(auth.authChanges),
      navigatorKey: _rootNavigatorKey,
      initialLocation: auth.isFirstTime
          ? RoutePaths.onboardingBiodata
          : auth.isLoggedIn
          ? RoutePaths.home
          : RoutePaths.helperSignin,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final isLoggedIn = auth.isLoggedIn;
        final goingToForgetPassword =
            state.matchedLocation == RoutePaths.forgetPassword;
        final goingToSignin = state.matchedLocation == RoutePaths.helperSignin;
        final goingToVerifyCode =
            state.matchedLocation == RoutePaths.verifyCode;
        final goingToRegister =
            state.matchedLocation == RoutePaths.helperRegister;
        final goingToOnboarding =
            state.matchedLocation == RoutePaths.onboardingBiodata;
        final goingToHome = state.matchedLocation == RoutePaths.home;

        // User NOT logged in → allow signin & register only
        if (!isLoggedIn) {
          if (goingToSignin ||
              goingToRegister ||
              goingToVerifyCode ||
              goingToForgetPassword) {
            return null;
          }
          return RoutePaths.helperSignin;
        }

        // User logged in → prevent going back to signin/register
        if (isLoggedIn) {
          if (auth.isFirstTime && goingToHome) {
            return RoutePaths.onboardingBiodata;
          }
          if (goingToSignin || goingToRegister) {
            return RoutePaths.home;
          }
          return null;
        }

        if (!auth.isFirstTime && goingToOnboarding) {
          return RoutePaths.onboardingBiodata;
        }

        return null;
      },

      routes: [
        GoRoute(
          path: RoutePaths.verifyCode,
          name: RouteNames.verifyCode,
          builder: (context, state) {
            final param = state.extra! as ConfirmSignUpParam;
            return VerifyCodePage(
              param: param,
            );
          },
        ),
        GoRoute(
          path: RoutePaths.onboardingBiodata,
          name: RouteNames.onboardingBiodata,
          builder: (context, state) {
            return const OnboardingBiodatapage();
          },
        ),
        GoRoute(
          path: RoutePaths.personalInformation,
          name: RouteNames.personalInformation,
          builder: (context, state) => const PersonalInfoPage(),
        ),
        GoRoute(
          path: RoutePaths.contactFamilyDetails,
          name: RouteNames.contactFamilyDetails,
          builder: (context, state) => const ContactFamilyPage(),
        ),
        GoRoute(
          path: RoutePaths.medicalHistor,
          name: RouteNames.medicalHistor,
          builder: (context, state) => const MedicalHistoryPage(),
        ),
        GoRoute(
          path: RoutePaths.foodHandling,
          name: RouteNames.foodHandling,
          builder: (context, state) => const FoodHandlingPage(),
        ),
        GoRoute(
          path: RoutePaths.languagesSpoken,
          name: RouteNames.languagesSpoken,
          builder: (context, state) => const LanguageSpokenPage(),
        ),
        GoRoute(
          path: RoutePaths.preferences,
          name: RouteNames.preferences,
          builder: (context, state) => const JobPreferencePage(),
        ),
        GoRoute(
          path: RoutePaths.uploadDocuments,
          name: RouteNames.uploadDocuments,
          builder: (context, state) => const UploadDocumentPage(),
        ),

        /* 
        GoRoute(
          path: RoutePaths.notifications,
          name: RouteNames.notifications,
          builder: (context, state) => const NotificationPage(),
        ),
        GoRoute(
          path: RoutePaths.notificationDetail,
          name: RouteNames.notificationDetail,
          builder: (context, state) => const NotificationDetailPage(),
        ), */
        GoRoute(
          path: RoutePaths.helperSignin,
          name: RouteNames.helperSignin,
          builder: (context, state) => const HelperSignInPage(),
        ),
        GoRoute(
          path: RoutePaths.helperRegister,
          name: RouteNames.helperRegister,
          builder: (context, state) => const HelperSignUpPage(),
        ),
        // ---------------------
        // MAIN TAB ROUTES
        // ---------------------
        StatefulShellRoute.indexedStack(
          builder:
              (
                BuildContext context,
                GoRouterState state,
                StatefulNavigationShell navigationShell,
              ) {
                return MainPage(
                  navigationShell: navigationShell,
                );
              },
          branches: [
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.home,
                  name: RouteNames.home,
                  builder: (context, state) => const HelperHomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.jobs,
                  name: RouteNames.jobs,
                  builder: (context, state) => const HelperJobsPage(),
                ),
              ],
            ),

            /* StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.helperInterviews,
                  name: RouteNames.helperInterviews,
                  builder: (context, state) => const HelperInterviewsPage(),
                ),
              ],
            ), */
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.helperInterviews, // No :status here!
                  name: RouteNames.helperInterviews,
                  builder: (context, state) {
                    // Look for ?status=... in the URL
                    final status =
                        state.uri.queryParameters['status'] ??
                        RoutePaths.helperInterviewPending;
                    return HelperInterviewsPage(status: status);
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.helperChats,
                  name: RouteNames.helperChats,
                  builder: (context, state) => const HelperChatsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.profile,
                  name: RouteNames.profile,
                  builder: (context, state) => const HelperProfilePage(),
                ),
              ],
            ),
          ],
        ),
        /* 
        
        GoRoute(
          path: RoutePaths.jobDetail,
          name: RouteNames.jobDetail,
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return JobDetailPage(jobId: id);
          },
        ),
        GoRoute(
          path: RoutePaths.helperInterviewDetail,
          name: RouteNames.helperInterviewDetail,
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return HelperInterviewDetailPage(jobId: id);
          },
        ),
        GoRoute(
          path: RoutePaths.helperChatDetail,
          name: RouteNames.helperChatDetail,
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return HelperChatDetailPage(jobId: id);
          },
        ),
        ShellRoute(
          builder: (_, sate, child) => BiodataMainPage(child: child),
          routes: [
            GoRoute(
              path: RoutePaths.onboardingBiodata,
              name: RouteNames.onboardingBiodata,
              builder: (context, state) => OnboardingBiodataPage(),
            ),
            
          
            GoRoute(
              path: RoutePaths.medicalHistor,
              name: RouteNames.medicalHistor,
              builder: (context, state) => MedicalHistoryPage(),
            ),
            GoRoute(
              path: RoutePaths.preferences,
              name: RouteNames.preferences,
              builder: (context, state) => PreferencesPage(),
            ),
            GoRoute(
              path: RoutePaths.languagesSpoken,
              name: RouteNames.languagesSpoken,
              builder: (context, state) => LanguageSpokenPage(),
            ),
            GoRoute(
              path: RoutePaths.experienceJobPreferences,
              name: RouteNames.experienceJobPreferences,
              builder: (context, state) => ExperienceJobPreferencesPage(),
            ),
            GoRoute(
              path: RoutePaths.uploadDocuments,
              name: RouteNames.uploadDocuments,
              builder: (context, state) => UploadDocumentsPage(),
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.personalityTest,
          name: RouteNames.personalityTest,
          builder: (context, state) => PersonalityTestPage(),
        ),
        GoRoute(
          path: RoutePaths.jobOffers,
          name: RouteNames.jobOffers,
          builder: (context, state) => JobOffersPage(),
        ),
        GoRoute(
          path: RoutePaths.jobOfferDetail,
          name: RouteNames.jobOfferDetail,
          builder: (context, state) => JobOfferDetailPage(),
        ),
        GoRoute(
          path: RoutePaths.progressTracking,
          name: RouteNames.progressTracking,
          builder: (context, state) => ProgressTrackingPage(),
        ),
        GoRoute(
          path: RoutePaths.helpSupport,
          name: RouteNames.helpSupport,
          builder: (context, state) => HelpSupportPage(),
        ),
        GoRoute(
          path: RoutePaths.settings,
          name: RouteNames.settings,
          builder: (context, state) => SettingsPage(),
        ),
      */
      ],
    );
  }
}
