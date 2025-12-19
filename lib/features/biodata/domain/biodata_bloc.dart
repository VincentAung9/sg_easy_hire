import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/features/biodata/data/repository/biodata_repository.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/models/User.dart';

class BiodataBloc extends Bloc<BiodataEvent, BiodataState> {
  Box<User> box = Hive.box<User>(name: userBox);
  final BiodataRepository repository;
  BiodataBloc({required this.repository}) : super(BiodataState()) {
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
        status: BiodataStateStatus.success,
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
      emit(
        state.copyWith(
          personalInformation: event.data,
          action: BiodataStateAction.personalInfo,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
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
        status: BiodataStateStatus.success,
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
      emit(
        state.copyWith(
          contactFamilyDetails: event.data,
          action: BiodataStateAction.contactFam,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
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
        status: BiodataStateStatus.success,
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
      emit(
        state.copyWith(
          medicalHistory: event.data,
          action: BiodataStateAction.medicalHis,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
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
        status: BiodataStateStatus.success,
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
      emit(
        state.copyWith(
          otherInfo: event.data,
          action: BiodataStateAction.otherPersonalInfo,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
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
    emit(
      state.copyWith(
        jobPreference: result,
        action: BiodataStateAction.jobPrefer,
        status: BiodataStateStatus.success,
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
      emit(
        state.copyWith(
          jobPreference: event.data,
          action: BiodataStateAction.jobPrefer,
          status: BiodataStateStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          action: BiodataStateAction.jobPrefer,
          status: BiodataStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onGetUploadedDocument(
    GetUploadedDocument event,
    Emitter<BiodataState> emit,
  ) {}

  FutureOr<void> _onAddUploadedDocument(
    AddUploadDocument event,
    Emitter<BiodataState> emit,
  ) {}
}
