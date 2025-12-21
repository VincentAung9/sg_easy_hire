import 'package:sg_easy_hire/models/ModelProvider.dart';

class BiodataEvent {}

class AddPersonalInformation extends BiodataEvent {
  final PersonalInformation data;
  AddPersonalInformation({required this.data});
}

class GetPersonalInformation extends BiodataEvent {}

class AddContactFamilyInfo extends BiodataEvent {
  final ContactFamilyDetails data;
  AddContactFamilyInfo({required this.data});
}

class GetContactFamilyInfo extends BiodataEvent {}

class AddMedicalHistory extends BiodataEvent {
  final MedicalHistory data;
  AddMedicalHistory({required this.data});
}

class GetMedicalHistory extends BiodataEvent {}

class AddOtherPersonalInfo extends BiodataEvent {
  final OtherPersonalInfo data;
  AddOtherPersonalInfo({required this.data});
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

class GetJobPreference extends BiodataEvent {}

class AddUploadDocument extends BiodataEvent {
  final UploadedDocuments data;
  AddUploadDocument({required this.data});
}

class GetUploadedDocument extends BiodataEvent {}
