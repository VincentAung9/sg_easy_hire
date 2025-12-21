/// ---------- MODEL & SCORING ----------
enum Dimension { energy, information, decisions, lifestyle }

class DimensionSpec {
  const DimensionSpec(this.sideA, this.sideB, this.aLetter, this.bLetter);
  final String sideA; // e.g., Extraverted
  final String sideB; // e.g., Introverted
  final String aLetter; // E
  final String bLetter; // I

  factory DimensionSpec.fromJson(Map<String, dynamic> json) {
    return DimensionSpec(
      json['sideA'] as String? ?? '',
      json['sideB'] as String? ?? '',
      json['aLetter'] as String? ?? '',
      json['bLetter'] as String? ?? '',
    );
  }
}
