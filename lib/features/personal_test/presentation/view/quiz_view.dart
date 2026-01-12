import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/core/widgets/button_loading.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_bloc.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_event.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_state.dart';
import 'package:sg_easy_hire/features/personal_test/presentation/widget/quiz_card.dart';
import 'package:sg_easy_hire/features/personal_test/presentation/widget/quiz_card_loading.dart';
import 'package:sg_easy_hire/l10n/gen/app_localizations.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;

    return BlocConsumer<PersonalityTestBloc, PersonalityTestState>(
      listener: (context, state) {
        if (state.allQuestions.isNotEmpty &&
            state.status == Status.initializedQuestions) {
          context.read<PersonalityTestBloc>().add(GetUserAnswers());
        }
        if (state.status == Status.error) {
          showError(context, t.pleaseAnswerAllQuestions);
        }
        if (state.action == Action.submitAnswer &&
            state.status == Status.success) {
          context.go(RoutePaths.personalityTestResult);
        }
      },
      builder: (context, state) {
        final totalPages = (state.allQuestions.length / 5).ceil();
        final progress = (state.end) / state.allQuestions.length;
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => context.go(RoutePaths.home),
            ),
            title: Text(
              t.questionsRangeTitle(
                state.start,
                state.currentPageQuestions.length < state.end
                    ? (state.currentPageQuestions.length + (state.start - 1))
                    : state.end,
                state.allQuestions.length,
              ),
              style: const TextStyle(fontFamily: 'Arial'),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              children: [
                LinearProgressIndicator(value: progress),
                const SizedBox(height: 16),
                Expanded(
                  child:
                      state.action == Action.get &&
                          state.status == Status.pending
                      ? ListView.separated(
                          itemCount: 5,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 18),
                          itemBuilder: (context, i) => const QuizCardLoading(),
                        )
                      : ListView.separated(
                          itemCount: state.currentPageQuestions.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 18),
                          itemBuilder: (context, i) {
                            final q = state.currentPageQuestions[i];
                            final selected = q.answers.indexWhere(
                              (a) => a.score == q.userAnswer?.answerScore,
                            );
                            final labels = [
                              q.answers.first.text,
                              q.answers.last.text,
                            ];
                            return QuizCard(
                              onChanged: (v) {
                                final a = q.answers[v];

                                context.read<PersonalityTestBloc>().add(
                                  SelectAnswer(
                                    answer: q.userAnswer == null
                                        ? TestAnswers(
                                            questionId: q.id,
                                            question: q.question,
                                            dimension: q.dimension,
                                            answerText: a.text,
                                            answerScore: a.score,
                                            answerPole: a.pole ?? "",
                                            user: currentUser,
                                          )
                                        : q.userAnswer!.copyWith(
                                            questionId: q.id,
                                            question: q.question,
                                            dimension: q.dimension,
                                            answerText: a.text,
                                            answerScore: a.score,
                                            answerPole: a.pole ?? "",
                                            user: currentUser,
                                          ),
                                  ),
                                );
                              },
                              q: q,
                              selected: selected,
                              labels: labels,
                            );
                          },
                        ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (state.currentPage > 0)
                      OutlinedButton.icon(
                        icon: const Icon(Icons.chevron_left),
                        label: Text(
                          t.previous,
                          style: const TextStyle(fontFamily: 'Arial'),
                        ),
                        onPressed: () =>
                            context.read<PersonalityTestBloc>().add(BackPage()),
                      ),
                    const Spacer(),
                    FilledButton.icon(
                      icon: Icon(
                        state.currentPage == totalPages - 1
                            ? Icons.flag
                            : Icons.chevron_right,
                      ),
                      label:
                          state.status == Status.pending &&
                              state.action == Action.submitAnswer
                          ? const ButtonLoading(color: Colors.white)
                          : Text(
                              state.currentPage == totalPages - 1
                                  ? t.finish
                                  : t.next,
                              style: const TextStyle(fontFamily: 'Arial'),
                            ),
                      onPressed: () => context.read<PersonalityTestBloc>().add(
                        state.currentPage == totalPages - 1
                            ? SubmitAnswer()
                            : NextPage(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
