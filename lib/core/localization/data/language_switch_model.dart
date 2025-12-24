// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LanguageSwitchModel {
  final String lang;
  final String flag;
  final String label;
  LanguageSwitchModel({
    required this.lang,
    required this.flag,
    required this.label,
  });

  LanguageSwitchModel copyWith({
    String? lang,
    String? flag,
    String? label,
  }) {
    return LanguageSwitchModel(
      lang: lang ?? this.lang,
      flag: flag ?? this.flag,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lang': lang,
      'flag': flag,
      'label': label,
    };
  }

  factory LanguageSwitchModel.fromMap(Map<String, dynamic> map) {
    return LanguageSwitchModel(
      lang: map['lang'] as String,
      flag: map['flag'] as String,
      label: map['label'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageSwitchModel.fromJson(String source) =>
      LanguageSwitchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LanguageSwitchModel(lang: $lang, flag: $flag, label: $label)';

  @override
  bool operator ==(covariant LanguageSwitchModel other) {
    if (identical(this, other)) return true;

    return other.lang == lang && other.flag == flag && other.label == label;
  }

  @override
  int get hashCode => lang.hashCode ^ flag.hashCode ^ label.hashCode;
}

final languages = [
  LanguageSwitchModel(lang: 'en', flag: '🇬🇧', label: "English"),
  LanguageSwitchModel(lang: 'my', flag: '🇲🇲', label: "Myanmar"),
];

String flags(String v) => languages.where((l) => l.lang == v).first.flag;
