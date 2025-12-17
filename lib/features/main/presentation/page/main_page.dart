import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/provider/helper_core_provider.dart';
import 'package:sg_easy_hire/features/main/presentation/view/main_view.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainPage({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HelperCoreBloc(provider: HelperCoreProvider())
            ..add(StartSubscribeToUser()),
      child: MainView(
        navigationShell: navigationShell,
      ),
    );
  }
}
