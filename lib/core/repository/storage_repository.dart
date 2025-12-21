import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';

class StorageService {
  static Future<String?> uploadFile(
    PlatformFile platformFile,
    String folderPath,
  ) async {
    try {
      const bucket = 'media68a36-dev';
      const region = 'ap-southeast-1';
      final result = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromStream(
          platformFile.readStream!,
          size: platformFile.size,
        ),
        path: StoragePath.fromString('${folderPath}/${platformFile.name}'),
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
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
      return null;
    }
  }
}
