import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/helper_home/repository/helper_home_repository.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StreamSubscription<List<Interview>>? _interviewSub;
  StreamSubscription<List<AppliedJob>>? _appliedJobSub;
  StreamSubscription<List<ViewHelper>>? _profileViewSub;
  StreamSubscription<Interview?>? _nextInterviewSub;

  final HelperHomeRepository repository;
  HomeBloc({
    required this.repository,
  }) : super(HomeState()) {
    on<StartListenNextInterview>(_onStartListenNextInterview);
    on<StartListenProfileView>(_onStartListenProfileViews);
    on<StartListenAppliedJobs>(_onStartListenAppliedJobs);
    on<StartListenInterviews>(_onStartListenInterviews);
    on<ApplyJobEvent>(_onApplyJob);
  }

  FutureOr<void> _onStartListenNextInterview(
    StartListenNextInterview event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        action: HomeStateActions.nextInterview,
        status: HomeStateStatus.pending,
      ),
    );
    return emit.onEach(
      repository.nextInterview,
      onData: (interview) => emit(
        state.copyWith(nextInterview: interview, status: HomeStateStatus.none),
      ),
      onError: (error, _) {
        debugPrint("Listen next interview error: $error");
      },
    );
  }

  FutureOr<void> _onApplyJob(
    ApplyJobEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event.currentUser.verifyStatus != VerifyStatus.VERIFIED) {
      emit(
        state.copyWith(
          action: HomeStateActions.applyJob,
          status: HomeStateStatus.failure,
        ),
      );
      return;
    }
    final jobIndex = state.recommendJobs.indexWhere(
      (rj) => rj.id == event.oldJob.id,
    );
    final oldJobs = List.of(state.recommendJobs);
    final newJobs = List.of(state.recommendJobs);
    newJobs[jobIndex] = event.oldJob.copyWith(
      applications: [...event.oldJob.applications ?? [], event.appliedJob],
    );
    emit(state.copyWith(recommendJobs: newJobs));
    try {
      // await repository.applyJob(event.appliedJob);
      await Future.delayed(const Duration(seconds: 2), () => throw Exception());
    } on Exception catch (_) {
      emit(
        state.copyWith(
          recommendJobs: oldJobs,
          action: HomeStateActions.applyJob,
          status: HomeStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onStartListenProfileViews(
    StartListenProfileView event,
    Emitter<HomeState> emit,
  ) async {
    await _profileViewSub?.cancel();
    _profileViewSub = repository.profileView.listen(
      (profileViews) => emit(
        state.copyWith(profileViews: profileViews),
      ),
      // ignore: inference_failure_on_untyped_parameter
      onError: (error) {
        debugPrint("Listen interviews error: $error");
      },
    );
  }

  FutureOr<void> _onStartListenAppliedJobs(
    StartListenAppliedJobs event,
    Emitter<HomeState> emit,
  ) async {
    await _appliedJobSub?.cancel();
    _appliedJobSub = repository.appliedJobs.listen(
      (appliedJobs) => emit(
        state.copyWith(appliedJobs: appliedJobs),
      ),
      // ignore: inference_failure_on_untyped_parameter
      onError: (e) {
        debugPrint("Listen applied jobs error: $e");
      },
    );
  }

  FutureOr<void> _onStartListenInterviews(
    StartListenInterviews event,
    Emitter<HomeState> emit,
  ) async {
    await _interviewSub?.cancel();
    _interviewSub = repository.interviews.listen(
      (interviews) {
        final pending = interviews
            .where(
              (i) => i.status == InterviewStatus.PENDING,
            )
            .toList();
        final accept = interviews
            .where(
              (i) => i.status == InterviewStatus.ACCEPTED,
            )
            .toList();
        final complete = interviews
            .where(
              (i) => i.status == InterviewStatus.COMPLETED,
            )
            .toList();
        final cancel = interviews
            .where(
              (i) => i.status == InterviewStatus.CANCELLED,
            )
            .toList();
        emit(
          state.copyWith(
            interviews: interviews,
            pending: pending,
            accepted: accept,
            completed: complete,
            cancelled: cancel,
          ),
        );
      },
      // ignore: inference_failure_on_untyped_parameter
      onError: (e) {
        debugPrint("Listen applied jobs error: $e");
      },
    );
  }

  @override
  Future<void> close() {
    _interviewSub?.cancel();
    _appliedJobSub?.cancel();
    _profileViewSub?.cancel();
    _nextInterviewSub?.cancel();
    return super.close();
  }
}
