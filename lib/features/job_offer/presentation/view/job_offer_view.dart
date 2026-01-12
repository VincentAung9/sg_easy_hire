import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/features/job_offer/data/repository/job_repository.dart';
import 'package:sg_easy_hire/features/job_offer/presentation/widget/job_offer_simple_card.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/User.dart';

class JobOfferView extends StatelessWidget {
  const JobOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            _buildInterviewList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final t = AppLocalizations.of(context);
    return SliverAppBar(
      expandedHeight: 114.0,
      backgroundColor: AppColors.primary,
      pinned: true,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.7 * 255).toInt()),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(RoutePaths.home);
              }
            },
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF805AD5), Color(0xFF6B46C1), Color(0xFF5B21B6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.yourJobOffers,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  t.viewJobsOfferedToYou,
                  style: const TextStyle(
                    color: Color(0xFFD6BCFA),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      toolbarHeight: 100,
    );
  }

  Widget _buildInterviewList(BuildContext context) {
    final t = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return BlocSelector<HelperCoreBloc, HelperCoreState, User?>(
      selector: (state) => state.currentUser,
      builder: (context, helper) {
        return QueryBuilder(
          query: JobService.getJobOffers(helper?.id ?? ""),
          builder: (_, state) {
            return SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  state.isLoading
                      ? [
                          SizedBox(
                            height: size.height * 0.5,
                            width: size.width,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CupertinoActivityIndicator(),
                                ),
                              ],
                            ),
                          ),
                        ]
                      : state.data?.isEmpty == true
                      ? [
                          SizedBox(
                            height: size.height * 0.5,
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                // Chat icon with gradient circle and sparkle
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            AppColors.primary.withOpacity(0.15),
                                            AppColors.background.withOpacity(
                                              0.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      height: 110,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.work_outline,
                                        size: 60,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Icon(
                                        Icons.auto_awesome,
                                        size: 32,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Title
                                Text(
                                  t.noOfferJobsYet,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ]
                      : state.data
                                ?.map(
                                  (offeredJob) => JobOfferSimpleCard(
                                    offeredJob: offeredJob,
                                  ),
                                )
                                .toList() ??
                            [] /*[
                       _buildDateHeader("Oct 20, 2025"),
                      _buildFullInterviewCard(),
                      const SizedBox(height: 24),
                      _buildDateHeader("Oct 22, 2025"), 
                      _buildSimpleInterviewCard(),
                    ]*/,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
