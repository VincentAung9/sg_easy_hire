import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/helper_interview/presentation/widget/widget.dart';

class InterviewCardHeader extends StatelessWidget {
  const InterviewCardHeader({
    super.key,
    required this.description,
    required this.employer,
    required this.tags,
    required this.title,
  });
  final String title;
  final String employer;
  final List<String> tags;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          employer,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags
              .map(
                (tag) => tag.isNotEmpty
                    ? InterviewBuildTag(label: tag)
                    : const SizedBox(),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: textTheme.titleSmall?.copyWith(
            color: AppColors.textGrayLight,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
