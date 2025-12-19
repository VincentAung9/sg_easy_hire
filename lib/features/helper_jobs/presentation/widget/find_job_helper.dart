import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_bloc.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_event.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_state.dart';

class FindJobHeader extends StatefulWidget {
  const FindJobHeader({super.key});

  @override
  State<FindJobHeader> createState() => _FindJobHeaderState();
}

class _FindJobHeaderState extends State<FindJobHeader> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void dispose() {
    // CRUCIAL: Cancel the timer when the widget is removed
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 180, // Header height
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find Jobs",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: BlocSelector<HelperJobsBloc, HelperJobsState, String>(
                selector: (state) => state.query,
                builder: (context, query) {
                  return TextFormField(
                    initialValue: query,
                    onChanged: (value) {
                      //debounce
                      _debouncer.call(() {
                        context.read<HelperJobsBloc>().add(
                          SearchJobsEvent(query: value),
                        );
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search by title location, family size...",
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[300]),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    cursorColor: Colors.white, // Set cursor color to white
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
