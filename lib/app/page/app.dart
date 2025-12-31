import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/app/view/app_view.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/hive_storage/hive_storage.dart';
import 'package:sg_easy_hire/core/localization/domain/language_switch_cubit.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/features/auth/data/providers/auth_provider.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/repositories.dart';
import 'package:sg_easy_hire/features/auth/domain/auth_change/auth_change_bloc.dart';
import 'package:sg_easy_hire/features/auth/domain/auth_change/auth_change_event.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_out/sign_out_bloc.dart';
import 'package:sg_easy_hire/features/biodata/data/repository/biodata_repository.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/work_history_cubic.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/provider/helper_core_provider.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/repository/helper_home_repository.dart';
import 'package:sg_easy_hire/features/personal_test/data/repository/personality_test_repository.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("🌈 App Page Build..........");

    final isSignInBox = Hive.box<bool>(name: signInBox);
    final authLocal = AuthLocalDataSource(isSignInBox);
    final router = AppRouter.createRouter(authLocal);

    // Create the repository here
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(authProvider: AuthProvider()),
        ),
        RepositoryProvider<PersonalityTestRepository>(
          create: (context) => PersonalityTestRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => LanguageSwitchCubit(),
        child: AppPage(router: router),
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  final GoRouter router;
  const AppPage({
    required this.router,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthChangeBloc(
            authRepository: context.read<AuthRepository>(),
          )..add(StartSubscribeAuthChangeEvent()),
        ),
        BlocProvider(
          create: (_) => SignOutBloc(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => HomeBloc(repository: HelperHomeRepository()),
        ),
        BlocProvider(
          create: (context) => HelperCoreBloc(provider: HelperCoreProvider())
            ..add(StartSubscribeToUser())
            ..add(StartSubscribeToHiveUser()),
        ),
        BlocProvider(
          create: (_) => BiodataBloc(
            repository: BiodataRepository(),
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider(create: (_) => WorkHistoryCubit()),
        BlocProvider(
          create: (_) => PersonalityTestBloc(
            repository: context.read<PersonalityTestRepository>(),
          ),
        ),
      ],

      child: AppView(
        router: router,
      ),
    );
  }
}
