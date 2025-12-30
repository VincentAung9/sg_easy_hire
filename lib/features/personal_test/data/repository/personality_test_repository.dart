import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/services.dart';
import 'package:sg_easy_hire/core/models/type_meta.dart';
import 'package:sg_easy_hire/features/personal_test/data/models/question.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class PersonalityTestRepository {
  Future<Map<String, TypeMeta>> getTypeMeta() async {
    final answersJson = await rootBundle.loadString('assets/answers.json');
    final answersMap = json.decode(answersJson) as Map<String, dynamic>;
    final loadedTypeMeta = answersMap.map(
      (key, value) =>
          MapEntry(key, TypeMeta.fromJson(value as Map<String, dynamic>)),
    );
    return loadedTypeMeta;
  }

  Future<List<Question>> getQuestions() async {
    try {
      safePrint("🌈 Loading question....");
      final questionsJson = await rootBundle.loadString(
        'assets/questions.json',
      );
      final questionsList = json.decode(questionsJson) as List<dynamic>;
      final questions = questionsList
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList();
      safePrint("🌈 Question result: ${questions.length}....");
      return questions;
    } catch (e) {
      safePrint(" 🔥 Error loading questions: $e");
      return [];
    }
  }

  static Future<bool> deleteAnswers(List<TestAnswers?> userAnswers) async {
    try {
      await Future.wait(
        userAnswers.map((todo) {
          final request = ModelMutations.delete(todo!);
          return Amplify.API.mutate(request: request).response;
        }),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TestAnswers?>?> getAnswers(String userId) async {
    try {
      final oldAnswersRequest = ModelQueries.list(
        TestAnswers.classType,
        where: TestAnswers.USER.eq(userId),
      );
      final oldAnswersResult = await Amplify.API
          .query(request: oldAnswersRequest)
          .response;
      return oldAnswersResult.data?.items;
    } catch (e) {
      return null;
    }
  }

  Future<bool> createAnswers(List<TestAnswers> answers) async {
    safePrint("🌈 Create Answers: ${answers.length}");
    try {
      await Future.wait(
        answers.map((todo) {
          final request = ModelMutations.create(todo);
          return Amplify.API.mutate(request: request).response;
        }),
      );
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      safePrint('🔥 Error create job preferences: $e');
      return false;
    }
  }

  Future<bool> updateAnswers(List<TestAnswers> answers) async {
    try {
      await Future.wait(
        answers.map((todo) {
          final request = ModelMutations.update(todo);
          return Amplify.API.mutate(request: request).response;
        }),
      );
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      safePrint('🔥 Error update job preferences: $e');
      return false;
    }
  }
}
