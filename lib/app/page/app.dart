import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/app/view/app_view.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/hive_storage/hive_storage.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/features/auth/data/providers/auth_provider.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/repositories.dart';
import 'package:sg_easy_hire/features/biodata/data/repository/biodata_repository.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/work_history_cubic.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/provider/helper_core_provider.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart';
import 'package:sg_easy_hire/features/helper_home/repository/helper_home_repository.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_bloc.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_event.dart';
import 'package:sg_easy_hire/features/helper_jobs/repository/helper_job_repository.dart';
import 'package:sg_easy_hire/features/job_offer/domain/joboffer_count_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isSignInBox = Hive.box<bool>(name: signInBox);
    final authLocal = AuthLocalDataSource(isSignInBox);
    final router = AppRouter.createRouter(authLocal);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => JobofferCountCubit()),
        BlocProvider(create: (_) => WorkHistoryCubit()),
        //Helper
        BlocProvider(
          create: (_) => BiodataBloc(
            repository: BiodataRepository(),
            authRepository: AuthRepository(authProvider: AuthProvider()),
          ),
        ),
        BlocProvider(
          create: (_) =>
              HelperCoreBloc(provider: HelperCoreProvider())
                ..add(StartSubscribeToUser()),
        ),
        BlocProvider(
          create: (_) => HomeBloc(repository: HelperHomeRepository())
            ..add(StartListenNextInterview())
            ..add(StartListenProfileView())
            ..add(StartListenAppliedJobs())
            ..add(StartListenInterviews()),
        ),
        BlocProvider(
          create: (_) => HelperJobsBloc(repository: HelperJobRepository())
            ..add(GetJobTags())
            ..add(GetJobsEvent()),
        ),
      ],

      child: AppView(
        router: router,
      ),
    );
  }
}
