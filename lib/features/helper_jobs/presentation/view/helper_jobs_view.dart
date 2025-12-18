import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_bloc.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_event.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_state.dart';
import 'package:sg_easy_hire/features/helper_jobs/presentation/widget/widget.dart';

class HelperJobsView extends StatefulWidget {
  const HelperJobsView({super.key});

  @override
  State<HelperJobsView> createState() => _HelperJobsViewState();
}

class _HelperJobsViewState extends State<HelperJobsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) context.read<HelperJobsBloc>().add(GetJobsEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Trigger at 90% scroll
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints;
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverAppBar(
                expandedHeight: 165,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(background: FindJobHeader()),
              ),

              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  const FindJobFilterChip(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<HelperJobsBloc, HelperJobsState>(
                      builder: (context, state) {
                        return state.status == HelperJobsStatus.initialPending
                            ? const Column(
                                spacing: 16,
                                children: [JobCardShimmer()],
                              )
                            : state.jobs.isEmpty
                            ? SizedBox(
                                height: size.maxHeight * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 16,
                                  children: [
                                    Text(
                                      "No matching results found.",
                                      style: textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                spacing: 16,
                                children: [
                                  ...state.jobs.map((job) => JobCard(job: job)),
                                  state.status == HelperJobsStatus.subPending
                                      ? const ButtonLoading()
                                      : const SizedBox(),
                                ],
                              );
                      },
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
