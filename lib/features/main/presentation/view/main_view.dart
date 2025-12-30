import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/main/presentation/widget/custom_navbar.dart';

class MainView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainView({required this.navigationShell, super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.action == HomeStateActions.applyJob &&
            state.status == HomeStateStatus.failure) {
          showError(
            context,
            "Your job application has failed.",
          );
        }
      },
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: CustomNavBar(
          navigationShell: widget.navigationShell,
        ),
      ),
    );
  }
}
