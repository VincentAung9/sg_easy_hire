import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nanoid/non_secure.dart';
import 'package:sg_easy_hire/core/repository/storage_repository.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/build_select_file.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/build_upload_box.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/form_footer.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/UploadedDocuments.dart';

class UploadDocumentView extends StatefulWidget {
  const UploadDocumentView({super.key});

  @override
  State<UploadDocumentView> createState() => _UploadDocumentViewState();
}

class _UploadDocumentViewState extends State<UploadDocumentView> {
  bool isInitialized = false;
  PlatformFile? profilePhoto;
  PlatformFile? passport;
  PlatformFile? medicalCertificate;
  PlatformFile? policeClearance;
  List<PlatformFile>? educationalCertificates;
  List<PlatformFile>? workReferences;
  PlatformFile? introductionVideo;
  UploadedDocuments? oldData;
  bool isFirstTimePressed = false;

  @override
  void initState() {
    context.read<BiodataBloc>().add(GetUploadedDocument());
    super.initState();
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
          onPressed: () => context.go(RoutePaths.home),
        ),
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 1, // 10% for Step 1 of 10
                  backgroundColor: Colors.grey[300],
                  color: AppColors.primary,
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Step 7 of 7",
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
          if (state.action == BiodataStateAction.uploadDoc &&
              state.status == BiodataStateStatus.success) {
            showSuccess(context, "Your documents has been saved");
            context.go(RoutePaths.medicalHistor);
          }
          if (state.action == BiodataStateAction.uploadDoc &&
              state.status == BiodataStateStatus.failure) {
            showError(
              context,
              "Failed to save your documents. Please try again.",
            );
          }
          if (!isInitialized && !(state.documents == null)) {
            debugPrint("🌈 Old Documents: ${state.documents}");
            setState(() {
              isInitialized = true;
              oldData = state.documents;
              introductionVideo = state.documents?.introductionVideo == null
                  ? null
                  : awsJsonToPlatformFile(state.documents!.introductionVideo!);
              profilePhoto = state.documents?.profilePhoto == null
                  ? null
                  : awsJsonToPlatformFile(state.documents!.profilePhoto!);
              passport = state.documents?.passport == null
                  ? null
                  : awsJsonToPlatformFile(state.documents!.passport!);
              medicalCertificate = state.documents?.medicalCertificate == null
                  ? null
                  : awsJsonToPlatformFile(state.documents!.medicalCertificate!);
              policeClearance = state.documents?.policeClearance == null
                  ? null
                  : awsJsonToPlatformFile(state.documents!.policeClearance!);
              educationalCertificates =
                  (state.documents?.educationalCertificates ?? [])
                      .map(awsJsonToPlatformFile)
                      .toList();
              workReferences = (state.documents?.workReferences ?? [])
                  .map(awsJsonToPlatformFile)
                  .toList();
            });
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24.0), // p-6
              children: [
                const Text(
                  "Upload Your Documents",
                  style: TextStyle(
                    color: AppColors.textPrimaryLight,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 24), // space-y-6
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildUploadBox(
                      isError: isFirstTimePressed && introductionVideo == null,
                      label: "Introduction Video",
                      icon: Icons.video_call,
                      subtitle: "mp4, mov, avi, mkv, wmv, flv, webm",
                      isRequired: true,
                      onTap: () async {
                        final result = await StorageRepository.pickFile(
                          allowedExtensions: [
                            "mp4",
                            "mov",
                            "avi",
                            "mkv",
                            "wmv",
                            "flv",
                            "webm",
                          ],
                        );
                        if (result != null) {
                          setState(() {
                            introductionVideo = result.single;
                          });
                        }
                      },
                    ),
                    BuildSelectFile(
                      show: introductionVideo != null,
                      file: introductionVideo,
                      onRemove: () {
                        setState(() {
                          introductionVideo = null;
                        });
                      },
                    ),
                    const SizedBox(height: 32), // space-y-8
                    BuildUploadBox(
                      isError: isFirstTimePressed && profilePhoto == null,
                      label: "Profile Photo",
                      icon: Icons.photo_camera,
                      subtitle: "JPG, PNG (Max 5MB)",
                      isRequired: true,
                      onTap: () async {
                        final result = await StorageRepository.pickFile(
                          allowedExtensions: ["jpg", "png"],
                        );
                        if (result != null) {
                          setState(() {
                            profilePhoto = result.single;
                          });
                        }
                      },
                    ),
                    BuildSelectFile(
                      show: profilePhoto != null,
                      file: profilePhoto,
                      onRemove: () {
                        setState(() {
                          profilePhoto = null;
                        });
                      },
                    ),
                    const SizedBox(height: 32), // space-y-8
                    BuildUploadBox(
                      isError: isFirstTimePressed && passport == null,
                      label: "Passport",
                      icon: Icons.badge,
                      subtitle: "PDF, JPG, PNG (Max 5MB)",
                      isRequired: true,
                      onTap: () async {
                        final result = await StorageRepository.pickFile();
                        if (result != null) {
                          setState(() {
                            passport = result.single;
                          });
                        }
                      },
                    ),
                    BuildSelectFile(
                      show: passport != null,
                      file: passport,
                      onRemove: () {
                        setState(() {
                          passport = null;
                        });
                      },
                    ),

                    const SizedBox(height: 32),
                    BuildUploadBox(
                      label: "Medical Certificate",
                      icon: Icons.medical_services,
                      subtitle: "PDF, JPG, PNG (Max 5MB)",
                      isRequired: false,
                      onTap: () async {
                        final result = await StorageRepository.pickFile();
                        if (result != null) {
                          setState(() {
                            medicalCertificate = result.single;
                          });
                        }
                      },
                    ),
                    BuildSelectFile(
                      show: medicalCertificate != null,
                      file: medicalCertificate,
                      onRemove: () {
                        setState(() {
                          medicalCertificate = null;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    BuildUploadBox(
                      label: "Police Clearance",
                      icon: Icons.local_police,
                      subtitle: "PDF, JPG, PNG (Max 5MB)",
                      isRequired: false,
                      onTap: () async {
                        final result = await StorageRepository.pickFile();
                        if (result != null) {
                          setState(() {
                            policeClearance = result.single;
                          });
                        }
                      },
                    ),
                    BuildSelectFile(
                      show: policeClearance != null,
                      file: policeClearance,
                      onRemove: () {
                        setState(() {
                          policeClearance = null;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    BuildUploadBox(
                      label: "Educational Certificates",
                      icon: Icons.school,
                      subtitle: "PDF, JPG, PNG (Max 5MB each)",
                      isOptional: true,
                      onTap: () async {
                        final result = await StorageRepository.pickFile(
                          allowMultiple: true,
                        );
                        if (result != null) {
                          setState(() {
                            educationalCertificates = result;
                          });
                        }
                      },
                    ),
                    ...(educationalCertificates ?? []).map(
                      (ec) => BuildSelectFile(
                        show: educationalCertificates?.isNotEmpty ?? false,
                        file: ec,
                        onRemove: () {
                          setState(() {
                            educationalCertificates!.removeWhere(
                              (rec) => rec.path == ec.path,
                            );
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    BuildUploadBox(
                      label: "Work References",
                      icon: Icons.work,
                      subtitle: "PDF, JPG, PNG (Max 5MB each)",
                      isOptional: true,
                      onTap: () async {
                        final result = await StorageRepository.pickFile(
                          allowMultiple: true,
                        );
                        if (result != null) {
                          setState(() {
                            workReferences = result;
                          });
                        }
                      },
                    ),
                    ...(workReferences ?? []).map(
                      (ec) => BuildSelectFile(
                        show: workReferences?.isNotEmpty == true,
                        file: ec,
                        onRemove: () {
                          setState(() {
                            workReferences!.removeWhere(
                              (rec) => rec.path == ec.path,
                            );
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: FormFooter(
        nextBtnString: "Submit",
        onNext: () {
          setState(() {
            isFirstTimePressed = true;
          });
          //check valid
          // if not valid show error
          //if valid upload and show progress
          if (checkValid()) {
            return;
            final data = oldData == null
                ? UploadedDocuments(
                    code: nanoid(10),
                    createdAt: TemporalDateTime(DateTime.now()),
                    profilePhoto: profilePhoto == null
                        ? null
                        : platformFileToAWSJson(profilePhoto!),
                    passport: passport == null
                        ? null
                        : platformFileToAWSJson(passport!),
                    medicalCertificate: medicalCertificate == null
                        ? null
                        : platformFileToAWSJson(medicalCertificate!),
                    policeClearance: policeClearance == null
                        ? null
                        : platformFileToAWSJson(policeClearance!),
                    educationalCertificates: educationalCertificates
                        ?.map(platformFileToAWSJson)
                        .toList(),
                    workReferences: workReferences
                        ?.map(platformFileToAWSJson)
                        .toList(),
                    introductionVideo: introductionVideo == null
                        ? null
                        : platformFileToAWSJson(introductionVideo!),
                    isPublished: true,
                    user: currentUser,
                  )
                : oldData!.copyWith(
                    updatedAt: TemporalDateTime(DateTime.now()),
                    profilePhoto: profilePhoto == null
                        ? null
                        : platformFileToAWSJson(profilePhoto!),
                    passport: passport == null
                        ? null
                        : platformFileToAWSJson(passport!),
                    medicalCertificate: medicalCertificate == null
                        ? null
                        : platformFileToAWSJson(medicalCertificate!),
                    policeClearance: policeClearance == null
                        ? null
                        : platformFileToAWSJson(policeClearance!),
                    educationalCertificates: educationalCertificates
                        ?.map(platformFileToAWSJson)
                        .toList(),
                    workReferences: workReferences
                        ?.map(platformFileToAWSJson)
                        .toList(),
                    introductionVideo: introductionVideo == null
                        ? null
                        : platformFileToAWSJson(introductionVideo!),
                    isPublished: true,
                    user: currentUser,
                  );
            context.read<BiodataBloc>().add(SaveDraftDocuments(data: data));
          }
        },
        onSave: () {
          setState(() {
            isFirstTimePressed = false;
          });
          if (checkIsEmpty()) {
            showError(
              context,
              "Documents are empty.",
            );
            return;
          }
          final data = oldData == null
              ? UploadedDocuments(
                  code: nanoid(10),
                  createdAt: TemporalDateTime(DateTime.now()),
                  profilePhoto: profilePhoto == null
                      ? null
                      : platformFileToAWSJson(profilePhoto!),
                  passport: passport == null
                      ? null
                      : platformFileToAWSJson(passport!),
                  medicalCertificate: medicalCertificate == null
                      ? null
                      : platformFileToAWSJson(medicalCertificate!),
                  policeClearance: policeClearance == null
                      ? null
                      : platformFileToAWSJson(policeClearance!),
                  educationalCertificates: educationalCertificates
                      ?.map(platformFileToAWSJson)
                      .toList(),
                  workReferences: workReferences
                      ?.map(platformFileToAWSJson)
                      .toList(),
                  introductionVideo: introductionVideo == null
                      ? null
                      : platformFileToAWSJson(introductionVideo!),
                )
              : oldData!.copyWith(
                  updatedAt: TemporalDateTime(DateTime.now()),
                  profilePhoto: profilePhoto == null
                      ? null
                      : platformFileToAWSJson(profilePhoto!),
                  passport: passport == null
                      ? null
                      : platformFileToAWSJson(passport!),
                  medicalCertificate: medicalCertificate == null
                      ? null
                      : platformFileToAWSJson(medicalCertificate!),
                  policeClearance: policeClearance == null
                      ? null
                      : platformFileToAWSJson(policeClearance!),
                  educationalCertificates: educationalCertificates
                      ?.map(platformFileToAWSJson)
                      .toList(),
                  workReferences: workReferences
                      ?.map(platformFileToAWSJson)
                      .toList(),
                  introductionVideo: introductionVideo == null
                      ? null
                      : platformFileToAWSJson(introductionVideo!),
                );
          context.read<BiodataBloc>().add(SaveDraftDocuments(data: data));

          showSuccess(context, "Draft saved successfully.");
        },
      ),
    );
  }

  bool checkValid() {
    return profilePhoto != null &&
        passport != null &&
        introductionVideo != null;
  }

  bool checkIsEmpty() {
    return !(profilePhoto != null ||
        passport != null ||
        introductionVideo != null ||
        medicalCertificate != null ||
        policeClearance != null ||
        educationalCertificates != null ||
        workReferences != null);
  }
}
