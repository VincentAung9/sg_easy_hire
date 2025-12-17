import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/features/main/presentation/widget/custom_navbar.dart';

class MainView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainView({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomNavBar(
        navigationShell: navigationShell,
      ),
    );
  }
}
