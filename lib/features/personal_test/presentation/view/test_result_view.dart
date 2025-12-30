import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/models/type_meta.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/utils/personal_test_fun.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_bloc.dart';
import 'package:sg_easy_hire/features/personal_test/domain/personality_test_state.dart';
import 'package:sg_easy_hire/features/personal_test/presentation/widget/result_build_section.dart';
import 'package:sg_easy_hire/features/personal_test/presentation/widget/result_detail_section.dart';

/// ---------- RESULT ----------
class TestResultView extends StatelessWidget {
  const TestResultView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return BlocBuilder<PersonalityTestBloc, PersonalityTestState>(
      builder: (context, state) {
        final meta =
            state.typeMeta![state.testResult!.type] ??
            TypeMeta.unknown(state.testResult!.type);
        return Scaffold(
          appBar: AppBar(title: const Text('Your Result')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary for ISFP, now dynamically generated if available in sections
                if (meta.sections.any(
                  (s) => s['title'] == 'Summary' && meta.code == 'ISFP',
                ))
                  ResultBuildSection(
                    cs: cs,
                    section: meta.sections.firstWhere(
                      (s) => s['title'] == 'Summary',
                    ),
                    result: state.testResult!,
                  ),

                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: cs.outlineVariant),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: meta.color.withAlpha(
                            46,
                          ), // 0.18*255 ≈ 46
                          backgroundImage: CachedNetworkImageProvider(
                            currentUser?.avatarURL ?? "",
                          ),
                          child: null, // Remove text since image is shown
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${meta.name} ( ${meta.group} )',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${meta.code} (${formatPersonalityFull(meta.code)})',
                                style:
                                    Theme.of(
                                      context,
                                    ).textTheme.labelLarge?.copyWith(
                                      color: meta.color,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Dynamically generated sections
                ...meta.sections.map((section) {
                  if (section['title'] == 'Summary' && meta.code == 'ISFP') {
                    return const SizedBox.shrink(); // Already handled above
                  }
                  return ResultBuildSection(
                    cs: cs,
                    section: section,
                    result: state.testResult!,
                  );
                }),

                const SizedBox(height: 20),
                // Show detailed result sections from answers.json
                ResultDetailSection(
                  title: 'Personality Traits',
                  content: meta.personalityTraits,
                  cs: cs,
                ),
                ResultDetailSection(
                  title: 'Career Path',
                  content: meta.careerPath,
                  cs: cs,
                ),
                ResultDetailSection(
                  title: 'Personal Growth',
                  content: meta.personalGrowth,
                  cs: cs,
                ),
                ResultDetailSection(
                  title: 'Relationships',
                  content: meta.relationships,
                  cs: cs,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retake'),
                      onPressed: () => context.go(RoutePaths.personalityTest),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      icon: const Icon(Icons.home),
                      label: const Text('Home'),
                      onPressed: () => context.go(RoutePaths.home),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
