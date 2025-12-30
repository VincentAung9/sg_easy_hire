import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/core/models/test_result.dart';
import 'package:sg_easy_hire/core/models/type_meta.dart';
import 'package:sg_easy_hire/features/personal_test/data/models/question.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

part 'personality_test_state.freezed.dart';

enum Status { pending, success, error, none, initializedQuestions }

enum Action {
  get,
  create,
  update,
  none,
  selectAnswer,
  onNextPage,
  submitAnswer,
}

@freezed
class PersonalityTestState with _$PersonalityTestState {
  factory PersonalityTestState({
    @Default([]) List<Question> allQuestions,
    @Default([]) List<Question> currentPageQuestions,
    @Default([]) List<TestAnswers> oldUserAnswers,
    @Default(Status.none) Status status,
    @Default(Action.none) Action action,
    @Default(0) int currentPage,
    @Default(1) int start,
    @Default(5) int end,
    Map<String, TypeMeta>? typeMeta,
    TestResult? testResult,
  }) = _PersonalityTestState;
}
