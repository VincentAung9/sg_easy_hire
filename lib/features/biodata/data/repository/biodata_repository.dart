import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sg_easy_hire/models/ContactFamilyDetails.dart';
import 'package:sg_easy_hire/models/JobPreferences.dart';
import 'package:sg_easy_hire/models/MedicalHistory.dart';
import 'package:sg_easy_hire/models/OtherPersonalInfo.dart';
import 'package:sg_easy_hire/models/PersonalInformation.dart';
import 'package:sg_easy_hire/models/UploadedDocuments.dart';

class BiodataRepository {
  Future<PersonalInformation?> getPersonalInfo(String userID) async {
    final result = await Amplify.DataStore.query(
      PersonalInformation.classType,
      where: PersonalInformation.USER.eq(userID),
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addPersonalinfo(PersonalInformation info) async {
    return Amplify.DataStore.save(info);
  }

  Future<ContactFamilyDetails?> getContactFamily(String userID) async {
    final result = await Amplify.DataStore.query(
      ContactFamilyDetails.classType,
      where: ContactFamilyDetails.USER.eq(userID),
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addContactFamily(ContactFamilyDetails info) async {
    return Amplify.DataStore.save(info);
  }

  Future<MedicalHistory?> getMedicalHistory(String userID) async {
    final result = await Amplify.DataStore.query(
      MedicalHistory.classType,
      where: MedicalHistory.USER.eq(userID),
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addMedicalHistory(MedicalHistory info) async {
    return Amplify.DataStore.save(info);
  }

  Future<OtherPersonalInfo?> getOtherPersonalInfo(String userID) async {
    final result = await Amplify.DataStore.query(
      OtherPersonalInfo.classType,
      where: OtherPersonalInfo.USER.eq(userID),
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addOtherPersonalInfo(OtherPersonalInfo info) async {
    return Amplify.DataStore.save(info);
  }

  Future<JobPreferences?> getJobPreferences(String userID) async {
    final result = await Amplify.DataStore.query(
      JobPreferences.classType,
      where: JobPreferences.USER.eq(userID),
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addJobPreferences(JobPreferences info) async {
    return Amplify.DataStore.save(info);
  }

  Future<UploadedDocuments?> getUploadedDocuments(String userID) async {
    final result = await Amplify.DataStore.query(
      UploadedDocuments.classType,
      where: UploadedDocuments.USER.eq(userID),
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addUploadedDocuments(UploadedDocuments info) async {
    return Amplify.DataStore.save(info);
  }
}
