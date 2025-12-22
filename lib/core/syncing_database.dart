import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';

class SyncingDatabase extends StatelessWidget {
  const SyncingDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SizedBox.expand(
          child: Center(
            child: Text("Syncing data......"),
          ),
        ),
      ),
    );
  }
}
