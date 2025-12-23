import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
part 'biodata_state.freezed.dart';

enum BiodataStateAction {
  personalInfo,
  contactFam,
  medicalHis,
  foodAccom,
  otherPersonalInfo,
  jobPrefer,
  uploadDoc,
  saveDoc,
  none,
}

enum BiodataStateStatus {
  saveDraftLoading,
  loading,
  success,
  saveDraftSuccess,
  failure,
  saveDraftFailure,
  none,
}

@freezed
class BiodataState with _$BiodataState {
  factory BiodataState({
    @Default(BiodataStateAction.none) BiodataStateAction action,
    @Default(BiodataStateStatus.none) BiodataStateStatus status,
    PersonalInformation? personalInformation,
    ContactFamilyDetails? contactFamilyDetails,
    MedicalHistory? medicalHistory,
    OtherPersonalInfo? otherInfo,
    JobPreferences? jobPreference,
    @Default([]) List<WorkHistory> workHistories,
    UploadedDocuments? documents,
    @Default(false) bool hasFileUploadError,
  }) = _BiodataState;
}
