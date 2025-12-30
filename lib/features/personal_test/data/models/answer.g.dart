// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnswerImpl _$$AnswerImplFromJson(Map<String, dynamic> json) => _$AnswerImpl(
      text: json['text'] as String,
      score: (json['score'] as num).toInt(),
      pole: json['pole'] as String?,
    );

Map<String, dynamic> _$$AnswerImplToJson(_$AnswerImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'score': instance.score,
      'pole': instance.pole,
    };
