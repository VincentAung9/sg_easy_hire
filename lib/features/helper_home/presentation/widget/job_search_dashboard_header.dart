import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 240,
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
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
                    children: [
                      CachedNetworkImage(
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
                            color: Colors.white.withAlpha((0.2 * 255).toInt()),
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
                            color: Colors.white.withAlpha((0.2 * 255).toInt()),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => updateUser(
                              user!.copyWith(fullName: "Su Mon Thaw"),
                            ),
                            child: Text(
                              "Hello, ${user?.fullName ?? ""}!",
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Ready to find your next opportunity?",
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textWhite80,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          /* context.read<NotificationCountCubit>().resetCount();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationScreen(),
                            ),
                          ); */
                        },
                        child: Stack(
                          children: [
                            const Icon(
                              Icons.notifications,
                              color: Colors.yellow,
                              size: 28,
                            ),
                            /* BlocBuilder<NotificationCountCubit, int>(
                              builder: (_, count) {
                                return count == 0
                                    ? const SizedBox()
                                    :  */
                            Positioned(
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
                                    "0",
                                    /* "$count", */
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              /*  );
                              }, */
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
              /*  Row(
                children: [
                  BlocSelector<HelperCoreBloc, HelperAuthState, User?>(
                    selector: (state) => state.user,
                    builder: (context, user) {
                      return Expanded(
                        child: QueryBuilder(
                          query: ViewProfileService.getViewHelpers(
                            user?.id ?? "",
                          ),
                          builder: (_, state) {
                            return JobSearchDashboardStateItem(
                              value: state.isLoading || state.isError
                                  ? "0"
                                  : "${state.data?.length ?? 0}",
                              label: "Profile Views",
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child:
                        BlocSelector<HelperAuthCubic, HelperAuthState, User?>(
                          selector: (state) => state.user,
                          builder: (context, user) {
                            return QueryBuilder(
                              query: JobService.getAppliedJobs(user?.id ?? ""),
                              builder: (_, state) {
                                return JobSearchDashboardStateItem(
                                  value: state.isLoading || state.isError
                                      ? "0"
                                      : "${state.data?.length ?? 0}",
                                  label: "Applied Jobs",
                                );
                              },
                            );
                          },
                        ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child:
                        BlocSelector<HelperAuthCubic, HelperAuthState, User?>(
                          selector: (state) => state.user,
                          builder: (context, user) {
                            return QueryBuilder(
                              query: InterviewService.getInterviewsCountByHeper(
                                user?.id ?? "",
                              ),
                              builder: (_, state) {
                                return JobSearchDashboardStateItem(
                                  value: state.isLoading || state.isError
                                      ? "0"
                                      : "${state.data?.length ?? 0}",
                                  label: "Interviews",
                                );
                              },
                            );
                          },
                        ),
                  ),
                ],
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
