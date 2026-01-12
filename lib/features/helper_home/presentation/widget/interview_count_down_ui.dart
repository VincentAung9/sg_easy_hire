import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/other/count_down_cubit.dart';
import 'package:sg_easy_hire/features/helper_home/domain/other/count_down_state.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/widget/widget.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';

class InterviewCountdownUI extends StatelessWidget {
  const InterviewCountdownUI({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocBuilder<CountdownCubit, CountdownState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              CountDownItem(value: "${state.days}", label: t.countdownDays),
              CountDownSeparator(),
              CountDownItem(value: "${state.hours}", label: t.countdownHours),
              CountDownSeparator(),
              CountDownItem(
                value: "${state.minutes}",
                label: t.countdownMinutes,
              ),
            ],
          ),
        );
      },
    );
  }
}
