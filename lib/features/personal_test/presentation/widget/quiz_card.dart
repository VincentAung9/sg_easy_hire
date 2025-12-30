import 'package:flutter/material.dart';
import 'package:sg_easy_hire/features/personal_test/data/models/question.dart';
import 'package:sg_easy_hire/features/personal_test/presentation/widget/linker_row.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
    required this.q,
    required this.selected,
    required this.labels,
    required this.onChanged,
  });
  final Question q;
  final int? selected;
  final List<String> labels;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              q.dimension,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontFamily: 'Arial'),
            ),
            const SizedBox(height: 8),
            Text(
              q.question,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: 'Arial',
              ),
            ),
            const SizedBox(height: 12),
            LikertRow(value: selected, onChanged: onChanged, labels: labels),
          ],
        ),
      ),
    );
  }
}
