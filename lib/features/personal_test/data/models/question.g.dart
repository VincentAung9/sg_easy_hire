// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: (json['id'] as num).toInt(),
      question: json['question'] as String,
      dimension: json['dimension'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
      userAnswer: json['userAnswer'] == null
          ? null
          : TestAnswers.fromJson(json['userAnswer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'dimension': instance.dimension,
      'answers': instance.answers,
      'userAnswer': instance.userAnswer,
    };
