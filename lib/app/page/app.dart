import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/app/view/app_view.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/hive_storage/hive_storage.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/features/auth/data/providers/auth_provider.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/repositories.dart';
import 'package:sg_easy_hire/features/auth/domain/auth_change/auth_change_bloc.dart';
import 'package:sg_easy_hire/features/auth/domain/auth_change/auth_change_event.dart';
import 'package:sg_easy_hire/features/biodata/data/repository/biodata_repository.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/work_history_cubic.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/provider/helper_core_provider.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/repository/helper_home_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isSignInBox = Hive.box<bool>(name: signInBox);
    final authLocal = AuthLocalDataSource(isSignInBox);
    final router = AppRouter.createRouter(authLocal);
    final authRepository = AuthRepository(authProvider: AuthProvider());
    return RepositoryProvider.value(
      value: authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthChangeBloc(
              authRepository: authRepository,
            )..add(StartSubscribeAuthChangeEvent()),
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
              authRepository: authRepository,
            ),
          ),
          BlocProvider(create: (_) => WorkHistoryCubit()),
        ],

        child: AppView(
          router: router,
        ),
      ),
    );
  }
}
