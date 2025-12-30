import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/helper_home/domain/other/count_down_cubit.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';
import 'package:sg_easy_hire/models/Interview.dart';

class NextInterviewCard extends StatelessWidget {
  const NextInterviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return BlocSelector<HomeBloc, HomeState, Interview?>(
      selector: (state) => state.nextInterview,
      builder: (context, nextInterview) {
        debugPrint(
          "🔥 Next Interview Changed: ${nextInterview?.confirmedDateTime?.getDateTimeInUtc().toLocal().toString()}",
        );
        if (nextInterview == null) {
          return const SizedBox();
        }
        return BlocProvider(
          key: ValueKey(
            nextInterview.confirmedDateTime!
                .getDateTimeInUtc()
                .toIso8601String(),
          ),
          create: (_) =>
              CountdownCubit()
                ..startCountdown(nextInterview.confirmedDateTime!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Next Interview",
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimaryLight,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardLight,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.05 * 255).toInt()),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Interview Date",
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nextInterview.confirmedDateTime == null
                          ? ""
                          : "${isTomorrow(nextInterview.confirmedDateTime!.getDateTimeInUtc().toLocal()) ? "Tomorrow," : ""} ${formatDateMMMd(nextInterview.confirmedDateTime!.getDateTimeInUtc().toLocal())}",
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      nextInterview.confirmedDateTime == null
                          ? ""
                          : formatTimeHMMA(
                              nextInterview.confirmedDateTime!
                                  .getDateTimeInUtc()
                                  .toLocal(),
                            ),
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),

                    const InterviewCountdownUI(),

                    Divider(color: Colors.grey[200]),
                    const SizedBox(height: 16),
                    Text(
                      "${nextInterview.employer?.fullName}",
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GridView.count(
                      padding: EdgeInsets.only(top: 15),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 3.5,
                      crossAxisSpacing: 16,
                      children: [
                        InterviewDetailItem(
                          label: "Salary",
                          value:
                              "\$${nextInterview.job?.salary}/${nextInterview.job?.payPeriod}",
                        ),
                        nextInterview.job?.familyMembers == null
                            ? const SizedBox()
                            : InterviewDetailItem(
                                label: "Family",
                                value:
                                    "${nextInterview.job?.familyMembers} members",
                              ),
                        InterviewDetailItem(
                          label: "Duties",
                          value:
                              nextInterview.job?.requiredSkills?.join(", ") ??
                              "",
                        ),
                        InterviewDetailItem(
                          label: "Off Days",
                          value: nextInterview.job?.offdays ?? "",
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              //TODO: UPDATE
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: AppColors.textSecondaryLight,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: JoinCallBtn(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
