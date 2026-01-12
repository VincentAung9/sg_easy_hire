import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_interview/presentation/widget/widget.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/Interview.dart';

class InterviewList extends StatelessWidget {
  final List<Interview> interviews;
  const InterviewList({required this.interviews, super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    // Note: The 'Roboto' font family should be set in your app's main theme.
    return interviews.isEmpty
        ? SizedBox(
            height: size.height * 0.5,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t.findHelpers_noResults,
                  style: textTheme.titleMedium,
                ),
              ],
            ),
          )
        : Scaffold(
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: interviews.length,
              itemBuilder: (_, index) {
                final interview = interviews[index];
                return InterviewCard(
                  interview: interview,
                  title: interview.job?.title ?? "",
                  employer:
                      "${interview.employer?.fullName} • \$${interview.job?.salary}/${interview.job?.payPeriod}",
                  tags: [
                    interview.job?.familyMembers != null
                        ? t.jobInFamily(interview.job?.familyMembers ?? 0)
                        : "",
                    interview.job?.childCount != null
                        ? t.jobChildren(interview.job?.childCount ?? 0)
                        : "",
                    interview.job?.adultCount != null
                        ? t.adultCountLabel(interview.job?.adultCount ?? 0)
                        : "",
                    interview.job?.elderlyCount != null
                        ? t.elderlyCountLabel(interview.job?.elderlyCount ?? 0)
                        : "",
                    t.jobOffDays(interview.job?.offdays ?? 0),
                  ],
                  description: interview.job?.note ?? "",
                  time: interview.confirmedDateTime == null
                      ? interview.interviewDateOptions
                                ?.map(
                                  formatInterviewDateTime,
                                )
                                .join("\n") ??
                            ""
                      : formatInterviewDateTime(
                          interview.confirmedDateTime!,
                        ),
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  isTomorrow: interview.confirmedDateTime == null
                      ? false
                      : true,
                );
              },
            ),
          );
  }
}
