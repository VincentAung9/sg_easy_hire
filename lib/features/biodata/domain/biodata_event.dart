import 'package:sg_easy_hire/models/ModelProvider.dart';

class BiodataEvent {}

class ResetState extends BiodataEvent {}

class BroadcastFileUploadError extends BiodataEvent {
  final bool value;
  BroadcastFileUploadError({required this.value});
}

class AddPersonalInformation extends BiodataEvent {
  final PersonalInformation data;
  AddPersonalInformation({required this.data});
}

class UpdatePersonalInformation extends BiodataEvent {
  final PersonalInformation data;
  UpdatePersonalInformation({required this.data});
}

class SaveDraftPersonalInformation extends BiodataEvent {
  final PersonalInformation data;
  SaveDraftPersonalInformation({required this.data});
}

class GetPersonalInformation extends BiodataEvent {}

class AddContactFamilyInfo extends BiodataEvent {
  final ContactFamilyDetails data;
  AddContactFamilyInfo({required this.data});
}

class UpdateContactFamilyInfo extends BiodataEvent {
  final ContactFamilyDetails data;
  UpdateContactFamilyInfo({required this.data});
}

class SaveDraftContactFamilyInfo extends BiodataEvent {
  final ContactFamilyDetails data;
  SaveDraftContactFamilyInfo({required this.data});
}

class GetContactFamilyInfo extends BiodataEvent {}

class AddMedicalHistory extends BiodataEvent {
  final MedicalHistory data;
  AddMedicalHistory({required this.data});
}

class UpdateMedicalHistory extends BiodataEvent {
  final MedicalHistory data;
  UpdateMedicalHistory({required this.data});
}

class SaveDraftMedicalHistory extends BiodataEvent {
  final MedicalHistory data;
  SaveDraftMedicalHistory({required this.data});
}

class GetMedicalHistory extends BiodataEvent {}

class AddOtherPersonalInfo extends BiodataEvent {
  final OtherPersonalInfo data;
  AddOtherPersonalInfo({required this.data});
}

class UpdateOtherPersonalInfo extends BiodataEvent {
  final OtherPersonalInfo data;
  UpdateOtherPersonalInfo({required this.data});
}

class SaveDraftOtherPersonalInfo extends BiodataEvent {
  final OtherPersonalInfo data;
  SaveDraftOtherPersonalInfo({required this.data});
}

class GetOtherPersonalInfo extends BiodataEvent {}

class AddJobPreference extends BiodataEvent {
  final JobPreferences data;
  final List<WorkHistory> workHistories;
  AddJobPreference({
    required this.data,
    required this.workHistories,
  });
}

class UpdateJobPreference extends BiodataEvent {
  final JobPreferences data;
  final List<WorkHistory> workHistories;
  UpdateJobPreference({
    required this.data,
    required this.workHistories,
  });
}

class SaveDraftJobPreference extends BiodataEvent {
  final JobPreferences data;
  final List<WorkHistory> workHistories;
  SaveDraftJobPreference({
    required this.data,
    required this.workHistories,
  });
}

class GetJobPreference extends BiodataEvent {}

class AddUploadDocument extends BiodataEvent {
  final UploadedDocuments data;
  AddUploadDocument({required this.data});
}

class UpdateUploadDocument extends BiodataEvent {
  final UploadedDocuments data;
  UpdateUploadDocument({required this.data});
}

class SaveDraftDocuments extends BiodataEvent {
  final UploadedDocuments data;
  SaveDraftDocuments({required this.data});
}

class GetUploadedDocument extends BiodataEvent {}
