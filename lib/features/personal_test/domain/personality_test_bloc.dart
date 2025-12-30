import 'dart:async';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/models/test_result.dart';
import 'package:sg_easy_hire/features/personal_test/data/models/question.dart';
import 'package:sg_easy_hire/features/personal_test/data/repository/personality_test_repository.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_event.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_state.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class PersonalityTestBloc
    extends Bloc<PersonalityTestEvent, PersonalityTestState> {
  final PersonalityTestRepository repository;
  final int perPageItems = 5;
  PersonalityTestBloc({
    required this.repository,
  }) : super(PersonalityTestState()) {
    on<GetUserAnswers>(_getUserAnswers);
    on<GetQuestions>(_getQuestions);
    on<GetTypeMeta>(_getTypeMeta);
    on<SelectAnswer>(_onSelectAnswer);
    on<NextPage>(_onNextPage);
    on<BackPage>(_onBackPage);
    on<SubmitAnswer>(_onSubmitAnswer);
  }

  FutureOr<void> _getQuestions(
    GetQuestions event,
    Emitter<PersonalityTestState> emit,
  ) async {
    if (state.allQuestions.isNotEmpty) {
      return;
    }
    emit(state.copyWith(action: Action.get, status: Status.pending));
    final result = await repository.getQuestions();
    debugPrint("Questions Length: ${result.length}");
    final start = state.currentPage * perPageItems;
    final end = start + perPageItems;
    emit(
      state.copyWith(
        action: Action.get,
        status: Status.initializedQuestions,
        allQuestions: result,
        start: start + 1,
        end: end,
        currentPageQuestions: result.sublist(start, end),
      ),
    );
  }

  FutureOr<void> _getUserAnswers(
    GetUserAnswers event,
    Emitter<PersonalityTestState> emit,
  ) async {
    emit(state.copyWith(action: Action.get, status: Status.pending));
    final box = Hive.box<User>(name: userBox);
    final userID = box.get(userBoxKey)?.id ?? "";
    final result = await repository.getAnswers(userID);
    List<Question> newQuestions = List.from(state.allQuestions);
    var typeList = <TestAnswers>[];
    if (result?.isNotEmpty ?? false) {
      //we get answers & set
      typeList = result!.whereType<TestAnswers>().toList();
      for (var i = 0; i < newQuestions.length; i++) {
        final nq = newQuestions[i];
        final answers = typeList.where((tl) => tl.questionId == nq.id);
        if (answers.isNotEmpty) {
          final an = answers.first;
          newQuestions[i] = nq.copyWith(userAnswer: an);
        }
      }
    }
    final start = state.currentPage * perPageItems;
    final end = start + perPageItems;
    emit(
      state.copyWith(
        action: Action.get,
        status: Status.success,
        allQuestions: newQuestions,
        start: start + 1,
        end: end,
        currentPageQuestions: newQuestions.sublist(start, end),
        oldUserAnswers: typeList,
      ),
    );
  }

  FutureOr<void> _onNextPage(
    NextPage event,
    Emitter<PersonalityTestState> emit,
  ) {
    final isEmpty = state.currentPageQuestions
        .where((cq) => cq.userAnswer == null)
        .isNotEmpty;
    if (isEmpty) {
      emit(
        state.copyWith(
          action: Action.onNextPage,
          status: Status.error,
        ),
      );
      return null;
    }
    final pageIndex = state.currentPage + 1;
    List<Question> oldQuestions = List.from(state.allQuestions);
    final start = pageIndex * perPageItems;
    final end = start + perPageItems;

    //need to check all answers in current page
    for (var cpq in state.currentPageQuestions) {
      var qIndex = oldQuestions.indexWhere((oq) => oq.id == cpq.id);
      oldQuestions[qIndex] = cpq;
    }

    //if not, emit error
    //else not, success
    List<Question> cpQuestions = [];
    try {
      cpQuestions = oldQuestions.sublist(start, end);
    } catch (e) {
      cpQuestions = oldQuestions.sublist(start);
    }
    emit(
      state.copyWith(
        allQuestions: oldQuestions,
        currentPage: pageIndex,
        currentPageQuestions: cpQuestions,
        start: start + 1,
        end: end,
        status: Status.none,
      ),
    );
  }

  FutureOr<void> _onBackPage(
    BackPage event,
    Emitter<PersonalityTestState> emit,
  ) {
    final pageIndex = state.currentPage - 1;
    List<Question> newQuestions = List.from(state.allQuestions);
    final start = pageIndex * perPageItems;
    final end = start + perPageItems;
    final nQuestions = newQuestions.sublist(start, end);

    emit(
      state.copyWith(
        currentPage: pageIndex,
        allQuestions: newQuestions,
        currentPageQuestions: nQuestions,
        start: start + 1,
        end: end,
        status: Status.none,
      ),
    );
  }

  FutureOr<void> _onSubmitAnswer(
    SubmitAnswer event,
    Emitter<PersonalityTestState> emit,
  ) async {
    try {
      final isEmpty = state.currentPageQuestions
          .where((cq) => cq.userAnswer == null)
          .isNotEmpty;
      if (isEmpty) {
        emit(
          state.copyWith(
            action: Action.onNextPage,
            status: Status.error,
          ),
        );
        return null;
      }
      emit(
        state.copyWith(
          action: Action.submitAnswer,
          status: Status.pending,
        ),
      );
      List<Question> oldQuestions = List.from(state.allQuestions);

      for (var cpq in state.currentPageQuestions) {
        var qIndex = oldQuestions.indexWhere((oq) => oq.id == cpq.id);
        oldQuestions[qIndex] = cpq;
      }
      final testResult = computeResult(
        oldQuestions,
      );
      //check all questions is same
      List<TestAnswers> updateAnswers = [];
      List<TestAnswers> createAnswers = [];
      if (state.oldUserAnswers.isNotEmpty) {
        for (final q in oldQuestions) {
          final oldAnswer = state.oldUserAnswers.where(
            (o) =>
                o.questionId == q.id &&
                o.answerPole == q.userAnswer?.answerPole &&
                o.answerScore == q.userAnswer?.answerScore &&
                o.answerText == q.userAnswer?.answerText,
          );
          if (oldAnswer.isNotEmpty) {
            updateAnswers.add(q.userAnswer!);
          } else {
            createAnswers.add(q.userAnswer!);
          }
          if (oldAnswer.isNotEmpty) {
            updateAnswers.add(q.userAnswer!);
          } else {
            createAnswers.add(q.userAnswer!);
          }
        }
        if (createAnswers.isNotEmpty) {
          final isSuccess = await repository.createAnswers(createAnswers);
          if (isSuccess) {
            emit(
              state.copyWith(
                action: Action.submitAnswer,
                status: Status.success,
                testResult: testResult,
                allQuestions: oldQuestions,
              ),
            );
          } else {
            emit(
              state.copyWith(
                action: Action.submitAnswer,
                status: Status.error,
              ),
            );
          }
        }
        if (updateAnswers.isNotEmpty) {
          final isSuccess = await repository.updateAnswers(updateAnswers);
          if (isSuccess) {
            emit(
              state.copyWith(
                action: Action.submitAnswer,
                status: Status.success,
                allQuestions: oldQuestions,
                testResult: testResult,
              ),
            );
          } else {
            emit(
              state.copyWith(
                action: Action.submitAnswer,
                status: Status.error,
              ),
            );
          }
        }
      } else {
        //create
        final isSuccess = await repository.createAnswers(
          oldQuestions
              .map((e) => e.userAnswer)
              .whereType<TestAnswers>()
              .toList(),
        );
        if (isSuccess) {
          emit(
            state.copyWith(
              action: Action.submitAnswer,
              status: Status.success,
              allQuestions: oldQuestions,
              testResult: testResult,
            ),
          );
        } else {
          emit(
            state.copyWith(
              action: Action.submitAnswer,
              status: Status.error,
            ),
          );
        }
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      emit(state.copyWith(action: Action.submitAnswer, status: Status.error));
    }
  }

  FutureOr<void> _onSelectAnswer(
    SelectAnswer event,
    Emitter<PersonalityTestState> emit,
  ) {
    final questionIndex = state.currentPageQuestions.indexWhere(
      (q) => q.id == event.answer.questionId,
    );
    if (questionIndex == -1) {
      emit(state.copyWith());
      return null;
    }
    List<Question> newQuestions = List.from(state.currentPageQuestions);
    newQuestions[questionIndex] = newQuestions[questionIndex].copyWith(
      userAnswer: event.answer,
    );
    emit(
      state.copyWith(currentPageQuestions: newQuestions, status: Status.none),
    );
  }

  FutureOr<void> _getTypeMeta(
    GetTypeMeta event,
    Emitter<PersonalityTestState> emit,
  ) async {
    if (state.allQuestions.isNotEmpty) {
      return;
    }
    emit(state.copyWith(action: Action.get, status: Status.pending));
    final result = await repository.getTypeMeta();
    debugPrint("🌈 TypeMeta Length: ${result.length}");
    emit(
      state.copyWith(
        action: Action.get,
        status: Status.initializedQuestions,
        typeMeta: result,
      ),
    );
  }
}
