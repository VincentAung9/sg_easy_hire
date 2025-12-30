import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer.freezed.dart';
part 'answer.g.dart';

@freezed
abstract class Answer with _$Answer {
  factory Answer({
    required String text,
    required int score,
    required String? pole,
  }) = _Answer;
  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
}
