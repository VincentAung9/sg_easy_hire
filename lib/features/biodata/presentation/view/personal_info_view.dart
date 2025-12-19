import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_datepicker.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_form_dropdown.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_text_field.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/form_footer.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  DateTime? dateOfBirth;
  String? nationality;
  String? gender;
  bool isFirstTimePressed = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isInitialized = false;

  @override
  void initState() {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    fullNameController.text = currentUser?.fullName ?? "";
    heightController.text = currentUser?.height ?? "";
    weightController.text = currentUser?.weight ?? "";
    nationality = currentUser?.nationality;
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    placeController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryLight),
          onPressed: () {
            context.go(RoutePaths.home);
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.1, // 10% for Step 1 of 10
                  backgroundColor: Colors.grey[300],
                  color: AppColors.primary,
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Step 1 of 7",
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
      body: BlocConsumer<BiodataBloc, BiodataState>(
        listener: (context, state) {
          if (!isInitialized) {
            //setState
            if (!(state.personalInformation == null)) {
              isInitialized = true;
              dateOfBirth = state.personalInformation!.dateOfBirth!
                  .getDateTime()
                  .toLocal();
              placeController.text =
                  state.personalInformation?.placeOfBirth ?? "";

              gender = state.personalInformation?.gender ?? "";
            }
            setState(() {});
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            autovalidateMode: isFirstTimePressed
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: AppColors.cardLight,
                    borderRadius: BorderRadius.circular(16), // rounded-2xl
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
                        "Personal Information",
                        style: TextStyle(
                          color: AppColors.textPrimaryLight,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Let's start with your basic details",
                        style: TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        controller: fullNameController,
                        label: "Full Name",
                        placeholder: "Enter your full name",
                        isRequired: true,
                        isFirstTimePressed: isFirstTimePressed,
                      ),
                      const SizedBox(height: 24),
                      CustomDatePicker(
                        isFirstTimePressed: isFirstTimePressed,
                        initialDate: dateOfBirth,
                        onChange: (d) => setState(() {
                          dateOfBirth = d;
                        }),
                      ),
                      /* CustomTextField(
                        controller: dateOfBirthController,
                        label: "Date of Birth",
                        placeholder: "dd/mm/yyyy",
                        isRequired: true,
                        suffixIcon: Icons.calendar_today_outlined,
                      ), */
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: placeController,
                        label: "Place of Birth",
                        placeholder: "City/Town",
                        isRequired: true,
                        isFirstTimePressed: isFirstTimePressed,
                      ),
                      const SizedBox(height: 24),
                      CustomFormDropDown(
                        isFirstTimePressed: isFirstTimePressed,
                        initialValue: nationality,
                        onChanged: (v) {
                          setState(() {
                            nationality = v ?? "";
                          });
                        },
                        label: "Nationality",
                        placeholder: "Select nationality",
                        items: const [
                          "Bruneian",
                          "Cambodian",
                          "Indonesian",
                          "Lao",
                          "Malaysian",
                          "Burmese",
                          "Filipino",
                          "Singaporean",
                          "Thai",
                          "Timorese",
                          "Vietnamese",
                        ],
                        isRequired: true,
                      ),
                      const SizedBox(height: 24),
                      CustomFormDropDown(
                        isFirstTimePressed: isFirstTimePressed,
                        initialValue: gender,
                        onChanged: (v) {
                          setState(() {
                            gender = v ?? "";
                          });
                        },
                        label: "Gender",
                        placeholder: "Select gender",
                        items: const ["Male", "Female", "Other"],
                        isRequired: true,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: heightController,
                              label: "Height (cm)",
                              placeholder: "e.g., 161",
                              isRequired: true,
                              keyboardType: TextInputType.number,
                              isFirstTimePressed: isFirstTimePressed,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: weightController,
                              label: "Weight (kg)",
                              placeholder: "e.g., 41",
                              isRequired: true,
                              keyboardType: TextInputType.number,
                              isFirstTimePressed: isFirstTimePressed,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: FormFooter(
        onNext: () {
          setState(() {
            isFirstTimePressed = true;
          });
          if (formKey.currentState?.validate() == true) {
            //TODO: Save and Next
          }
        },
        onSave: () {
          setState(() {
            isFirstTimePressed = true;
          });
          if (formKey.currentState?.validate() == true) {
            //TODO: Save and Next
          } else {
            //draft
          }
        },
      ),
    );
  }
}
