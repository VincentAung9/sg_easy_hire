import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_datepicker.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_form_dropdown.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_text_field.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/form_footer.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/PersonalInformation.dart';
import 'package:sg_easy_hire/models/User.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  PersonalInformation? oldData;
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
    context.read<BiodataBloc>().add(GetPersonalInformation());
    initUserValue();
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

  void initUserValue() {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    fullNameController.text = currentUser?.fullName ?? "";
    heightController.text = currentUser?.height ?? "";
    weightController.text = currentUser?.weight ?? "";
    nationality = currentUser?.nationality;
    setState(() {});
  }

  void setInitialData(
    PersonalInformation? personalInformation,
    User? currentUser,
  ) {
    debugPrint("🌈 CURRENT USER: ${currentUser?.toJson()}");
    isInitialized = true;
    oldData = personalInformation;
    fullNameController.text =
        personalInformation?.user?.fullName ?? currentUser?.fullName ?? "";
    heightController.text =
        personalInformation?.user?.height ?? currentUser?.height ?? "";
    weightController.text =
        personalInformation?.user?.weight ?? currentUser?.weight ?? "";
    nationality =
        personalInformation?.user?.nationality ?? currentUser?.nationality;
    dateOfBirth = personalInformation?.dateOfBirth!.getDateTime().toLocal();
    placeController.text = personalInformation?.placeOfBirth ?? "";

    gender = personalInformation?.gender ?? "";

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
      body: BlocListener<BiodataBloc, BiodataState>(
        listener: (context, state) {
          if (state.action == BiodataStateAction.personalInfo &&
              state.status == BiodataStateStatus.success) {
            showSuccess(context, "Your information has been submitted");
            //TODO:GO NEXT
            context.go(RoutePaths.contactFamilyDetails);
          }
          if (state.action == BiodataStateAction.personalInfo &&
              state.status == BiodataStateStatus.saveDraftSuccess) {
            showSuccess(context, "Draft saved successfully.");
            //TODO:GO NEXT
            //context.go(RoutePaths.contactFamilyDetails);
          }
          if (state.action == BiodataStateAction.personalInfo &&
              state.status == BiodataStateStatus.failure) {
            showError(
              context,
              "Failed to save your information. Please try again.",
            );
          }
          if (!isInitialized && !(state.personalInformation == null)) {
            //setState
            setInitialData(state.personalInformation!, currentUser);
          }
        },
        child: Form(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ),
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
                //TODO: Save and Next
                final data = getData(true);
                oldData == null
                    ? context.read<BiodataBloc>().add(
                        AddPersonalInformation(data: data),
                      )
                    : context.read<BiodataBloc>().add(
                        UpdatePersonalInformation(data: data),
                      );
              }
            },
            onSave: () {
              setState(() {
                isFirstTimePressed = true;
              });
              if (formKey.currentState?.validate() ?? false) {
                final data = getData(false);
                context.read<BiodataBloc>().add(
                  SaveDraftPersonalInformation(data: data),
                );
              }
            },
          );
        },
      ),
    );
  }

  PersonalInformation getData(bool isPublished) {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return oldData == null
        ? PersonalInformation(
            code: nanoid(10),
            createdAt: TemporalDateTime(DateTime.now()),
            dateOfBirth: TemporalDate(dateOfBirth!),
            placeOfBirth: placeController.text,
            gender: gender,
            user: currentUser?.copyWith(
              fullName: fullNameController.text,
              nationality: nationality,
              height: heightController.text,
              weight: weightController.text,
            ),
            isPublished: isPublished,
          )
        : oldData!.copyWith(
            updatedAt: TemporalDateTime(DateTime.now()),
            dateOfBirth: TemporalDate(dateOfBirth!),
            placeOfBirth: placeController.text,
            gender: gender,
            user: currentUser?.copyWith(
              fullName: fullNameController.text,
              nationality: nationality,
              height: heightController.text,
              weight: weightController.text,
            ),
            isPublished: isPublished,
          );
  }
}
