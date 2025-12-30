import 'package:flutter/material.dart';

/// ---------- TYPE META (names, groups, quick blurbs) ----------
class TypeMeta {
  const TypeMeta({
    required this.code,
    required this.name,
    required this.group,
    required this.blurb,
    required this.strengths,
    required this.watchouts,
    required this.color,
    this.careerMatches = const [],
    this.idealPartner = const [],
    this.celebrityExamples = const [],
    this.worksWellWith = const [],
    this.sections = const [],
    this.personalityTraits,
    this.careerPath,
    this.personalGrowth,
    this.relationships,
    this.codeLong,
  });

  final String code, name, group, blurb;
  final List<String> strengths;
  final List<String> watchouts;
  final Color color;

  /// New fields for extended TypeMeta
  final List<String> careerMatches;
  final List<String> idealPartner;
  final List<String> celebrityExamples;
  final List<String> worksWellWith;
  final List<Map<String, dynamic>> sections; // New field for dynamic sections
  final String? personalityTraits;
  final String? careerPath;
  final String? personalGrowth;
  final String? relationships;
  final String? codeLong;

  factory TypeMeta.unknown(String code) => const TypeMeta(
    code: 'UNKNOWN',
    name: 'Unknown Type',
    group: '—',
    blurb:
    'A concise description is not available for this code yet. Your letters are still valid.',
    strengths: ['Self-aware', 'Curious'],
    watchouts: ['None'],
    color: Colors.grey,
    sections: [],
    personalityTraits: null,
    careerPath: null,
    personalGrowth: null,
    relationships: null,
    codeLong: null,
  );

  factory TypeMeta.fromJson(Map<String, dynamic> json) {
    return TypeMeta(
      code: json['code'] as String? ?? json['personalityType'] as String? ?? '',
      name: json['name'] as String? ?? '',
      group: json['group'] as String? ?? '',
      blurb: json['blurb'] as String? ?? '',
      strengths: (json['strengths'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
      watchouts: (json['watchouts'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
      color: Color(int.parse((json['color'] as String? ?? '0xff888888').replaceFirst('#', '0xff'))),
      careerMatches: (json['careerMatches'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
      idealPartner: (json['idealPartner'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
      celebrityExamples: (json['celebrityExamples'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
      worksWellWith: (json['worksWellWith'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
      sections: (json['sections'] as List<dynamic>? ?? []).map((e) => e as Map<String, dynamic>).toList(),
      personalityTraits: json['personalityTraits'] as String?,
      careerPath: json['careerPath'] as String?,
      personalGrowth: json['personalGrowth'] as String?,
      relationships: json['relationships'] as String?,
      codeLong: json['codeLong'] as String?,
    );
  }
}

