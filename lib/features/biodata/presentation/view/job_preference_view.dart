import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/features/biodata/domain/work_history_cubic.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_form_dropdown.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_text_field.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/form_footer.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/radio_option.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/work_experience_component.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/JobPreferences.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class JobPreferenceView extends StatefulWidget {
  const JobPreferenceView({super.key});

  @override
  State<JobPreferenceView> createState() => _JobPreferenceViewState();
}

class _JobPreferenceViewState extends State<JobPreferenceView> {
  bool isFirstTimePressed = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isInitialized = false;
  final TextStyle _labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.grey[700],
  );
  TextEditingController experience = TextEditingController();
  TextEditingController expectedSalary = TextEditingController();
  String expectedSalaryPlaceholder = "500";
  TextEditingController skills = TextEditingController();
  static const List<Map<String, dynamic>> _experienceOptions = [
    {"name": 'No experiences', "salary": "500"},
    {"name": 'No experiences but nursing aid certificates', "salary": "520"},
    {"name": 'Middle east experiences', "salary": "520-580 "},
    {"name": 'Singapore experiences', "salary": "540-700"},
    {"name": 'Taiwan experiences', "salary": "600-670"},
  ];
  /* basic salary 
Ex-middle east- 520-580 
ex-sg- 540-700 
Ex-taiwan- 600-670 */
  static const List<String> _offDaysOptions = [
    '1 day',
    '2 days',
    '3 days',
    '4 day',
    '5 days',
    '6 days',
    '7 days',
    '8 days',
  ];

  static const List<String> _locationOptions = [
    'Any location in Singapore',
    'North',
    'South',
    'East',
    'West',
    'Central',
  ];

  // Current selected values
  Map<String, dynamic>? _selectedExperience;
  String? _selectedOffDays;
  String? _selectedLocation = _locationOptions[0];
  String? _willingToWork; // For radio buttons
  JobPreferences? oldData;

  @override
  void initState() {
    context.read<BiodataBloc>().add(GetJobPreference());
    super.initState();
  }

  void setInitialData(
    JobPreferences jobPreference,
    List<WorkHistory>? workHistories,
    User? currentUser,
  ) {
    isInitialized = true;
    if (workHistories?.isNotEmpty ?? false) {
      context.read<WorkHistoryCubit>().addWorkHistories(
        workHistories!,
      );
    }
    oldData = jobPreference;
    experience.text =
        jobPreference.user?.totalExperiences ??
        currentUser?.totalExperiences ??
        "";
    skills.text =
        (jobPreference.user?.skills ?? currentUser?.skills)?.join(", ") ?? "";
    if (!(jobPreference.user?.expectedSalary == null) ||
        !(currentUser?.expectedSalary == null)) {
      final salaryMap =
          jsonDecode(
                jobPreference.user?.expectedSalary ??
                    currentUser!.expectedSalary!,
              )
              as Map<String, dynamic>;
      debugPrint("🌈 Salary Map: $salaryMap");
      _selectedExperience = _experienceOptions
          .firstWhere(
            (e) => (e["name"] as String).startsWith(
              salaryMap["name"] as String,
            ),
          ) /* {
                      "name": salaryMap["name"],
                      "salary": salaryMap["salary"],
                    } */;
      expectedSalary.text = salaryMap["expectedSalary"] as String;
    }

    _selectedOffDays = jobPreference.preferredOffDaysPerMonth ?? "";
    _selectedLocation = jobPreference.preferredLocationInSingapore ?? "";
    _willingToWork = (jobPreference.willingWorkOnRestDays ?? false)
        ? "yes"
        : "no";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryLight),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RoutePaths.home);
            }
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.6, // 10% for Step 1 of 10
                  backgroundColor: Colors.grey[300],
                  color: AppColors.primary,
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Step 6 of 7",
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

      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            // Padding from the HTML (p-4 pt-6)
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: BlocListener<BiodataBloc, BiodataState>(
              listener: (context, state) {
                if (state.action == BiodataStateAction.jobPrefer &&
                    state.status == BiodataStateStatus.success) {
                  showSuccess(context, "Your information has been saved");
                  context.go(RoutePaths.uploadDocuments);
                }
                if (state.action == BiodataStateAction.jobPrefer &&
                    state.status == BiodataStateStatus.saveDraftSuccess) {
                  showSuccess(context, "Draft saved successfully");
                }
                if (state.action == BiodataStateAction.jobPrefer &&
                    state.status == BiodataStateStatus.failure) {
                  showError(
                    context,
                    "Failed to save your information. Please try again.",
                  );
                }
                if (!isInitialized && !(state.jobPreference == null)) {
                  setInitialData(
                    state.jobPreference!,
                    state.workHistories,
                    currentUser,
                  );
                }
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.cardLight,
                      borderRadius: BorderRadius.circular(12), // rounded-lg
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Experience & Skills",
                          style: TextStyle(
                            color: AppColors.textPrimaryLight,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 24),
                        CustomTextField(
                          isFirstTimePressed: isFirstTimePressed,
                          controller: experience,
                          label: "Total Experience",
                          placeholder: "e.g. 5year",
                          isRequired: true,
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          isFirstTimePressed: isFirstTimePressed,
                          controller: skills,
                          label: "Skills",
                          placeholder: "e.g. Cooking, Childcare, Cleaning",
                          isRequired: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const WorkExperienceComponent(),
                  const SizedBox(height: 24),
                  Container(
                    // Card styling from the HTML (bg-white rounded-2xl shadow-sm p-6)
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(25),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header text
                        const Text(
                          'Job Preferences',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tell us about your job expectations',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 24), // space-y-6
                        // --- Expected Monthly Salary ---
                        RichText(
                          text: const TextSpan(
                            text: "Expected Monthly Salary",
                            style: TextStyle(
                              color: AppColors.textSecondaryLight,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                            children: [
                              TextSpan(
                                text: " *",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return DropdownButtonFormField<
                              Map<String, dynamic>
                            >(
                              value: _selectedExperience,

                              decoration: dropdownDecoration.copyWith(
                                hintText: "Select your experience",
                                errorStyle: const TextStyle(
                                  height: 0,
                                  fontSize: 0,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                              icon: const Icon(Icons.expand_more),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                              items: _experienceOptions.map((
                                Map<String, dynamic> value,
                              ) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: value,
                                  child: SizedBox(
                                    width: constraints.maxWidth - 60,
                                    child: Text(
                                      value["name"] as String,
                                      style: TextStyle(
                                        color:
                                            value["name"] ==
                                                'Select experiences'
                                            ? Colors.grey[600]
                                            : Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedExperience = newValue!;
                                  expectedSalaryPlaceholder =
                                      newValue["salary"] as String;
                                });
                              },
                            );
                          },
                        ),
                        InputError(
                          padding: EdgeInsets.zero,
                          isError:
                              isFirstTimePressed && _selectedExperience == null,
                          error: "Experience is required",
                        ),

                        const SizedBox(height: 16),
                        CustomTextField(
                          isFirstTimePressed: isFirstTimePressed,
                          controller: expectedSalary,
                          label: "Salary",
                          customValidator: (v) => customValidSalary(v ?? ""),
                          customIsError:
                              !(validSalary() == null) && isFirstTimePressed,
                          customError: validSalary(),
                          placeholder: expectedSalaryPlaceholder,
                          isRequired: true,
                          labelStyle: _labelStyle,
                        ),
                        const SizedBox(height: 24), // space-y-6

                        CustomFormDropDown(
                          isRequired: true,
                          label: 'Preferred Off Days per Month',
                          initialValue: _selectedOffDays,
                          placeholder: "Select your prefered off days",
                          isFirstTimePressed: isFirstTimePressed,
                          //  decoration: dropdownDecoration,
                          //icon: const Icon(Icons.expand_more),
                          items: _offDaysOptions,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedOffDays = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 24), // space-y-6

                        CustomFormDropDown(
                          isFirstTimePressed: isFirstTimePressed,
                          label: 'Preferred Location in Singapore',
                          placeholder: "Select your preferred location",
                          initialValue: _selectedLocation,
                          items: _locationOptions,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLocation = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 24), // space-y-6
                        // --- Willing to work on rest days ---
                        Text(
                          'Willing to work on rest days for compensation?',
                          style: _labelStyle,
                        ),
                        const SizedBox(height: 12),
                        RadioOption(
                          value: 'yes',
                          title: 'Yes, willing',
                          groupValue: _willingToWork,
                          isSelected: _willingToWork == 'yes',
                          onChanged: (newValue) {
                            setState(() {
                              _willingToWork = newValue;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _willingToWork = 'yes';
                            });
                          },
                        ),
                        const SizedBox(height: 12), // space-y-3
                        RadioOption(
                          value: 'no',
                          title: 'Prefer not to',
                          groupValue: _willingToWork,
                          isSelected: _willingToWork == 'no',
                          onChanged: (newValue) {
                            setState(() {
                              _willingToWork = newValue;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _willingToWork = 'no';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // --- Footer ---
      bottomNavigationBar: BlocBuilder<BiodataBloc, BiodataState>(
        builder: (context, state) {
          return FormFooter(
            isNextLoading: state.status == BiodataStateStatus.loading,
            isSaveLoading: state.status == BiodataStateStatus.saveDraftLoading,
            onNext: () {
              setState(() {
                isFirstTimePressed = true;
              });
              if (formKey.currentState?.validate() ?? false) {
                final data = getData();
                oldData == null
                    ? context.read<BiodataBloc>().add(
                        AddJobPreference(
                          data: data,
                          workHistories: context.read<WorkHistoryCubit>().state,
                        ),
                      )
                    : context.read<BiodataBloc>().add(
                        UpdateJobPreference(
                          data: data,
                          workHistories: context.read<WorkHistoryCubit>().state,
                        ),
                      );
              }
            },
            onSave: () {
              setState(() {
                isFirstTimePressed = true;
              });
              if (formKey.currentState?.validate() ?? false) {
                final data = getData();
                context.read<BiodataBloc>().add(
                  SaveDraftJobPreference(
                    data: data,
                    workHistories: context.read<WorkHistoryCubit>().state,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  JobPreferences getData() {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return oldData == null
        ? JobPreferences(
            createdAt: TemporalDateTime(DateTime.now()),
            code: nanoid(10),
            preferredOffDaysPerMonth: _selectedOffDays,
            preferredLocationInSingapore: _selectedLocation,
            willingWorkOnRestDays: _willingToWork == "yes",
            user: currentUser?.copyWith(
              totalExperiences: experience.text,
              skills: skills.text.split(","),
              expectedSalary: jsonEncode({
                ..._selectedExperience!,
                "expectedSalary": expectedSalary.text,
              }),
            ),
            isPublished: true,
          )
        : oldData!.copyWith(
            updatedAt: TemporalDateTime(DateTime.now()),
            preferredOffDaysPerMonth: _selectedOffDays,
            preferredLocationInSingapore: _selectedLocation,
            willingWorkOnRestDays: _willingToWork == "yes",
            user: currentUser?.copyWith(
              totalExperiences: experience.text,
              skills: skills.text.split(","),
              expectedSalary: jsonEncode({
                ..._selectedExperience!,
                "expectedSalary": expectedSalary.text,
              }),
            ),
            isPublished: true,
          );
  }

  String? customValidSalary(String v) {
    final input = int.tryParse(v) ?? 0;
    if (input <= 0) {
      return "";
    }
    switch (_selectedExperience?['name']) {
      case 'Select experiences':
        return "";
      case 'No experiences':
        if (input > 500) {
          return "";
        }
        return null;
      case 'No experiences but nursing aid certificates':
        if (input > 520) {
          return "";
        }
        return null;
      case 'Middle east experiences':
        if (input > 580) {
          return "";
        }
        return null;
      case 'Singapore experiences':
        if (input > 700) {
          return "";
        }
        return null;
      case 'Taiwan experiences':
        if (input > 670) {
          return "";
        }
        return null;
      default:
        return null;
    }
  }

  String? validSalary() {
    final input = int.tryParse(expectedSalary.text) ?? 0;
    if (input <= 0) {
      return "Please input your expected salary";
    }
    switch (_selectedExperience?['name']) {
      case 'Select experiences':
        return "Please select your experience and input expected salary.";
      case 'No experiences':
        if (input > 500) {
          return "Your expected salary shouldn't be greater than \$500";
        }
        return null;
      case 'No experiences but nursing aid certificates':
        if (input > 520) {
          return "Your expected salary shouldn't be greater than \$520";
        }
        return null;
      case 'Middle east experiences':
        if (input > 580) {
          return "Your expected salary shouldn't be greater than \$580";
        }
        return null;
      case 'Singapore experiences':
        if (input > 700) {
          return "Your expected salary shouldn't be greater than \$700";
        }
        return null;
      case 'Taiwan experiences':
        if (input > 670) {
          return "Your expected salary shouldn't be greater than \$670";
        }
        return null;
      default:
        return null;
    }
  }
}
