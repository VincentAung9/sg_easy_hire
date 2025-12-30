import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';

class PersonalityTestView extends StatelessWidget {
  const PersonalityTestView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    'Personality Test',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Answer a few statements to get a quick MBTI-style type (E/I, S/N, T/F, J/P). '
                    'This is an unofficial educational tool.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: cs.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'There are 16 questions. Tap a dot to show how much you agree. '
                            'Try to answer based on your typical behavior.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Start'),
                    onPressed: () => context.go(RoutePaths.helperQuiz),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: CircleAvatar(
                backgroundColor: Colors.black26,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.go(RoutePaths.home),
                  tooltip: 'Back',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
