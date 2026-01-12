import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/localization/domain/language_switch_cubit.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String selectedLanguage = 'English';

  final List<Map<String, String>> languages = [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇬🇧',
    },
    {
      'code': 'my',
      'name': 'Myanmar',
      'nativeName': 'မြန်မာ',
      'flag': '🇲🇲',
    },
  ];

  @override
  void initState() {
    selectedLanguage = context.read<LanguageSwitchCubit>().state == 'my'
        ? 'Myanmar'
        : 'English';
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final isOnBoarding = GoRouterState.of(context).extra as bool? ?? false;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 120,
        leading: isOnBoarding
            ? TextButton(
                onPressed: () => context.go(RoutePaths.onboardingBiodata),
                child: Text(
                  t.skip,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
        title: Text(t.languageSettingsTitle),
        centerTitle: isOnBoarding,
        actions: isOnBoarding
            ? null
            : const [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.notifications_outlined),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.settings_outlined),
                ),
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Selected Language Section
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          t.appLanguage,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.appLanguageDesc,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            languages.firstWhere(
                              (l) => l['name'] == selectedLanguage,
                            )['flag']!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            selectedLanguage,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.check,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Available Languages
            Text(
              t.availableLanguages,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              t.availableLanguagesDesc,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),

            ...languages.map((lang) {
              final isSelected = lang['name'] == selectedLanguage;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    context.read<LanguageSwitchCubit>().change(lang['code']!);
                    setState(() {
                      selectedLanguage = lang['name']!;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            lang['flag']!,
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                lang['nativeName']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(
                              Icons.radio_button_checked,
                              color: AppColors.primary,
                            )
                          else
                            const Icon(
                              Icons.radio_button_off,
                              color: Colors.grey,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  if (isOnBoarding) {
                    context.go(RoutePaths.onboardingBiodata);
                    return;
                  }
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(RoutePaths.profile);
                  }
                  /*  // TODO: Save language preference & refresh app
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Language changed to $selectedLanguage'),
                    ),
                  ); */
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  t.saveLanguagePreference,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: Text(
                t.languageRefreshHint,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
