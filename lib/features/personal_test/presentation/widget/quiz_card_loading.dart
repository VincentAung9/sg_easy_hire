import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/features/personal_test/presentation/widget/linker_row_loading.dart';

class QuizCardLoading extends StatelessWidget {
  const QuizCardLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerContainer(width: 100, height: 20),
            ShimmerContainer(width: 100, height: 20),
            SizedBox(height: 8),
            ShimmerContainer(width: 100, height: 20),
            SizedBox(height: 12),
            LikertRowLoading(),
          ],
        ),
      ),
    );
  }
}
