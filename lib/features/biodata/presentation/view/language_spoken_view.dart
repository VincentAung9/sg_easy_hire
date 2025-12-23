import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_checkbox_item.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/form_footer.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/OtherPersonalInfo.dart';

class LanguageSpokenView extends StatefulWidget {
  const LanguageSpokenView({super.key});

  @override
  State<LanguageSpokenView> createState() => _LanguageSpokenViewState();
}

class _LanguageSpokenViewState extends State<LanguageSpokenView> {
  OtherPersonalInfo? oldData;
  final Map<String, bool> _languages = {
    'english': false,
    'mandarin': false,
    'malay': false,
    'tamil': false,
    'tagalog': false,
    'indonesian': false,
    'burmese': false,
    'cantonese': false,
    'hindi': false,
  };
  bool isInitialized = false;
  @override
  void initState() {
    context.read<BiodataBloc>().add(GetOtherPersonalInfo());
    super.initState();
  }

  void setInitialData(OtherPersonalInfo otherInfo) {
    isInitialized = true;
    oldData = otherInfo;
    for (String v in otherInfo.languagesSpoken ?? []) {
      if (_languages.containsKey(v)) {
        //mean it is checked
        _languages[v] = true;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryLight),
          onPressed: () => context.go(RoutePaths.home),
        ),
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.5, // 10% for Step 1 of 10
                  backgroundColor: Colors.grey[300],
                  color: AppColors.primary,
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Step 5 of 7",
              style: TextStyle(
                color: AppColors.textSecondaryLight,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        toolbarHeight: 60,
      ),
      body: BlocListener<BiodataBloc, BiodataState>(
        listener: (_, state) {
          if (state.action == BiodataStateAction.otherPersonalInfo &&
              state.status == BiodataStateStatus.success) {
            showSuccess(context, "Your information has been saved");
            context.go(RoutePaths.preferences);
          }
          if (state.action == BiodataStateAction.otherPersonalInfo &&
              state.status == BiodataStateStatus.saveDraftSuccess) {
            showSuccess(context, "Draft saved successfully");
          }
          if (state.action == BiodataStateAction.otherPersonalInfo &&
              state.status == BiodataStateStatus.failure) {
            showError(
              context,
              "Failed to save your information. Please try again.",
            );
          }
          if (!isInitialized && !(state.otherInfo == null)) {
            setInitialData(state.otherInfo!);
          }
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24.0), // p-6
            children: [
              Container(
                padding: const EdgeInsets.all(24.0), // p-6
                decoration: BoxDecoration(
                  color: AppColors.cardLight,
                  borderRadius: BorderRadius.circular(16), // rounded-2xl
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(13),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Languages Spoken",
                      style: TextStyle(
                        color: AppColors.textPrimaryLight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Select all languages you can speak",
                      style: TextStyle(
                        color: AppColors.textSecondaryLight,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        CustomCheckboxItem(
                          label: "English",
                          value: _languages['english'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['english'] = v!;
                          }),
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxItem(
                          label: "Mandarin Chinese",
                          value: _languages['mandarin'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['mandarin'] = v!;
                          }),
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxItem(
                          label: "Malay",
                          value: _languages['malay'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['malay'] = v!;
                          }),
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxItem(
                          label: "Tamil",
                          value: _languages['tamil'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['tamil'] = v!;
                          }),
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxItem(
                          label: "Tagalog",
                          value: _languages['tagalog'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['tagalog'] = v!;
                          }),
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxItem(
                          label: "Indonesian/Bahasa",
                          value: _languages['indonesian'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['indonesian'] = v!;
                          }),
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxItem(
                          label: "Burmese",
                          value: _languages['burmese'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['burmese'] = v!;
                          }),
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxItem(
                          label: "Cantonese",
                          value: _languages['cantonese'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['cantonese'] = v!;
                          }),
                        ),
                        const SizedBox(height: 12),
                        CustomCheckboxItem(
                          label: "Hindi",
                          value: _languages['hindi'] as bool,
                          onChanged: (v) => setState(() {
                            _languages['hindi'] = v!;
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<BiodataBloc, BiodataState>(
        builder: (context, state) {
          return FormFooter(
            isNextLoading: state.status == BiodataStateStatus.loading,
            isSaveLoading: state.status == BiodataStateStatus.saveDraftLoading,
            onNext: () {
              if (checkEmpty()) {
                context.go(RoutePaths.preferences);
                return;
              } else {
                //save
                final data = getData();
                oldData == null
                    ? context.read<BiodataBloc>().add(
                        AddOtherPersonalInfo(data: data),
                      )
                    : context.read<BiodataBloc>().add(
                        UpdateOtherPersonalInfo(data: data),
                      );
              }
            },
            onSave: () {
              if (checkEmpty()) {
                context.go(RoutePaths.preferences);
                return;
              } else {
                final data = getData();
                context.read<BiodataBloc>().add(
                  SaveDraftOtherPersonalInfo(data: data),
                );
              }
            },
          );
        },
      ),
    );
  }

  OtherPersonalInfo getData() {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return oldData == null
        ? OtherPersonalInfo(
            code: nanoid(10),
            languagesSpoken: _languages.entries
                .where((kv) => kv.value)
                .toList()
                .map((kv) => kv.key)
                .toList(),
            isPublished: true,
            user: currentUser,
          )
        : oldData!.copyWith(
            languagesSpoken: _languages.entries
                .where((kv) => kv.value)
                .toList()
                .map((kv) => kv.key)
                .toList(),
            isPublished: true,
            user: currentUser,
          );
  }

  bool checkEmpty() {
    return _languages.values.where((v) => v == true).isEmpty;
  }
}
