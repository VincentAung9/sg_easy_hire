import 'package:sg_easy_hire/models/ModelProvider.dart';

class PersonalityTestEvent {}

class GetUserAnswers extends PersonalityTestEvent {
  GetUserAnswers();
}

class SelectAnswer extends PersonalityTestEvent {
  final TestAnswers answer;
  SelectAnswer({required this.answer});
}

class GetQuestions extends PersonalityTestEvent {}

class GetTypeMeta extends PersonalityTestEvent {}

class NextPage extends PersonalityTestEvent {}

class BackPage extends PersonalityTestEvent {}

class SubmitAnswer extends PersonalityTestEvent {}
