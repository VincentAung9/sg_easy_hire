
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/route_paths.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/models/Interview.dart';
import 'package:sg_easy_hire/models/InterviewStatus.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final interviewAction = getInterviewAction(
      interview.status,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: Colors.grey[200]),
        const SizedBox(height: 10),
        Text(
          "Time",
          style: textTheme.titleSmall,
        ),
        Text(
          time,
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimaryLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () => context.go(RoutePaths.jobDetail),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            foregroundColor: AppColors.textGrayLight,
            side: BorderSide(color: Colors.grey[200]!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "View Details",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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

                          return;
                        }
                        if (interview.status == InterviewStatus.PENDING) {
                          //show interview date time
                          final chooseDateTime = await showInterviewDateDialog(
                            context,
                            interview.interviewDateOptions!,
                          );
                          if (chooseDateTime != null) {
                            //TODO:accept
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
                              "Cancel",
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              //TODO:JOIN CALL
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 44),
                              backgroundColor: Colors.grey[200],
                              foregroundColor: AppColors.textGrayLight,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Join Call",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
      ],
    );
  }
}
