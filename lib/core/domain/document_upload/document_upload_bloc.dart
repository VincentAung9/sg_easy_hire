import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_event.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_state.dart';
import 'package:sg_easy_hire/core/repository/storage_repository.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';

class DocumentUploadBloc extends Bloc<UploadAllDocuments, DocumentUploadState> {
  DocumentUploadBloc() : super(const DocumentUploadState()) {
    on<UploadAllDocuments>(_uploadSequentially);
  }

  Future<void> _uploadSequentially(
    UploadAllDocuments event,
    Emitter<DocumentUploadState> emit,
  ) async {
    debugPrint("🌈 Uploading.........");
    emit(state.copyWith(isUploading: true));

    final progressMap = Map<String, double>.from(state.progressMap);
    final errorMap = Map<String, String>.from(state.errorMap);
    final results = Map<DocumentType, dynamic>.from(state.uploadedResults);

    for (final task in event.tasks) {
      final key = fileKey(task.file);

      final url = await StorageRepository.uploadFile(
        task.file,
        event.folderPath,
        (p) {
          debugPrint("🌈 Progress: $p.........");
          progressMap[key] = p;
          emit(state.copyWith(progressMap: Map.from(progressMap)));
        },
        (e) {
          errorMap[key] = e ?? "";
          emit(state.copyWith(errorMap: Map.from(errorMap)));
        },
      );

      progressMap[key] = 1.0;

      results[task.type] = platformFileToAWSJson(
        task.file,
        uploadedUrl: url,
      );

      emit(
        state.copyWith(
          progressMap: Map.from(progressMap),
          uploadedResults: Map.from(results),
          errorMap: Map.from(errorMap),
        ),
      );
    }

    emit(
      state.copyWith(
        isUploading: false,
        allCompleted: true,
      ),
    );
  }
}
