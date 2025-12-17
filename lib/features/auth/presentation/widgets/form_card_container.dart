import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class FormCardContainer extends StatelessWidget {
  const FormCardContainer({
    required this.child,
    required this.title,
    required this.subTitle,
    super.key,
  });
  final Widget child;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardInputDecoration = theme.extension<ContainerTheme>()?.card;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: cardInputDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            subTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
