import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_state.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperAccountJobSearch extends StatefulWidget {
  const HelperAccountJobSearch({super.key});

  @override
  State<HelperAccountJobSearch> createState() => _HelperAccountJobSearchState();
}

class _HelperAccountJobSearchState extends State<HelperAccountJobSearch> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocBuilder<HelperCoreBloc, HelperCoreState>(
      builder: (context, state) {
        final ui = getProfileStatus(
          state.currentUser?.verifyStatus ?? VerifyStatus.PENDING,
          t,
        );
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: ui.bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ui.color),
            /*   boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 10),
            ], */
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(ui.icon, color: ui.color),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ui.text,
                      style: TextStyle(
                        color: ui.color,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      ui.description,
                      style: TextStyle(
                        color: ui.color,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
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
