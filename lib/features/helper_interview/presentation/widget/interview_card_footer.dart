import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/route_paths.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/join_call_btn.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/Interview.dart';
import 'package:sg_easy_hire/models/InterviewStatus.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class InterviewAcceptedCardFooter extends StatelessWidget {
  final Interview interview;
  const InterviewAcceptedCardFooter({
    super.key,
    required this.time,
    required this.interview,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final interviewAction = getInterviewAction(interview.status, t);
    final isHideTime =
        interview.status == InterviewStatus.COMPLETED ||
        interview.status == InterviewStatus.CANCELLED ||
        interview.status == InterviewStatus.NO_SHOW;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: Colors.grey[200]),
        const SizedBox(height: 10),
        isHideTime
            ? const SizedBox()
            : Text(
                t.time,
                style: textTheme.titleSmall,
              ),
        isHideTime
            ? const SizedBox()
            : Text(
                time,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () => context.push(
            RoutePaths.helperInterviewDetail,
            extra: interview,
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            foregroundColor: AppColors.textGrayLight,
            side: BorderSide(color: Colors.grey[200]!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            t.viewDetails,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        interview.status == InterviewStatus.COMPLETED ||
                interview.status == InterviewStatus.CANCELLED ||
                interview.status == InterviewStatus.NO_SHOW
            ? ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44),
                  backgroundColor: interviewAction["bgColor"] as Color,
                  foregroundColor: interviewAction["fgColor"] as Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  interviewAction["text"] as String,
                  style: textTheme.titleMedium,
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (interview.status == InterviewStatus.ACCEPTED) {
                          //TODO:cancel
                          context.read<HomeBloc>().add(
                            UpdateInterviewEvent(
                              interview: interview.copyWith(
                                status: InterviewStatus.CANCELLED,
                                updatedBy: UserRole.HELPER,
                              ),
                            ),
                          );
                          return;
                        }
                        if (interview.status == InterviewStatus.PENDING) {
                          //show interview date time
                          final chooseDateTime =
                              await showInterviewTimeSelectionDialog(
                                context,
                                interview.interviewDateOptions!,
                              );
                          if (chooseDateTime != null) {
                            //TODO:accept
                            context.read<HomeBloc>().add(
                              UpdateInterviewEvent(
                                interview: interview.copyWith(
                                  confirmedDateTime: chooseDateTime,
                                  status: InterviewStatus.ACCEPTED,
                                  updatedBy: UserRole.HELPER,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 44),
                        backgroundColor: interviewAction["bgColor"] as Color,
                        foregroundColor: interviewAction["fgColor"] as Color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        interviewAction["text"] as String,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: interviewAction["fgColor"] as Color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  interview.status == InterviewStatus.PENDING
                      ? Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              //TODO:cancel
                              context.read<HomeBloc>().add(
                                UpdateInterviewEvent(
                                  interview: interview.copyWith(
                                    status: InterviewStatus.CANCELLED,
                                    updatedBy: UserRole.HELPER,
                                  ),
                                ),
                              );
                              return;
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(
                                double.infinity,
                                44,
                              ),
                              backgroundColor: Colors.red[100],
                              foregroundColor: Colors.red[500],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              t.employerDashboard_cancel,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.red[500],
                              ),
                            ),
                          ),
                        )
                      : const Expanded(
                          child: const JoinCallBtn(),
                        ),
                ],
              ),
      ],
    );
  }
}
