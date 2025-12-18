import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/helper_interview/presentation/widget/widget.dart';
import 'package:sg_easy_hire/models/Interview.dart';

class HelperInterviewsView extends StatelessWidget {
  final String status;
  const HelperInterviewsView({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final activeIndex = getInterviewStatusIndex(status);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: AppColors.primary,
            pinned: true,
            expandedHeight: 70.0,
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "My Interviews",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,

                  fontSize: 15,
                ),
              ),
              titlePadding: EdgeInsets.only(left: 16, bottom: 16),
              centerTitle: false,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: HelperInterviewTabBar(
                selectedIndex: activeIndex,
              ),
            ),
          ),
          SliverFillRemaining(
            child: IndexedStack(
              index: activeIndex,
              children: [
                BlocSelector<HomeBloc, HomeState, List<Interview>>(
                  selector: (state) => state.pending,
                  builder: (_, interviews) =>
                      InterviewList(interviews: interviews),
                ),
                BlocSelector<HomeBloc, HomeState, List<Interview>>(
                  selector: (state) => state.accepted,
                  builder: (_, interviews) =>
                      InterviewList(interviews: interviews),
                ),
                BlocSelector<HomeBloc, HomeState, List<Interview>>(
                  selector: (state) => state.completed,
                  builder: (_, interviews) =>
                      InterviewList(interviews: interviews),
                ),
                BlocSelector<HomeBloc, HomeState, List<Interview>>(
                  selector: (state) => state.cancelled,
                  builder: (_, interviews) =>
                      InterviewList(interviews: interviews),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
