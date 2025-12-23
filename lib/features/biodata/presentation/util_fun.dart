import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:sg_easy_hire/core/models/app_document.dart';
import 'package:sg_easy_hire/models/UploadedDocuments.dart';

Map<String, dynamic> parseDocumentsIsolate(
  Map<String, dynamic> raw,
) {
  AppDocument? parseOne(String? awsJson) {
    if (awsJson == null) return null;

    final json = jsonDecode(awsJson) as Map<String, dynamic>;
    return AppDocument(
      url: json['url'] as String?,
      file: PlatformFile(
        name: json['name'] as String,
        size: json['size'] as int,
        path: json['path'] as String?,
      ),
    );
  }

  List<AppDocument> parseList(List<String>? list) {
    if (list == null) return [];
    return list.map(parseOne).whereType<AppDocument>().toList();
  }

  return {
    'profilePhoto': parseOne(raw['profilePhoto'] as String?),
    'passport': parseOne(raw['passport'] as String?),
    'medicalCertificate': parseOne(raw['medicalCertificate'] as String?),
    'policeClearance': parseOne(raw['policeClearance'] as String?),
    'introductionVideo': parseOne(raw['introductionVideo'] as String?),
    'educationalCertificates': parseList(
      raw['educationalCertificates'] as List<String>?,
    ),
    'workReferences': parseList(
      raw['workReferences'] as List<String>?,
    ),
  };
}

Map<String, dynamic> uploadedDocumentsToRaw(
  UploadedDocuments docs,
) {
  return {
    'profilePhoto': docs.profilePhoto,
    'passport': docs.passport,
    'medicalCertificate': docs.medicalCertificate,
    'policeClearance': docs.policeClearance,
    'introductionVideo': docs.introductionVideo,
    'educationalCertificates': docs.educationalCertificates,
    'workReferences': docs.workReferences,
  };
}
