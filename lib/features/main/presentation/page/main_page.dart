import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_bloc.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_event.dart';
import 'package:sg_easy_hire/features/helper_jobs/repository/helper_job_repository.dart';
import 'package:sg_easy_hire/features/job_offer/domain/joboffer_count_cubit.dart';
import 'package:sg_easy_hire/features/main/presentation/view/main_view.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainPage({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => JobofferCountCubit()),

        BlocProvider(
          create: (_) => HelperJobsBloc(repository: HelperJobRepository())
            ..add(GetJobTags())
            ..add(GetJobsEvent()),
        ),
      ],
      child: MainView(
        navigationShell: navigationShell,
      ),
    );
  }
}
