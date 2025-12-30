import 'package:flutter/material.dart';

class ResultDetailSection extends StatelessWidget {
  const ResultDetailSection({
    super.key,
    required this.title,
    required this.content,
    required this.cs,
  });
  final String title;
  final String? content;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    if (content == null || content?.isEmpty == true)
      return const SizedBox.shrink();
    // Map section titles to icons
    IconData? icon;
    switch (title) {
      case 'Personality Traits':
        icon = Icons.person;
        break;
      case 'Career Path':
        icon = Icons.work;
        break;
      case 'Personal Growth':
        icon = Icons.trending_up;
        break;
      case 'Relationships':
        icon = Icons.favorite;
        break;
      default:
        icon = Icons.info_outline;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: cs.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: cs.primary),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                content ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
