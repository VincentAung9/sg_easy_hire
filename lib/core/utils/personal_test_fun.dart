
import 'package:sg_easy_hire/core/models/dimension_spec.dart';

/// ---------- HELPERS ----------
String dimensionLabel(Dimension d) {
  switch (d) {
    case Dimension.energy:
      return 'Energy (E/I)';
    case Dimension.information:
      return 'Information (S/N)';
    case Dimension.decisions:
      return 'Decisions (T/F)';
    case Dimension.lifestyle:
      return 'Lifestyle (J/P)';
  }
}

String formatPersonalityFull(String code) {
  // Remove any whitespace and ensure uppercase
  code = code.replaceAll(' ', '').toUpperCase();
  // Example: INFP-A or ENFJ-T
  final traitMap = {
    'I': 'Introverted',
    'E': 'Extraverted',
    'N': 'Intuitive',
    'S': 'Observant',
    'F': 'Feeling',
    'T': 'Thinking',
    'P': 'Prospecting',
    'J': 'Judging',
    'A': 'Assertive',
    'TURBULENT': 'Turbulent',
  };
  if (code.length < 5) return code; // fallback
  final traits = [
    traitMap[code[0]] ?? code[0],
    traitMap[code[1]] ?? code[1],
    traitMap[code[2]] ?? code[2],
    traitMap[code[3]] ?? code[3],
  ];
  // Suffix: -A or -T
  String suffix = '';
  if (code.contains('-A')) {
    suffix = 'Assertive';
  } else if (code.contains('-T')) {
    suffix = 'Turbulent';
  }
  return suffix.isNotEmpty
      ? traits.join(', ') + ' - ' + suffix
      : traits.join(', ');
}
