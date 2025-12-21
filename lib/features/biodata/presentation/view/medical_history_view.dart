import 'package:amplify_flutter/amplify_flutter.dart';
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
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_checkbox_tile.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_text_field.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/form_footer.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/MedicalHistory.dart';

class MedicalHistoryView extends StatefulWidget {
  const MedicalHistoryView({super.key});

  @override
  State<MedicalHistoryView> createState() => _MedicalHistoryViewState();
}

class _MedicalHistoryViewState extends State<MedicalHistoryView> {
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _otherIllnessesController =
      TextEditingController();
  final TextEditingController _disabilitiesController = TextEditingController();
  final TextEditingController _dietaryController = TextEditingController();
  MedicalHistory? oldData;
  // State for checkboxes
  final Map<String, bool> _illnesses = {
    'mental': false,
    'tuberculosis': false,
    'epilepsy': false,
    'heart_disease': false,
    'asthma': false,
    'malaria': false,
    'diabetes': false,
    'operations': false,
    'hypertension': false,
  };

  // Illness labels
  final Map<String, String> _illnessLabels = {
    'mental': 'Mental illness',
    'tuberculosis': 'Tuberculosis',
    'epilepsy': 'Epilepsy',
    'heart_disease': 'Heart disease',
    'asthma': 'Asthma',
    'malaria': 'Malaria',
    'diabetes': 'Diabetes',
    'operations': 'Had Operations',
    'hypertension': 'Hypertension',
  };
  bool isFirstTimePressed = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isInitialized = false;

  @override
  void initState() {
    context.read<BiodataBloc>().add(GetMedicalHistory());
    super.initState();
  }

  @override
  void dispose() {
    _allergiesController.dispose();
    _otherIllnessesController.dispose();
    _disabilitiesController.dispose();
    _dietaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.lightTextColor),
          onPressed: () => context.go(RoutePaths.home),
        ),
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.3,
                  backgroundColor: Colors.grey[300],
                  color: AppColors.primary,
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Step 3 of 7",
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        toolbarHeight: 60,
      ),
      backgroundColor: AppColors.lightBgColor,
      body: BlocConsumer<BiodataBloc, BiodataState>(
        listener: (context, state) {
          if (state.action == BiodataStateAction.medicalHis &&
              state.status == BiodataStateStatus.success) {
            showSuccess(context, "Your information has been saved");
            context.go(RoutePaths.foodHandling);
          }
          if (state.action == BiodataStateAction.medicalHis &&
              state.status == BiodataStateStatus.failure) {
            showError(
              context,
              "Failed to save your information. Please try again.",
            );
          }
          if (!isInitialized && !(state.medicalHistory == null)) {
            setState(() {
              isInitialized = true;
              oldData = state.medicalHistory;
              _allergiesController.text =
                  state.medicalHistory?.anyAllergies ?? "";
              _otherIllnessesController.text =
                  state.medicalHistory?.otherIllnesses ?? "";
              _disabilitiesController.text =
                  state.medicalHistory?.physicalDisabilities ?? "";
              _dietaryController.text =
                  state.medicalHistory?.dietaryRestrictions ?? "";
              (state.medicalHistory?.pastAndExistingIllnesses ?? []).forEach((
                v,
              ) {
                if (_illnesses.containsKey(v)) {
                  //mean it is checked
                  _illnesses[v] = true;
                }
              });
            });
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              // Main content padding (p-6)
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Text(
                    'Medical History',
                    style: TextStyle(
                      fontSize: 18, // text-2xl
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1e293b), // slate-800
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Please provide your medical information',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryTextColor, // slate-500
                    ),
                  ),
                  const SizedBox(height: 32), // space-y-8
                  // Form Content
                  CustomTextField(
                    isFirstTimePressed: isFirstTimePressed,
                    label: 'Do you have any allergies?',
                    placeholder: "List any allergies (or write 'NIL' if none)",
                    controller: _allergiesController,
                  ),
                  const SizedBox(height: 32), // space-y-8
                  // Checkbox Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Past and Existing Illnesses',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF334155), // slate-700
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Select any conditions you have or had:',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryTextColor, // slate-500
                        ),
                      ),
                      const SizedBox(height: 12),
                      /*  GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12.0, // gap-3
                        mainAxisSpacing: 12.0, */
                      // gap-3
                      //childAspectRatio: 3.5, // Adjust aspect ratio as needed
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: _illnessLabels.entries
                                .map(
                                  (entry) => SizedBox(
                                    width: constraints.maxWidth * 0.45,
                                    child: CustomCheckboxTile(
                                      inputKey: entry.key,
                                      label: entry.value,
                                      items: _illnesses,
                                      onChanged: (v) => setState(() {
                                        _illnesses[entry.key] = v!;
                                      }),
                                      onTap: () => setState(() {
                                        _illnesses[entry.key] =
                                            !_illnesses[entry.key]!;
                                      }),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32), // space-y-8

                  CustomTextField(
                    isFirstTimePressed: isFirstTimePressed,
                    label: 'Other Illnesses (if any)',
                    placeholder: 'Please specify',
                    controller: _otherIllnessesController,
                  ),
                  const SizedBox(height: 32), // space-y-8

                  CustomTextField(
                    isFirstTimePressed: isFirstTimePressed,
                    label: 'Physical Disabilities',
                    placeholder:
                        "List any physical disabilities (or write 'NIL' if none)",
                    controller: _disabilitiesController,
                  ),
                  const SizedBox(height: 32), // space-y-8

                  CustomTextField(
                    isFirstTimePressed: isFirstTimePressed,
                    label: 'Dietary Restrictions',
                    placeholder:
                        "Any dietary restrictions? (or write 'NIL' if none)",
                    controller: _dietaryController,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Footer
      bottomNavigationBar: FormFooter(
        onNext: () {
          if (checkEmpty()) {
            context.go(RoutePaths.foodHandling);
            return;
          } else {
            //save
            context.read<BiodataBloc>().add(
              AddMedicalHistory(
                data: oldData == null
                    ? MedicalHistory(
                        code: nanoid(10),
                        createdAt: TemporalDateTime(DateTime.now()),
                        type: "",
                        anyAllergies: _allergiesController.text,
                        pastAndExistingIllnesses: _illnesses.entries
                            .where((kv) => kv.value == true)
                            .toList()
                            .map((kv) => kv.key)
                            .toList(),
                        otherIllnesses: _otherIllnessesController.text,
                        physicalDisabilities: _disabilitiesController.text,
                        dietaryRestrictions: _dietaryController.text,
                        user: currentUser,
                        isPublished: true,
                      )
                    : oldData!.copyWith(
                        updatedAt: TemporalDateTime(DateTime.now()),
                        type: "",
                        anyAllergies: _allergiesController.text,
                        pastAndExistingIllnesses: _illnesses.entries
                            .where((kv) => kv.value == true)
                            .toList()
                            .map((kv) => kv.key)
                            .toList(),
                        otherIllnesses: _otherIllnessesController.text,
                        physicalDisabilities: _disabilitiesController.text,
                        dietaryRestrictions: _dietaryController.text,
                        user: currentUser,
                        isPublished: true,
                      ),
              ),
            );
          }
        },
        onSave: () {
          if (checkEmpty()) {
            context.go(RoutePaths.foodHandling);
            return;
          } else {
            //save
            context.read<BiodataBloc>().add(
              AddMedicalHistory(
                data: oldData == null
                    ? MedicalHistory(
                        code: nanoid(10),
                        createdAt: TemporalDateTime(DateTime.now()),
                        type: "",
                        anyAllergies: _allergiesController.text,
                        pastAndExistingIllnesses: _illnesses.entries
                            .where((kv) => kv.value == true)
                            .toList()
                            .map((kv) => kv.key)
                            .toList(),
                        otherIllnesses: _otherIllnessesController.text,
                        physicalDisabilities: _disabilitiesController.text,
                        dietaryRestrictions: _dietaryController.text,
                        user: currentUser,
                        isPublished: false,
                      )
                    : oldData!.copyWith(
                        updatedAt: TemporalDateTime(DateTime.now()),
                        type: "",
                        anyAllergies: _allergiesController.text,
                        pastAndExistingIllnesses: _illnesses.entries
                            .where((kv) => kv.value == true)
                            .toList()
                            .map((kv) => kv.key)
                            .toList(),
                        otherIllnesses: _otherIllnessesController.text,
                        physicalDisabilities: _disabilitiesController.text,
                        dietaryRestrictions: _dietaryController.text,
                        user: currentUser,
                        isPublished: false,
                      ),
              ),
            );
          }
        },
      ),
    );
  }

  bool checkEmpty() {
    return _allergiesController.text.isEmpty &&
        _illnesses.values.where((v) => v == true).isEmpty &&
        _otherIllnessesController.text.isEmpty &&
        _disabilitiesController.text.isEmpty &&
        _dietaryController.text.isEmpty;
  }
}
