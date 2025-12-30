import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/models/test_result.dart';


class ResultBuildTraitBreakdown extends StatelessWidget {
  const ResultBuildTraitBreakdown({
    super.key,
    required this.cs,
    required this.traits,
    required this.result,
  });
  final ColorScheme cs;
  final List<dynamic> traits;
  final TestResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: traits.map((trait) {
        final TestResult? currentResult =
            result; // Accessing the result from ResultPage
        double value = 0.0;
        String letter = '';
        String label = '';

        if (currentResult != null) {
          switch (trait['dimension']) {
            case 'energy':
              value = currentResult.eiPct / 100;
              letter = currentResult.eiLetter;
              label =
                  '${currentResult.eiPct}% ${letter == 'I' ? 'Introverted' : 'Extraverted'}';
              break;
            case 'information':
              value = currentResult.snPct / 100;
              letter = currentResult.snLetter;
              label =
                  '${currentResult.snPct}% ${letter == 'S' ? 'Observant' : 'Intuitive'}';
              break;
            case 'decisions':
              value = currentResult.tfPct / 100;
              letter = currentResult.tfLetter;
              label =
                  '${currentResult.tfPct}% ${letter == 'F' ? 'Feeling' : 'Thinking'}';
              break;
            case 'lifestyle':
              value = currentResult.jpPct / 100;
              letter = currentResult.jpLetter;
              label =
                  '${currentResult.jpPct}% ${letter == 'P' ? 'Prospecting' : 'Judging'}';
              break;
          }
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: cs.surfaceContainerHighest,
                  color: letter == trait['keysToward']
                      ? cs.primary
                      : cs.secondary,
                  minHeight: 10,
                ),
              ),
              const SizedBox(width: 10),
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        );
      }).toList(),
    );
  }
}
