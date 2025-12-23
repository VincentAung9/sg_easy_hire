import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nanoid/non_secure.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_bloc.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_event.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_state.dart';
import 'package:sg_easy_hire/core/models/app_document.dart';
import 'package:sg_easy_hire/core/repository/storage_repository.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/features/biodata/presentation/util_fun.dart';
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
  AppDocument? profilePhoto;
  AppDocument? passport;
  AppDocument? medicalCertificate;
  AppDocument? policeClearance;
  List<AppDocument>? educationalCertificates;
  List<AppDocument>? workReferences;
  AppDocument? introductionVideo;
  UploadedDocuments? oldData;

  bool isFirstTimePressed = false;

  @override
  void initState() {
    context.read<BiodataBloc>().add(GetUploadedDocument());
    super.initState();
  }

  Future<void> _initializeFromDocuments(
    UploadedDocuments docs,
  ) async {
    isInitialized = true;
    debugPrint("🌈 Parsing......");
    final parsed = await compute(
      parseDocumentsIsolate,
      uploadedDocumentsToRaw(docs),
    );
    debugPrint("🌈 Parsed result: $parsed");
    if (!mounted) return;

    oldData = docs;
    profilePhoto = parsed['profilePhoto'] as AppDocument?;
    passport = parsed['passport'] as AppDocument?;
    medicalCertificate = parsed['medicalCertificate'] as AppDocument?;
    policeClearance = parsed['policeClearance'] as AppDocument?;
    introductionVideo = parsed['introductionVideo'] as AppDocument?;
    educationalCertificates =
        parsed['educationalCertificates'] as List<AppDocument>;
    workReferences = parsed['workReferences'] as List<AppDocument>;
    setState(() {});
  }

  @override
  void dispose() {
    context.read<BiodataBloc>().add(ResetState());
    super.dispose();
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

      body: BlocListener<BiodataBloc, BiodataState>(
        listener: (context, state) async {
          debugPrint("🔥------Listener in view ");
          if (state.action == BiodataStateAction.uploadDoc &&
              state.status == BiodataStateStatus.success &&
              !state.hasFileUploadError) {
            showSuccess(context, "Your documents has been saved");
            //context.go(RoutePaths.home);
          }

          if (state.action == BiodataStateAction.uploadDoc &&
              state.status == BiodataStateStatus.failure) {
            showError(
              context,
              "Failed to save your documents. Please try again.",
            );
          }
          if (!isInitialized && state.documents != null) {
            await _initializeFromDocuments(state.documents!);
          }
        },
        child: SafeArea(
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
                          introductionVideo = AppDocument(file: result.single);
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
                          profilePhoto = AppDocument(file: result.single);
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
                          passport = AppDocument(file: result.single);
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
                          medicalCertificate = AppDocument(file: result.single);
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
                          policeClearance = AppDocument(file: result.single);
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
                          educationalCertificates = result
                              .map((e) => AppDocument(file: e))
                              .toList();
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
                            (rec) => rec.file?.path == ec.file?.path,
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
                          workReferences = result
                              .map((e) => AppDocument(file: e))
                              .toList();
                        });
                      }
                    },
                  ),
                  ...(workReferences ?? []).map(
                    (ec) => BuildSelectFile(
                      show: workReferences?.isNotEmpty ?? false,
                      file: ec,
                      onRemove: () {
                        setState(() {
                          workReferences!.removeWhere(
                            (rec) => rec.file?.path == ec.file?.path,
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
        ),
      ),
      bottomNavigationBar:
          BlocConsumer<DocumentUploadBloc, DocumentUploadState>(
            listener: (_, state) {
              if (state.allCompleted && state.uploadedResults.isNotEmpty) {
                final data = uploadedResultsToUploadedDocuments(
                  uploadedResults: state.uploadedResults,
                  user: currentUser!,
                  oldData: oldData,
                );
                context.read<BiodataBloc>().add(
                  AddUploadDocument(data: data),
                );
              }
            },
            builder: (context, state) {
              return FormFooter(
                nextBtnString: "Submit",
                isNextLoading: state.isUploading,
                isSaveLoading: false,
                onNext: () {
                  setState(() {
                    isFirstTimePressed = true;
                  });
                  context.read<BiodataBloc>().add(
                    BroadcastFileUploadError(value: false),
                  );

                  //check valid
                  // if not valid show error
                  //if valid upload and show progress
                  if (checkValid()) {
                    debugPrint("🌈 Submit pressed.");
                    try {
                      context.read<DocumentUploadBloc>().add(
                        UploadAllDocuments(
                          folderPath: 'public/users/${currentUser?.id}',
                          tasks: [
                            if (introductionVideo?.file != null &&
                                introductionVideo?.url == null)
                              UploadTask(
                                type: DocumentType.introductionVideo,
                                file: introductionVideo!.file!,
                              ),
                            if (profilePhoto?.file != null &&
                                profilePhoto?.url == null)
                              UploadTask(
                                type: DocumentType.profilePhoto,
                                file: profilePhoto!.file!,
                              ),
                            if (passport?.file != null && passport?.url == null)
                              UploadTask(
                                type: DocumentType.passport,
                                file: passport!.file!,
                              ),
                            if (medicalCertificate?.file != null &&
                                medicalCertificate?.url == null)
                              UploadTask(
                                type: DocumentType.medicalCertificate,
                                file: medicalCertificate!.file!,
                              ),
                            if (policeClearance?.file != null &&
                                policeClearance?.url == null)
                              UploadTask(
                                type: DocumentType.policeClearance,
                                file: policeClearance!.file!,
                              ),
                            if (educationalCertificates != null)
                              ...educationalCertificates!
                                  .map(
                                    (ec) => ec.url == null
                                        ? UploadTask(
                                            type: DocumentType.policeClearance,
                                            file: ec.file!,
                                          )
                                        : null,
                                  )
                                  .whereType<UploadTask>(),
                            if (workReferences != null)
                              ...workReferences!
                                  .map(
                                    (ec) => ec.url == null
                                        ? UploadTask(
                                            type: DocumentType.policeClearance,
                                            file: ec.file!,
                                          )
                                        : null,
                                  )
                                  .whereType<UploadTask>(),
                          ],
                        ),
                      );
                    } catch (e) {
                      debugPrint("🔥 Upload error: $e .");
                    }
                  }
                },
                onSave: state.isUploading
                    ? null
                    : () {
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
                                profilePhoto: profilePhoto?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        profilePhoto!.file!,
                                        uploadedUrl: profilePhoto!.url,
                                      ),
                                passport: passport?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        passport!.file!,
                                        uploadedUrl: passport!.url,
                                      ),
                                medicalCertificate:
                                    medicalCertificate?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        medicalCertificate!.file!,
                                        uploadedUrl: medicalCertificate?.url,
                                      ),
                                policeClearance: policeClearance?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        policeClearance!.file!,
                                        uploadedUrl: policeClearance?.url,
                                      ),
                                educationalCertificates: educationalCertificates
                                    ?.map((e) => platformFileToAWSJson(e.file!))
                                    .toList(),
                                workReferences: workReferences
                                    ?.map((e) => platformFileToAWSJson(e.file!))
                                    .toList(),
                                introductionVideo:
                                    introductionVideo?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        introductionVideo!.file!,
                                      ),
                              )
                            : UploadedDocuments(
                                id: oldData?.id,
                                code: oldData?.code ?? "",
                                createdAt: TemporalDateTime(DateTime.now()),
                                updatedAt: TemporalDateTime(DateTime.now()),
                                profilePhoto: profilePhoto?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        profilePhoto!.file!,
                                      ),
                                passport: passport?.file == null
                                    ? null
                                    : platformFileToAWSJson(passport!.file!),
                                medicalCertificate:
                                    medicalCertificate?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        medicalCertificate!.file!,
                                      ),
                                policeClearance: policeClearance?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        policeClearance!.file!,
                                      ),
                                educationalCertificates: educationalCertificates
                                    ?.map((e) => platformFileToAWSJson(e.file!))
                                    .toList(),
                                workReferences: workReferences
                                    ?.map((e) => platformFileToAWSJson(e.file!))
                                    .toList(),
                                introductionVideo:
                                    introductionVideo?.file == null
                                    ? null
                                    : platformFileToAWSJson(
                                        introductionVideo!.file!,
                                      ),
                              );
                        context.read<BiodataBloc>().add(
                          SaveDraftDocuments(data: data),
                        );

                        showSuccess(context, "Draft saved successfully.");
                      },
              );
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
