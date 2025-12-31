import 'package:flutter/material.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';

class HelperHomeView extends StatelessWidget {
  const HelperHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
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
  }
}
