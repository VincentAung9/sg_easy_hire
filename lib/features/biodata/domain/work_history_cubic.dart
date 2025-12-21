import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/models/WorkHistory.dart';

class WorkHistoryCubit extends Cubit<List<WorkHistory>> {
  WorkHistoryCubit() : super([]);

  void addWorkHistories(List<WorkHistory> workHistories) {
    emit(workHistories);
  }

  void addWorkHistory(WorkHistory workHistory) {
    final currentList = List<WorkHistory>.from(state)..add(workHistory);
    emit(currentList);
  }

  void removeWorkHistory(WorkHistory workHistory) {
    final currentList = List<WorkHistory>.from(state)..remove(workHistory);
    emit(currentList);
  }

  void changeLocation(int index, String newLocation) {
    final currentList = List<WorkHistory>.from(state);
    final workHistory = currentList[index];
    final updatedWorkHistory = workHistory.copyWith(location: newLocation);
    currentList[index] = updatedWorkHistory;
    emit(currentList);
  }

  void changeDuration(int index, String newDuration) {
    final currentList = List<WorkHistory>.from(state);
    final workHistory = currentList[index];
    final updatedWorkHistory = workHistory.copyWith(duration: newDuration);
    currentList[index] = updatedWorkHistory;
    emit(currentList);
  }

  void changeDescription(int index, String descriptoin) {
    final currentList = List<WorkHistory>.from(state);
    final workHistory = currentList[index];
    final updatedWorkHistory = workHistory.copyWith(description: descriptoin);
    currentList[index] = updatedWorkHistory;
    emit(currentList);
  }

  void changeDuties(int index, String duties) {
    final currentList = List<WorkHistory>.from(state);
    final workHistory = currentList[index];
    final updatedWorkHistory = workHistory.copyWith(duties: duties);
    currentList[index] = updatedWorkHistory;
    emit(currentList);
  }
}
