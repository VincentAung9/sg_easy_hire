import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/route_paths.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';
import 'package:sg_easy_hire/features/notification/notification_count_cubit.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:sg_easy_hire/models/User.dart';
import 'package:cached_network_image/cached_network_image.dart';

class JobSearchDashboardHeader extends StatelessWidget {
  const JobSearchDashboardHeader({super.key});
  Future<void> updateUser(User user) async {
    try {
      await Amplify.DataStore.save(user);
      debugPrint("🌈 User is updated");
    } on DataStoreException catch (e) {
      debugPrint("❗️ User Update Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final t = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      //height: 240,
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top section: Profile + Notifications
              BlocSelector<HelperCoreBloc, HelperCoreState, User?>(
                selector: (state) => state.currentUser,
                builder: (context, user) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => showNoti(
                          context,
                          "Lorem Ipsum is simply dummy ",
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        ),
                        child: CachedNetworkImage(
                          imageUrl: user?.avatarURL ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(
                                (0.2 * 255).toInt(),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(
                                (0.2 * 255).toInt(),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.dashboardGreeting(user?.fullName ?? ""),
                            style: textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            width: (size.width * 0.5).w,
                            child: Text(
                              t.dashboardSubtitle,
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.textWhite80,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          context.go(RoutePaths.notifications);
                        },
                        child: Stack(
                          children: [
                            const Icon(
                              Icons.notifications,
                              color: Colors.yellow,
                              size: 28,
                            ),
                            BlocBuilder<NotificationCountCubit, int>(
                              builder: (_, count) {
                                return count == 0
                                    ? const SizedBox()
                                    : Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.red[500],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "$count",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              // Bottom section: Stats
              Row(
                children: [
                  BlocSelector<HomeBloc, HomeState, List<ViewHelper>>(
                    selector: (state) => state.profileViews,
                    builder: (context, profileViews) {
                      return Expanded(
                        child: JobSearchDashboardStateItem(
                          value: "${profileViews.length}",
                          label: t.profileViews,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BlocSelector<HomeBloc, HomeState, List<AppliedJob>>(
                      selector: (state) => state.appliedJobs,
                      builder: (context, appliedJobs) {
                        return JobSearchDashboardStateItem(
                          value: "${appliedJobs.length}",
                          label: t.appliedJobs,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BlocSelector<HomeBloc, HomeState, List<Interview>>(
                      selector: (state) => state.interviews,
                      builder: (context, interviews) {
                        return JobSearchDashboardStateItem(
                          value: "${interviews.length}",
                          label: t.interviews,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
