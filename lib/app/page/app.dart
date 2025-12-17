import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/app/view/app_view.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/hive_storage/hive_storage.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/provider/helper_core_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isSignInBox = Hive.box<bool>(name: signInBox);
    final authLocal = AuthLocalDataSource(isSignInBox);
    final router = AppRouter.createRouter(authLocal);
    return BlocProvider(
      create: (_) => HelperCoreBloc(provider: HelperCoreProvider()),
      child: AppView(
        router: router,
      ),
    );
  }
}
