import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class StorageRepository {
  static Future<List<PlatformFile>?> pickFile({
    List<String>? allowedExtensions = const ["pdf", "jpg", "png"],
    bool allowMultiple = false,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: FileType.custom,
      withData: false,
      withReadStream: true,
      allowedExtensions: allowedExtensions,
    );

    if (result == null) {
      safePrint('No file selected');
      return null;
    }
    return result.files;
  }

  static Future<String?> uploadFile(
    PlatformFile platformFile,
    String folderPath,
    void Function(double v)? onProgress,
    void Function(String? v)? onError,
  ) async {
    try {
      const bucket = 'media42907-deveasy';
      const region = 'ap-southeast-1';
      final result = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromStream(
          platformFile.readStream!,
          size: platformFile.size,
        ),
        path: StoragePath.fromString('${folderPath}/${platformFile.name}'),
        onProgress: (progress) {
          if (!(onProgress == null)) {
            onProgress(progress.fractionCompleted);
          }
        },
      ).result;

      final uploadedPath = result.uploadedItem.path;
      safePrint("✅ Upload successful: $uploadedPath");

      // 3. CONSTRUCT URL
      // Since you removed the '+', this URL is now safe for Image.network
      final publicUrl =
          'https://$bucket.s3.$region.amazonaws.com/$uploadedPath';
      return publicUrl;
    } catch (e) {
      debugPrint("🔥 Upload File Storage Error: $e");
      if (!(onError == null)) {
        onError("$e");
      }
      return null;
    }
  }
}
