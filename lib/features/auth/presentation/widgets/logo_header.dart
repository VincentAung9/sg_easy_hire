import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  const LogoHeader({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.groups, color: Colors.grey, size: 40),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          subTitle,
          style: textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
