import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: CustomNavBar(
        navigationShell: widget.navigationShell,
      ),
    );
  }
}
