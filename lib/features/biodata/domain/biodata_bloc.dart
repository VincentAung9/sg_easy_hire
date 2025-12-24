import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/auth_repository.dart';
import 'package:sg_easy_hire/features/biodata/data/repository/biodata_repository.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:sg_easy_hire/models/UploadedDocuments.dart';
import 'package:sg_easy_hire/models/User.dart';
import 'package:sg_easy_hire/models/WorkHistory.dart';

class WorkHistoryDiff {
  final List<WorkHistory> added;
  final List<WorkHistory> removed;

  WorkHistoryDiff({
    required this.added,
    required this.removed,
  });
}

class BiodataBloc extends Bloc<BiodataEvent, BiodataState> {
  Box<User> box = Hive.box<User>(name: userBox);
  final BiodataRepository repository;
  final AuthRepository authRepository;
  BiodataBloc({required this.repository, required this.authRepository})
    : super(BiodataState()) {
    on<ResetState>(_onResetState);
    on<GetPersonalInformation>(_onGetPersonalInfo);
    on<AddPersonalInformation>(_onAddPersonalInfo);
    on<UpdatePersonalInformation>(_onUpdatePersonalInformation);
    on<SaveDraftPersonalInformation>(_onSaveDraftPersonalInformation);
    on<GetContactFamilyInfo>(_onGetContactFamily);
    on<AddContactFamilyInfo>(_onAddContactFamily);
    on<UpdateContactFamilyInfo>(_onUpdateContactFamily);
    on<SaveDraftContactFamilyInfo>(_onSaveDraftContactFamily);
    on<GetMedicalHistory>(_onGetMedicalHistory);
    on<AddMedicalHistory>(_onAddMedicalHistory);
    on<UpdateMedicalHistory>(_onUpdateMedicalHistory);
    on<SaveDraftMedicalHistory>(_onSaveDraftMedicalHistory);
    on<GetOtherPersonalInfo>(_onGetOtherPersonalInfo);
    on<AddOtherPersonalInfo>(_onAddOtherPersonalInfo);
    on<UpdateOtherPersonalInfo>(_onUpdateOtherPersonalInfo);
    on<SaveDraftOtherPersonalInfo>(_onSaveDraftOtherPersonalInfo);
    on<GetJobPreference>(_onGetJobPreference);
    on<AddJobPreference>(_onAddJobPreference);
    on<UpdateJobPreference>(_onUpdateJobPreference);
    on<SaveDraftJobPreference>(_onSaveDraftJobPreference);
    on<GetUploadedDocument>(_onGetUploadedDocument);
    on<AddUploadDocument>(_onAddUploadedDocument);
    on<UpdateUploadDocument>(_onUpdateUploadedDocument);
    on<SaveDraftDocuments>(_onSaveDraftDocuments);
    on<BroadcastFileUploadError>(_onFileUploadError);
  }

  FutureOr<void> _onGetPersonalInfo(
    GetPersonalInformation event,
    Emitter<BiodataState> emit,
  ) async {
    final hiveUser = box.get(userBoxKey);
    emit(
      state.copyWith(
        action: BiodataStateAction.personalInfo,
        status: BiodataStateStatus.loading,
      ),
    );
    PersonalInformation? result;
    final pbox = Hive.box<PersonalInformation>(name: personalInformationBox);
    final hasValue = pbox.get(personalInformationKey);
    if (hasValue == null) {
      result = await repository.getPersonalInfo(hiveUser?.id ?? "");
    } else {
      result = hasValue;
    }
    emit(
      state.copyWith(
        personalInformation: result,
        action: BiodataStateAction.personalInfo,
        status: BiodataStateStatus.none,
      ),
    );
  }

  FutureOr<void> _onAddPersonalInfo(
    AddPersonalInformation event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.personalInfo,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      debugPrint("🌈 Personal Info Mutation start id: ${event.data.id}.......");
      final mutation = await repository.addPersonalinfo(event.data);
      if (mutation.hasErrors) {
        emit(
          state.copyWith(
            personalInformation: null,
            action: BiodataStateAction.personalInfo,
            status: BiodataStateStatus.failure,
          ),
        );
        return;
      }
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          personalInformation: event.data,
        ),
      );
      Hive.box<PersonalInformation>(
        name: personalInformationBox,
      ).delete(personalInformationKey);
      debugPrint("🌈 Personal Info Mutation done.......");
      emit(
        state.copyWith(
          personalInformation: event.data,
          action: BiodataStateAction.personalInfo,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          personalInformation: null,
          action: BiodataStateAction.personalInfo,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onGetContactFamily(
    GetContactFamilyInfo event,
    Emitter<BiodataState> emit,
  ) async {
    final hiveUser = box.get(userBoxKey);
    emit(
      state.copyWith(
        action: BiodataStateAction.contactFam,
        status: BiodataStateStatus.loading,
      ),
    );
    ContactFamilyDetails? result;
    final pbox = Hive.box<ContactFamilyDetails>(name: contactFamilyBox);
    final hasValue = pbox.get(contactFamilyKey);
    if (hasValue == null) {
      result = await repository.getContactFamily(hiveUser?.id ?? "");
    } else {
      result = hasValue;
    }
    emit(
      state.copyWith(
        contactFamilyDetails: result,
        action: BiodataStateAction.contactFam,
        status: BiodataStateStatus.none,
      ),
    );
  }

  FutureOr<void> _onAddContactFamily(
    AddContactFamilyInfo event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.contactFam,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.addContactFamily(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          contactFamilyDetails: event.data,
        ),
      );
      Hive.box<ContactFamilyDetails>(
        name: contactFamilyBox,
      ).delete(contactFamilyKey);
      emit(
        state.copyWith(
          contactFamilyDetails: event.data,
          action: BiodataStateAction.contactFam,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          contactFamilyDetails: null,
          action: BiodataStateAction.contactFam,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onGetMedicalHistory(
    GetMedicalHistory event,
    Emitter<BiodataState> emit,
  ) async {
    final hiveUser = box.get(userBoxKey);
    emit(
      state.copyWith(
        action: BiodataStateAction.medicalHis,
        status: BiodataStateStatus.loading,
      ),
    );
    MedicalHistory? result;
    final mbox = Hive.box<MedicalHistory>(name: medicalHistoryBox);
    final haveValue = mbox.get(medicalHistoryKey);
    if (haveValue == null) {
      result = await repository.getMedicalHistory(hiveUser?.id ?? "");
    } else {
      result = haveValue;
    }

    emit(
      state.copyWith(
        medicalHistory: result,
        action: BiodataStateAction.medicalHis,
        status: BiodataStateStatus.none,
      ),
    );
  }

  FutureOr<void> _onAddMedicalHistory(
    AddMedicalHistory event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.medicalHis,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.addMedicalHistory(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          medicalHistory: event.data,
        ),
      );
      Hive.box<MedicalHistory>(
        name: medicalHistoryBox,
      ).delete(medicalHistoryKey);
      emit(
        state.copyWith(
          medicalHistory: event.data,
          action: BiodataStateAction.medicalHis,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          medicalHistory: null,
          action: BiodataStateAction.medicalHis,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onGetOtherPersonalInfo(
    GetOtherPersonalInfo event,
    Emitter<BiodataState> emit,
  ) async {
    final hiveUser = box.get(userBoxKey);
    emit(
      state.copyWith(
        action: BiodataStateAction.otherPersonalInfo,
        status: BiodataStateStatus.loading,
      ),
    );
    OtherPersonalInfo? result;
    final mbox = Hive.box<OtherPersonalInfo>(name: otherPersonalInfoBox);
    final haveValue = mbox.get(otherPersonalInfoKey);
    if (haveValue == null) {
      result = await repository.getOtherPersonalInfo(hiveUser?.id ?? "");
    } else {
      result = haveValue;
    }
    emit(
      state.copyWith(
        otherInfo: result,
        action: BiodataStateAction.otherPersonalInfo,
        status: BiodataStateStatus.none,
      ),
    );
  }

  FutureOr<void> _onAddOtherPersonalInfo(
    AddOtherPersonalInfo event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.otherPersonalInfo,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.addOtherPersonalInfo(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          otherPersonalInfo: event.data,
        ),
      );
      Hive.box<OtherPersonalInfo>(
        name: otherPersonalInfoBox,
      ).delete(otherPersonalInfoKey);
      emit(
        state.copyWith(
          otherInfo: event.data,
          action: BiodataStateAction.otherPersonalInfo,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          otherInfo: null,
          action: BiodataStateAction.otherPersonalInfo,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onGetJobPreference(
    GetJobPreference event,
    Emitter<BiodataState> emit,
  ) async {
    final hiveUser = box.get(userBoxKey);
    emit(
      state.copyWith(
        action: BiodataStateAction.jobPrefer,
        status: BiodataStateStatus.loading,
      ),
    );
    /*  final result = await repository.getJobPreferences(hiveUser?.id ?? "");
    final workHistories = await repository.getWorkHistories(hiveUser?.id ?? ""); */
    JobPreferences? result;
    final mbox = Hive.box<JobPreferences>(name: jobPreferenceBox);
    final haveValue = mbox.get(jobPreferenceKey);
    if (haveValue == null) {
      result = await repository.getJobPreferences(hiveUser?.id ?? "");
    } else {
      result = haveValue;
    }

    var workHistories = <WorkHistory>[];
    final whbox = Hive.box<List<WorkHistory>>(name: workHistoriesBox);
    final haveValueWH = whbox.get(workHistoriesKey);
    if (haveValueWH == null) {
      workHistories = await repository.getWorkHistories(hiveUser?.id ?? "");
    } else {
      workHistories = haveValueWH;
    }
    emit(
      state.copyWith(
        jobPreference: result,
        workHistories: workHistories,
        action: BiodataStateAction.jobPrefer,
        status: BiodataStateStatus.none,
      ),
    );
  }

  FutureOr<void> _onAddJobPreference(
    AddJobPreference event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.jobPrefer,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.addJobPreferences(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          jobPreferences: event.data,
        ),
      );

      if (event.workHistories.isNotEmpty) {
        //add workHistory
        if (state.workHistories.isNotEmpty) {
          //need to check remove or add
          final previous = state.workHistories;
          final current = event.workHistories;

          final diff = diffWorkHistories(
            oldList: previous,
            newList: current,
          );

          // 1. Remove deleted items
          if (diff.removed.isNotEmpty) {
            await repository.removeWorkHistory(diff.removed);
          }

          // 2. Add new items
          if (diff.added.isNotEmpty) {
            await repository.addWorkHistories(diff.added);
          }
        } else {
          await repository.addWorkHistories(event.workHistories);
        }
      }
      Hive.box<JobPreferences>(
        name: jobPreferenceBox,
      ).delete(jobPreferenceKey);
      Hive.box<List<WorkHistory>>(
        name: workHistoriesBox,
      ).delete(workHistoriesKey);
      emit(
        state.copyWith(
          jobPreference: event.data,
          action: BiodataStateAction.jobPrefer,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          jobPreference: null,
          action: BiodataStateAction.jobPrefer,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onGetUploadedDocument(
    GetUploadedDocument event,
    Emitter<BiodataState> emit,
  ) async {
    final hiveUser = box.get(userBoxKey);
    emit(
      state.copyWith(
        action: BiodataStateAction.uploadDoc,
        status: BiodataStateStatus.loading,
      ),
    );
    final hiveDraft = Hive.box<UploadedDocuments>(
      name: helperPersonalDocuments,
    ).get(helperPersonalDocumentsKey);
    final result = await repository.getUploadedDocuments(hiveUser?.id ?? "");
    printFull(
      "🌈 Hive Document Draft: $hiveDraft......\n🌈Document Remote: ${result?.toJson()}",
    );
    emit(
      state.copyWith(
        documents: hiveDraft ?? result,
        action: BiodataStateAction.uploadDoc,
        status: BiodataStateStatus.none,
      ),
    );
  }

  FutureOr<void> _onAddUploadedDocument(
    AddUploadDocument event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.uploadDoc,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.addUploadedDocuments(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          avatarURL: event.data.profilePhoto == null
              ? null
              // ignore: avoid_dynamic_calls
              : jsonDecode(event.data.profilePhoto!)["url"] as String,
          uploadedDocuments: event.data,
        ),
      );
      //need to clear previous draft if exist
      Hive.box<UploadedDocuments>(
        name: helperPersonalDocuments,
      ).delete(helperPersonalDocumentsKey);
      emit(
        state.copyWith(
          documents: event.data,
          action: BiodataStateAction.uploadDoc,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          documents: null,
          action: BiodataStateAction.uploadDoc,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  WorkHistoryDiff diffWorkHistories({
    required List<WorkHistory> oldList,
    required List<WorkHistory> newList,
  }) {
    final oldMap = {for (var e in oldList) e.id: e};
    final newMap = {for (var e in newList) e.id: e};

    final added = <WorkHistory>[];
    final removed = <WorkHistory>[];

    for (final id in newMap.keys) {
      if (!oldMap.containsKey(id)) {
        added.add(newMap[id]!);
      }
    }

    for (final id in oldMap.keys) {
      if (!newMap.containsKey(id)) {
        removed.add(oldMap[id]!);
      }
    }

    return WorkHistoryDiff(
      added: added,
      removed: removed,
    );
  }

  FutureOr<void> _onSaveDraftDocuments(
    SaveDraftDocuments event,
    Emitter<BiodataState> emit,
  ) {
    emit(
      state.copyWith(
        documents: event.data,
        action: BiodataStateAction.saveDoc,
        status: BiodataStateStatus.saveDraftLoading,
      ),
    );
    Hive.box<UploadedDocuments>(
      name: helperPersonalDocuments,
    ).put(helperPersonalDocumentsKey, event.data);
    emit(
      state.copyWith(
        documents: event.data,
        action: BiodataStateAction.saveDoc,
        status: BiodataStateStatus.saveDraftSuccess,
      ),
    );
  }

  FutureOr<void> _onUpdatePersonalInformation(
    UpdatePersonalInformation event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.personalInfo,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      debugPrint("🌈 Personal Info Mutation start id: ${event.data.id}.......");
      final mutation = await repository.updatePersonalinfo(event.data);
      debugPrint("🌈 Response: ${mutation}.......");
      if (mutation.hasErrors) {
        emit(
          state.copyWith(
            personalInformation: null,
            action: BiodataStateAction.personalInfo,
            status: BiodataStateStatus.failure,
          ),
        );
        return;
      }
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          personalInformation: event.data,
        ),
      );
      Hive.box<PersonalInformation>(
        name: personalInformationBox,
      ).delete(personalInformationKey);
      debugPrint("🌈 Personal Info Mutation done.......");
      emit(
        state.copyWith(
          personalInformation: event.data,
          action: BiodataStateAction.personalInfo,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          personalInformation: null,
          action: BiodataStateAction.personalInfo,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateContactFamily(
    UpdateContactFamilyInfo event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.contactFam,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.updateContactFamily(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          contactFamilyDetails: event.data,
        ),
      );
      Hive.box<ContactFamilyDetails>(
        name: contactFamilyBox,
      ).delete(contactFamilyKey);
      emit(
        state.copyWith(
          contactFamilyDetails: event.data,
          action: BiodataStateAction.contactFam,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          contactFamilyDetails: null,
          action: BiodataStateAction.contactFam,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateMedicalHistory(
    UpdateMedicalHistory event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.medicalHis,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.updateMedicalHistory(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          medicalHistory: event.data,
        ),
      );
      Hive.box<MedicalHistory>(
        name: medicalHistoryBox,
      ).delete(medicalHistoryKey);
      emit(
        state.copyWith(
          medicalHistory: event.data,
          action: BiodataStateAction.medicalHis,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          medicalHistory: null,
          action: BiodataStateAction.medicalHis,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateOtherPersonalInfo(
    UpdateOtherPersonalInfo event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.otherPersonalInfo,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.updateOtherPersonalInfo(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          otherPersonalInfo: event.data,
        ),
      );
      Hive.box<OtherPersonalInfo>(
        name: otherPersonalInfoBox,
      ).delete(otherPersonalInfoKey);
      emit(
        state.copyWith(
          otherInfo: event.data,
          action: BiodataStateAction.otherPersonalInfo,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          otherInfo: null,
          action: BiodataStateAction.otherPersonalInfo,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateJobPreference(
    UpdateJobPreference event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.jobPrefer,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.updateJobPreferences(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          jobPreferences: event.data,
        ),
      );
      if (event.workHistories.isNotEmpty) {
        //add workHistory
        if (state.workHistories.isNotEmpty) {
          //need to check remove or add
          final previous = state.workHistories;
          final current = event.workHistories;

          final diff = diffWorkHistories(
            oldList: previous,
            newList: current,
          );

          // 1. Remove deleted items
          if (diff.removed.isNotEmpty) {
            await repository.removeWorkHistory(diff.removed);
          }

          // 2. Add new items
          if (diff.added.isNotEmpty) {
            await repository.addWorkHistories(diff.added);
          }
        } else {
          await repository.addWorkHistories(event.workHistories);
        }
      }
      Hive.box<JobPreferences>(
        name: jobPreferenceBox,
      ).delete(jobPreferenceKey);
      Hive.box<List<WorkHistory>>(
        name: workHistoriesBox,
      ).delete(workHistoriesKey);
      emit(
        state.copyWith(
          jobPreference: event.data,
          action: BiodataStateAction.jobPrefer,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          jobPreference: null,
          action: BiodataStateAction.jobPrefer,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateUploadedDocument(
    UpdateUploadDocument event,
    Emitter<BiodataState> emit,
  ) async {
    emit(
      state.copyWith(
        action: BiodataStateAction.uploadDoc,
        status: BiodataStateStatus.loading,
      ),
    );
    try {
      await repository.updateUploadedDocuments(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          uploadedDocuments: event.data,
          // ignore: avoid_dynamic_calls
          avatarURL: event.data.profilePhoto == null
              ? null
              : jsonDecode(event.data.profilePhoto!)["url"] as String,
        ),
      );
      //need to clear previous draft if exist
      Hive.box<UploadedDocuments>(
        name: helperPersonalDocuments,
      ).delete(helperPersonalDocumentsKey);
      emit(
        state.copyWith(
          documents: event.data,
          action: BiodataStateAction.uploadDoc,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          documents: null,
          action: BiodataStateAction.uploadDoc,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onSaveDraftPersonalInformation(
    SaveDraftPersonalInformation event,
    Emitter<BiodataState> emit,
  ) {
    emit(
      state.copyWith(
        action: BiodataStateAction.personalInfo,
        status: BiodataStateStatus.saveDraftLoading,
      ),
    );
    try {
      Hive.box<PersonalInformation>(
        name: personalInformationBox,
      ).put(personalInformationKey, event.data);
      debugPrint("🌈 Personal Info Mutation done.......");
      emit(
        state.copyWith(
          personalInformation: event.data,
          action: BiodataStateAction.personalInfo,
          status: BiodataStateStatus.saveDraftSuccess,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          personalInformation: null,
          action: BiodataStateAction.personalInfo,
          status: BiodataStateStatus.saveDraftFailure,
        ),
      );
    }
  }

  FutureOr<void> _onSaveDraftContactFamily(
    SaveDraftContactFamilyInfo event,
    Emitter<BiodataState> emit,
  ) {
    emit(
      state.copyWith(
        action: BiodataStateAction.contactFam,
        status: BiodataStateStatus.saveDraftLoading,
      ),
    );
    try {
      Hive.box<ContactFamilyDetails>(
        name: contactFamilyBox,
      ).put(contactFamilyKey, event.data);
      emit(
        state.copyWith(
          contactFamilyDetails: event.data,
          action: BiodataStateAction.contactFam,
          status: BiodataStateStatus.saveDraftSuccess,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          contactFamilyDetails: null,
          action: BiodataStateAction.contactFam,
          status: BiodataStateStatus.saveDraftFailure,
        ),
      );
    }
  }

  FutureOr<void> _onSaveDraftMedicalHistory(
    SaveDraftMedicalHistory event,
    Emitter<BiodataState> emit,
  ) {
    emit(
      state.copyWith(
        action: BiodataStateAction.medicalHis,
        status: BiodataStateStatus.saveDraftLoading,
      ),
    );
    try {
      Hive.box<MedicalHistory>(
        name: medicalHistoryBox,
      ).put(medicalHistoryKey, event.data);
      emit(
        state.copyWith(
          medicalHistory: event.data,
          action: BiodataStateAction.medicalHis,
          status: BiodataStateStatus.saveDraftSuccess,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          medicalHistory: null,
          action: BiodataStateAction.medicalHis,
          status: BiodataStateStatus.saveDraftFailure,
        ),
      );
    }
  }

  FutureOr<void> _onSaveDraftOtherPersonalInfo(
    SaveDraftOtherPersonalInfo event,
    Emitter<BiodataState> emit,
  ) {
    emit(
      state.copyWith(
        action: BiodataStateAction.otherPersonalInfo,
        status: BiodataStateStatus.saveDraftLoading,
      ),
    );
    try {
      Hive.box<OtherPersonalInfo>(
        name: otherPersonalInfoBox,
      ).put(otherPersonalInfoKey, event.data);
      emit(
        state.copyWith(
          otherInfo: event.data,
          action: BiodataStateAction.otherPersonalInfo,
          status: state.hasFileUploadError
              ? BiodataStateStatus.none
              : BiodataStateStatus.saveDraftSuccess,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          otherInfo: null,
          action: BiodataStateAction.otherPersonalInfo,
          status: BiodataStateStatus.saveDraftFailure,
        ),
      );
    }
  }

  FutureOr<void> _onSaveDraftJobPreference(
    SaveDraftJobPreference event,
    Emitter<BiodataState> emit,
  ) {
    emit(
      state.copyWith(
        action: BiodataStateAction.jobPrefer,
        status: BiodataStateStatus.saveDraftLoading,
      ),
    );
    try {
      Hive.box<JobPreferences>(
        name: jobPreferenceBox,
      ).put(jobPreferenceKey, event.data);
      Hive.box<List<WorkHistory>>(
        name: workHistoriesBox,
      ).put(workHistoriesKey, event.workHistories);
      emit(
        state.copyWith(
          jobPreference: event.data,
          workHistories: event.workHistories,
          action: BiodataStateAction.jobPrefer,
          status: BiodataStateStatus.saveDraftSuccess,
        ),
      );
    } catch (e) {
      debugPrint("❌ Error: $e");
      emit(
        state.copyWith(
          jobPreference: null,
          action: BiodataStateAction.jobPrefer,
          status: BiodataStateStatus.saveDraftFailure,
        ),
      );
    }
  }

  FutureOr<void> _onFileUploadError(
    BroadcastFileUploadError event,
    Emitter<BiodataState> emit,
  ) {
    emit(
      state.copyWith(
        hasFileUploadError: event.value,
      ),
    );
  }

  FutureOr<void> _onResetState(ResetState event, Emitter<BiodataState> emit) {
    emit(
      state.copyWith(
        action: BiodataStateAction.none,
        status: BiodataStateStatus.none,
      ),
    );
  }
}
