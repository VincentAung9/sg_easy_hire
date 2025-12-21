export 'box_keys.dart';
export 'country_codes.dart';

// These will now be loaded from JSON or derived. Keep for compilation.
import '../models/dimension_spec.dart';

const countries = [
  "Myanmar",
  "Singapore",
  "Middle East",
  "Malaysia",
  "Taiwan",
  "Hong Kong ",
  "Others",
];
const kEnergy = DimensionSpec('Extraverted', 'Introverted', 'E', 'I');
const kInfo = DimensionSpec('Sensing (Observant)', 'Intuitive', 'S', 'N');
const kDecisions = DimensionSpec('Thinking', 'Feeling', 'T', 'F');
const kLifestyle = DimensionSpec('Judging', 'Prospecting', 'J', 'P');
