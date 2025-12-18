import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/helper_home/domain/other/count_down_cubit.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';
import 'package:sg_easy_hire/features/helper_interview/presentation/widget/widget.dart';
import 'package:sg_easy_hire/models/Interview.dart';

class InterviewCard extends StatelessWidget {
  const InterviewCard({
    super.key,
    this.isTomorrow = false,
    required this.time,
    required this.employer,
    required this.tags,
    required this.description,
    required this.title,
    required this.interview,
  });
  final String title;
  final String employer;
  final List<String> tags;
  final String description;
  final String time;
  final bool isTomorrow;
  final Interview interview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InterviewCardHeader(
            title: title,
            employer: employer,
            tags: tags,
            description: description,
          ),
          if (isTomorrow && interview.confirmedDateTime != null) ...[
            const SizedBox(height: 16),
            BlocProvider(
              create: (_) =>
                  CountdownCubit()
                    ..startCountdown(interview.confirmedDateTime!),
              child: const InterviewCountdownUI(),
            ),
          ],
          const SizedBox(height: 16),
          InterviewAcceptedCardFooter(
            time: time,
            interview: interview,
          ),
        ],
      ),
    );
  }
}
