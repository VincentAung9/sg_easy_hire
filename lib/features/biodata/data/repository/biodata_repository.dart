import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class BiodataRepository {
  Future<PersonalInformation?> getPersonalInfo(String userID) async {
    final request = ModelQueries.list(
      PersonalInformation.classType,
      where: PersonalInformation.USER.eq(userID),
    );
    final response = await Amplify.API.query(request: request).response;
    final result = response.data?.items ?? [];
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<GraphQLResponse<PersonalInformation>> addPersonalinfo(
    PersonalInformation info,
  ) async {
    final request = ModelMutations.create(info);
    final mutation = await Amplify.API.mutate(request: request).response;
    return mutation;
  }

  Future<GraphQLResponse<PersonalInformation>> updatePersonalinfo(
    PersonalInformation info,
  ) async {
    final request = ModelMutations.update(info);
    final mutation = await Amplify.API.mutate(request: request).response;
    return mutation;
  }

  Future<ContactFamilyDetails?> getContactFamily(String userID) async {
    final request = ModelQueries.list(
      ContactFamilyDetails.classType,
      where: ContactFamilyDetails.USER.eq(userID),
    );
    final response = await Amplify.API.query(request: request).response;
    final result = response.data?.items ?? [];

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addContactFamily(ContactFamilyDetails info) async {
    final request = ModelMutations.create(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<void> updateContactFamily(ContactFamilyDetails info) async {
    final request = ModelMutations.update(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<MedicalHistory?> getMedicalHistory(String userID) async {
    final request = ModelQueries.list(
      MedicalHistory.classType,
      where: MedicalHistory.USER.eq(userID),
    );
    final response = await Amplify.API.query(request: request).response;
    final result = response.data?.items ?? [];

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addMedicalHistory(MedicalHistory info) async {
    final request = ModelMutations.create(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<void> updateMedicalHistory(MedicalHistory info) async {
    final request = ModelMutations.update(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<OtherPersonalInfo?> getOtherPersonalInfo(String userID) async {
    final request = ModelQueries.list(
      OtherPersonalInfo.classType,
      where: OtherPersonalInfo.USER.eq(userID),
    );
    final response = await Amplify.API.query(request: request).response;
    final result = response.data?.items ?? [];

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<WorkHistory>> getWorkHistories(String userID) async {
    final request = ModelQueries.list(
      WorkHistory.classType,
      where: WorkHistory.HELPER.eq(userID),
    );
    final response = await Amplify.API.query(request: request).response;
    final result = response.data?.items ?? [];

    if (result.isNotEmpty) {
      return result.whereType<WorkHistory>().toList();
    } else {
      return [];
    }
  }

  Future<void> addOtherPersonalInfo(OtherPersonalInfo info) async {
    final request = ModelMutations.create(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<void> updateOtherPersonalInfo(OtherPersonalInfo info) async {
    final request = ModelMutations.update(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<void> removeWorkHistory(List<WorkHistory> histories) async {
    await Future.wait(
      histories.map((h) async {
        final request = ModelMutations.delete(h);
        await Amplify.API.mutate(request: request).response;
      }),
    );
  }

  Future<void> addWorkHistories(List<WorkHistory> histories) async {
    await Future.wait(
      histories.map((h) async {
        final request = ModelMutations.create(h);
        await Amplify.API.mutate(request: request).response;
      }),
    );
  }

  Future<JobPreferences?> getJobPreferences(String userID) async {
    final request = ModelQueries.list(
      JobPreferences.classType,
      where: JobPreferences.USER.eq(userID),
    );
    final response = await Amplify.API.query(request: request).response;
    final result = response.data?.items ?? [];

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addJobPreferences(JobPreferences info) async {
    final request = ModelMutations.create(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<void> updateJobPreferences(JobPreferences info) async {
    final request = ModelMutations.update(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<UploadedDocuments?> getUploadedDocuments(String userID) async {
    final request = ModelQueries.list(
      UploadedDocuments.classType,
      where: UploadedDocuments.USER.eq(userID),
    );
    final response = await Amplify.API.query(request: request).response;
    final result = response.data?.items ?? [];

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> addUploadedDocuments(UploadedDocuments info) async {
    final request = ModelMutations.create(info);
    await Amplify.API.mutate(request: request).response;
  }

  Future<void> updateUploadedDocuments(UploadedDocuments info) async {
    final request = ModelMutations.update(info);
    await Amplify.API.mutate(request: request).response;
  }
}
