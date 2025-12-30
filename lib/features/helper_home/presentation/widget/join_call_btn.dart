import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_home/domain/other/count_down_cubit.dart';
import 'package:sg_easy_hire/features/helper_home/domain/other/count_down_state.dart';

class JoinCallBtn extends StatelessWidget {
  const JoinCallBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountdownCubit, CountdownState>(
      builder: (context, state) {
        final isJoinEnabled = canJoinCall(state);
        return ElevatedButton(
          onPressed: isJoinEnabled ? () {} : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[500],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.call, size: 18),
              SizedBox(width: 8),
              Text(
                "Join Call",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
