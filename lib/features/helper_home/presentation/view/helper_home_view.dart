import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sg_easy_hire/core/localization/domain/language_switch_cubit.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';

class HelperHomeView extends StatelessWidget {
  const HelperHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageSwitchCubit, String>(
      builder: (context, localState) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: localState == 'my' ? 220.h : 200.h,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: const FlexibleSpaceBar(
                  background: JobSearchDashboardHeader(),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate([
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileCompletion(),
                        SizedBox(height: 24),
                        QuickActions(),

                        NextInterviewCard(),
                        SizedBox(height: 24),
                        RecommendedJobs(),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
