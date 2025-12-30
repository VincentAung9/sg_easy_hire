import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/features/personal_test/data/models/answer.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
abstract class Question with _$Question {
  factory Question({
    required int id,
    required String question,
    required String dimension,
    required List<Answer> answers,
    TestAnswers? userAnswer,
  }) = _Question;
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
