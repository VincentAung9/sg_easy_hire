import 'package:file_picker/file_picker.dart';

enum DocumentType {
  profilePhoto,
  passport,
  medicalCertificate,
  policeClearance,
  educationalCertificates,
  workReferences,
  introductionVideo,
}

class UploadTask {
  final DocumentType type;
  final PlatformFile file;

  UploadTask({
    required this.type,
    required this.file,
  });
}

class DocumentUploadState {
  final Map<String, double> progressMap; // fileKey -> progress
  final Map<DocumentType, String> uploadedResults;
  final Map<String, String> errorMap;
  final bool isUploading;
  final bool allCompleted;

  const DocumentUploadState({
    this.progressMap = const {},
    this.errorMap = const {},
    this.uploadedResults = const {},
    this.isUploading = false,
    this.allCompleted = false,
  });

  bool get canSubmit => allCompleted && !isUploading;

  DocumentUploadState copyWith({
    Map<String, double>? progressMap,
    Map<String, String>? errorMap,
    Map<DocumentType, String>? uploadedResults,
    bool? isUploading,
    bool? allCompleted,
  }) {
    return DocumentUploadState(
      progressMap: progressMap ?? this.progressMap,
      uploadedResults: uploadedResults ?? this.uploadedResults,
      isUploading: isUploading ?? this.isUploading,
      allCompleted: allCompleted ?? this.allCompleted,
      errorMap: errorMap ?? this.errorMap,
    );
  }
}
