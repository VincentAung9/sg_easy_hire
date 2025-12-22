import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/auth_repository.dart';
import 'package:sg_easy_hire/features/biodata/data/repository/biodata_repository.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
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
    on<GetPersonalInformation>(_onGetPersonalInfo);
    on<AddPersonalInformation>(_onAddPersonalInfo);
    on<GetContactFamilyInfo>(_onGetContactFamily);
    on<AddContactFamilyInfo>(_onAddContactFamily);
    on<GetMedicalHistory>(_onGetMedicalHistory);
    on<AddMedicalHistory>(_onAddMedicalHistory);
    on<GetOtherPersonalInfo>(_onGetOtherPersonalInfo);
    on<AddOtherPersonalInfo>(_onAddOtherPersonalInfo);
    on<GetJobPreference>(_onGetJobPreference);
    on<AddJobPreference>(_onAddJobPreference);
    on<GetUploadedDocument>(_onGetUploadedDocument);
    on<AddUploadDocument>(_onAddUploadedDocument);
    on<SaveDraftDocuments>(_onSaveDraftDocuments);
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
    final result = await repository.getPersonalInfo(hiveUser?.id ?? "");
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
      await repository.addPersonalinfo(event.data);
      await authRepository.updateUser(
        user: event.data.user?.copyWith(
          personalInformation: event.data,
        ),
      );
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
    final result = await repository.getContactFamily(hiveUser?.id ?? "");
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
    final result = await repository.getMedicalHistory(hiveUser?.id ?? "");
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
    final result = await repository.getOtherPersonalInfo(hiveUser?.id ?? "");
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
    final result = await repository.getJobPreferences(hiveUser?.id ?? "");
    final workHistories = await repository.getWorkHistories(hiveUser?.id ?? "");

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
    Hive.box<UploadedDocuments>(
      name: helperPersonalDocuments,
    ).put(helperPersonalDocumentsKey, event.data);
    emit(
      state.copyWith(
        documents: event.data,
        action: BiodataStateAction.saveDoc,
        status: BiodataStateStatus.success,
      ),
    );
  }
}
