import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/biodata/domain/work_history_cubic.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/work_experience_form.dart';
import 'package:sg_easy_hire/models/WorkHistory.dart';

class WorkExperienceComponent extends StatelessWidget {
  const WorkExperienceComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12), // rounded-lg
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: BlocBuilder<WorkHistoryCubit, List<WorkHistory>>(
        builder: (context, workHistories) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Work History",
                        style: TextStyle(
                          color: AppColors.textPrimaryLight,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ...List.generate(workHistories.length, (index) {
                final workHistory = workHistories[index];
                return Container(
                  key: Key(workHistory.id),
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white, // required for shadow to be visible
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2), // x, y
                      ),
                    ],
                  ),
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            workHistory.location ?? "",
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<WorkHistoryCubit>()
                                  .removeWorkHistory(workHistory);
                            },
                            child: Text(
                              "Remove",
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        workHistory.description ?? "",
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        workHistory.duration ?? "",
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        workHistory.duties ?? "",
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const WorkExperienceForm(),
            ],
          );
        },
      ),
    );
  }
}
