import 'dart:convert';

const List<CountryCode> countryCodeList = [
  CountryCode(code: '+95', flag: '🇲🇲'), // Myanmar
  CountryCode(code: '+65', flag: '🇸🇬'), // Singapore
  CountryCode(code: '+63', flag: '🇵🇭'), // Philippines
  CountryCode(code: '+66', flag: '🇹🇭'), // Thailand
  CountryCode(code: '+60', flag: '🇲🇾'), // Malaysia
  CountryCode(code: '+856', flag: '🇱🇦'), // Laos
];

class CountryCode {
  final String code;
  final String flag;
  const CountryCode({
    required this.code,
    required this.flag,
  });

  CountryCode copyWith({
    String? code,
    String? flag,
  }) {
    return CountryCode(
      code: code ?? this.code,
      flag: flag ?? this.flag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'flag': flag,
    };
  }

  factory CountryCode.fromMap(Map<String, dynamic> map) {
    return CountryCode(
      code: map['code'] as String,
      flag: map['flag'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryCode.fromJson(String source) => CountryCode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CountryCode(code: $code, flag: $flag)';

  @override
  bool operator ==(covariant CountryCode other) {
    if (identical(this, other)) return true;
  
    return 
      other.code == code &&
      other.flag == flag;
  }

  @override
  int get hashCode => code.hashCode ^ flag.hashCode;
}
