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
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_form_dropdown.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_text_field.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/form_footer.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/ContactFamilyDetails.dart';

class ContactFamilyView extends StatefulWidget {
  const ContactFamilyView({super.key});

  @override
  State<ContactFamilyView> createState() => _ContactFamilyViewState();
}

class _ContactFamilyViewState extends State<ContactFamilyView> {
  bool isFirstTimePressed = false;
  TextEditingController addressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController siblingController = TextEditingController();
  TextEditingController childrenController = TextEditingController();
  TextEditingController ageOfChildrenController = TextEditingController();
  String? religion;
  String? education;
  String? maritalStatus;
  ContactFamilyDetails? oldData;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isInitialized = false;

  @override
  void initState() {
    context.read<BiodataBloc>().add(GetContactFamilyInfo());
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    contactNumberController.dispose();
    portController.dispose();
    emailController.dispose();
    siblingController.dispose();
    childrenController.dispose();
    ageOfChildrenController.dispose();
    super.dispose();
  }

  void setInitialData(ContactFamilyDetails contactFamilyDetails) {
    isInitialized = true;
    oldData = contactFamilyDetails;
    addressController.text = contactFamilyDetails.residentialAddress ?? "";
    contactNumberController.text = contactFamilyDetails.contactNumber ?? "";
    emailController.text = contactFamilyDetails.email ?? "";
    portController.text = contactFamilyDetails.airPort ?? "";
    siblingController.text = contactFamilyDetails.numOfSiblings ?? "";
    childrenController.text = contactFamilyDetails.numOfChild ?? "";
    ageOfChildrenController.text = contactFamilyDetails.ageOfChild ?? "";
    religion = contactFamilyDetails.religion;
    education = contactFamilyDetails.educationLevel;
    maritalStatus = contactFamilyDetails.martialStatus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
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
                  value: 0.2, // 10% for Step 1 of 10
                  backgroundColor: Colors.grey[300],
                  color: AppColors.primary,
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              t.stepProgress(2, 7),
              style: const TextStyle(
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
          if (state.action == BiodataStateAction.contactFam &&
              state.status == BiodataStateStatus.success) {
            showSuccess(context, t.submitSuccess);
            context.go(RoutePaths.medicalHistor);
          }
          if (state.action == BiodataStateAction.contactFam &&
              state.status == BiodataStateStatus.saveDraftSuccess) {
            showSuccess(context, t.draftSaveSuccess);
          }
          if (state.action == BiodataStateAction.contactFam &&
              state.status == BiodataStateStatus.failure) {
            showError(
              context,
              t.submitFailed,
            );
          }
          if (!isInitialized && !(state.contactFamilyDetails == null)) {
            setInitialData(state.contactFamilyDetails!);
          }
        },
        child: Form(
          key: formKey,
          autovalidateMode: isFirstTimePressed
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  padding: const EdgeInsets.all(24.0),
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
                       Text(
                        t.contactFamilyTitle,
                        style: const TextStyle(
                          color: AppColors.textPrimaryLight,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                       Text(
                        t.contactFamilySubtitle,
                        style: const TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: addressController,
                        label: t.residentialAddressLabel,
                        placeholder: t.residentialAddressPlaceholder,
                        isRequired: true,
                        isFirstTimePressed: isFirstTimePressed,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: contactNumberController,
                        label: t.contactNumberLabel,
                        placeholder: t.contactNumberPlaceholder,
                        isRequired: true,
                        keyboardType: TextInputType.phone,
                        isFirstTimePressed: isFirstTimePressed,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: portController,
                        label: t.airportLabel,
                        placeholder:t.airportPlaceholder,
                        isRequired: true,
                        isFirstTimePressed: isFirstTimePressed,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: emailController,
                        label: t.emailLabel,
                        placeholder: t.emailPlaceholder,
                        keyboardType: TextInputType.emailAddress,
                        isFirstTimePressed: isFirstTimePressed,
                      ),
                      const SizedBox(height: 24),
                      CustomFormDropDown(
                        isFirstTimePressed: isFirstTimePressed,
                        initialValue: religion,
                        onChanged: (v) {
                          setState(() {
                            religion = v ?? "";
                          });
                        },
                        label: t.religionLabel,
                        placeholder: t.religionPlaceholder,
                        items: const [
                          "Christianity",
                          "Islam",
                          "Hinduism",
                          "Buddhism",
                          "Judaism",
                          "Other",
                          "Prefer not to say",
                        ],
                        isRequired: true,
                      ),
                      const SizedBox(height: 24),
                      CustomFormDropDown(
                        isFirstTimePressed: isFirstTimePressed,
                        initialValue: education,
                        onChanged: (v) {
                          setState(() {
                            education = v ?? "";
                          });
                        },
                        label: t.educationLabel,
                        placeholder: t.educationPlaceholder,
                        items: const [
                          "High School",
                          "Diploma",
                          "Bachelor's Degree",
                          "Master's Degree",
                          "Doctorate",
                        ],
                        isRequired: true,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        isFirstTimePressed: isFirstTimePressed,
                        controller: siblingController,
                        label: t.siblingsLabel,
                        placeholder: "0",
                        isRequired: true,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      CustomFormDropDown(
                        isFirstTimePressed: isFirstTimePressed,
                        initialValue: maritalStatus,
                        onChanged: (v) {
                          setState(() {
                            maritalStatus = v ?? "";
                          });
                        },
                        label:t.maritalStatusLabel,
                        placeholder: t.maritalStatusPlaceholder,
                        items: const [
                          "Single",
                          "Married",
                          "Divorced",
                          "Widowed",
                        ],
                        isRequired: true,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        isFirstTimePressed: isFirstTimePressed,
                        controller: childrenController,
                        label: t.childrenLabel,
                        placeholder: "0",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        isFirstTimePressed: isFirstTimePressed,
                        controller: ageOfChildrenController,
                        label:t.childrenAgeLabel,
                        placeholder:t.childrenAgePlaceholder,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              if (checkValid() && (formKey.currentState?.validate() ?? false)) {
                final data = getData();
                oldData == null
                    ? context.read<BiodataBloc>().add(
                        AddContactFamilyInfo(data: data),
                      )
                    : context.read<BiodataBloc>().add(
                        UpdateContactFamilyInfo(data: data),
                      );
              }
            },
            onSave: () {
              /* setState(() {
                isFirstTimePressed = true;
              });
              if (checkValid() && (formKey.currentState?.validate() ?? false)) { */
              final data = getData();
              context.read<BiodataBloc>().add(
                SaveDraftContactFamilyInfo(data: data),
              );
            },
            /*  }, */
          );
        },
      ),
    );
  }

  ContactFamilyDetails getData() {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return oldData == null
        ? ContactFamilyDetails(
            code: nanoid(10),
            createdAt: TemporalDateTime(DateTime.now()),
            residentialAddress: addressController.text,
            contactNumber: contactNumberController.text,
            email: emailController.text,
            airPort: portController.text,
            religion: religion,
            educationLevel: education,
            numOfSiblings: siblingController.text,
            martialStatus: maritalStatus,
            numOfChild: childrenController.text,
            ageOfChild: ageOfChildrenController.text,
            user: currentUser,
            isPublished: false,
          )
        : oldData!.copyWith(
            updatedAt: TemporalDateTime(DateTime.now()),
            residentialAddress: addressController.text,
            contactNumber: contactNumberController.text,
            email: emailController.text,
            airPort: portController.text,
            religion: religion,
            educationLevel: education,
            numOfSiblings: siblingController.text,
            martialStatus: maritalStatus,
            numOfChild: childrenController.text,
            ageOfChild: ageOfChildrenController.text,
            user: currentUser,
            isPublished: false,
          );
  }

  bool checkValid() {
    return addressController.text.isNotEmpty &&
        contactNumberController.text.isNotEmpty &&
        portController.text.isNotEmpty &&
        religion != null &&
        education != null &&
        siblingController.text.isNotEmpty &&
        maritalStatus != null;
  }
}
