import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/models/test_result.dart';
import 'package:sg_easy_hire/features/personal_test/presentation/widget/result_build_trait_breakdown.dart';
import 'result_build_list_item.dart';

class ResultBuildSection extends StatelessWidget {
  const ResultBuildSection({
    super.key,
    required this.cs,
    required this.section,
    required this.result,
  });
  final ColorScheme cs;
  final Map<String, dynamic> section;
  final TestResult result;

  @override
  Widget build(BuildContext context) {
    final items = section['items'] as List<dynamic>;
    final iconName = section['icon'] as String;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section['title'] as String? ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: cs.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (section['text'] != null)
                  Text(
                    section['text'] as String? ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                if (section['type'] == 'traits' &&
                    section['items'] != null) ...[
                  const SizedBox(height: 10),
                  ResultBuildTraitBreakdown(
                    cs: cs,
                    traits: section['items'] as List<dynamic>,
                    result: result,
                  ),
                  const SizedBox(height: 10),
                ],
                if (section['subTitle'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    section['subTitle'] as String? ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
                if (section['items'] != null && section['type'] == 'list')
                  ResultBuildListItem(items: items, iconName: iconName),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
