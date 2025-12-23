import 'package:sg_easy_hire/core/domain/document_upload/document_upload_state.dart';

class UploadAllDocuments {
  final List<UploadTask> tasks;
  final String folderPath;

  UploadAllDocuments({
    required this.tasks,
    required this.folderPath,
  });
}
