import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_event.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_state.dart';
import 'package:sg_easy_hire/features/helper_home/repository/helper_home_repository.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HelperHomeRepository repository;
  HomeBloc({
    required this.repository,
  }) : super(HomeState()) {
    on<StartListenCreateNextInterview>(_onStartListenCreateNextInterview);
    on<StartListenUpdateNextInterview>(_onStartListenUpdateNextInterview);
    on<StartGetProfileViews>(_onStartGetProfileViews);
    on<StartListenCreateProfileView>(_onStartListenCreateProfileViews);
    on<StartGetAppliedJobs>(_onStartGetAppliedJobs);
    on<StartGetInterviews>(_onGetInterviews);
    on<StartListenCreateInterviews>(_onStartListenCreateInterviews);
    on<StartListenUpdateInterviews>(_onStartListenUpdateInterviews);
    on<ApplyJobEvent>(_onApplyJob);
    on<GetRecommendJobsEvent>(_onGetRecommendJobs);
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

  FutureOr<void> _onGetRecommendJobs(
    GetRecommendJobsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        action: HomeStateActions.recommendJob,
        status: HomeStateStatus.pending,
      ),
    );
    final result = await repository.getRecommendedJobs(event.skills);
    emit(
      state.copyWith(
        recommendJobs: result,
        action: HomeStateActions.recommendJob,
        status: HomeStateStatus.success,
      ),
    );
  }

  FutureOr<void> _onStartListenCreateNextInterview(
    StartListenCreateNextInterview event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        action: HomeStateActions.nextInterview,
        status: HomeStateStatus.pending,
      ),
    );
    return emit.onEach(
      repository.createInterviews,
      onData: (interview) {
        if (interview == null) return;
        if (state.nextInterview == null) {
          emit(
            state.copyWith(
              nextInterview: interview,
              status: HomeStateStatus.none,
            ),
          );
          return;
        }
        if (interview.confirmedDateTime?.getDateTimeInUtc().isBefore(
              state.nextInterview!.confirmedDateTime!.getDateTimeInUtc(),
            ) ??
            false) {
          emit(
            state.copyWith(
              nextInterview: interview,
              status: HomeStateStatus.none,
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onStartListenUpdateNextInterview(
    StartListenUpdateNextInterview event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        action: HomeStateActions.nextInterview,
        status: HomeStateStatus.pending,
      ),
    );
    return emit.onEach(
      repository.updateInterviews,
      onData: (interview) {
        if (interview == null) return;
        if (state.nextInterview == null) {
          emit(
            state.copyWith(
              nextInterview: interview,
              status: HomeStateStatus.none,
            ),
          );
          return;
        }
        if (interview.confirmedDateTime?.getDateTimeInUtc().isBefore(
              state.nextInterview!.confirmedDateTime!.getDateTimeInUtc(),
            ) ??
            false) {
          emit(
            state.copyWith(
              nextInterview: interview,
              status: HomeStateStatus.none,
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onStartGetProfileViews(
    StartGetProfileViews event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        action: HomeStateActions.profileViews,
        status: HomeStateStatus.pending,
      ),
    );
    final result = await repository.getProfileViews();
    emit(
      state.copyWith(
        profileViews: result,
        action: HomeStateActions.profileViews,
        status: HomeStateStatus.success,
      ),
    );
  }

  FutureOr<void> _onStartListenCreateProfileViews(
    StartListenCreateProfileView event,
    Emitter<HomeState> emit,
  ) {
    return emit.onEach(
      repository.profileView,
      onData: (view) {
        if (!(view == null)) {
          emit(
            state.copyWith(
              profileViews: [
                ...state.profileViews,
                view,
              ],
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onStartGetAppliedJobs(
    StartGetAppliedJobs event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        action: HomeStateActions.applyJob,
        status: HomeStateStatus.pending,
      ),
    );
    final result = await repository.getAppliedJobs();
    emit(
      state.copyWith(
        appliedJobs: result,
        action: HomeStateActions.applyJob,
        status: HomeStateStatus.success,
      ),
    );
  }

  FutureOr<void> _onGetInterviews(
    StartGetInterviews event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        action: HomeStateActions.interview,
        status: HomeStateStatus.pending,
      ),
    );
    final interviews = await repository.getInterviews();
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
        action: HomeStateActions.interview,
        status: HomeStateStatus.success,
      ),
    );
  }

  FutureOr<void> _onStartListenCreateInterviews(
    StartListenCreateInterviews event,
    Emitter<HomeState> emit,
  ) {
    return emit.onEach(
      repository.createInterviews,
      onData: (interview) {
        if (interview == null) return;
        final allInterviews = [...state.interviews, interview];

        final pending = allInterviews
            .where((i) => i.status == InterviewStatus.PENDING)
            .toList();

        final accept = allInterviews
            .where((i) => i.status == InterviewStatus.ACCEPTED)
            .toList();

        final complete = allInterviews
            .where((i) => i.status == InterviewStatus.COMPLETED)
            .toList();

        final cancel = allInterviews
            .where((i) => i.status == InterviewStatus.CANCELLED)
            .toList();

        emit(
          state.copyWith(
            interviews: allInterviews,
            pending: pending,
            accepted: accept,
            completed: complete,
            cancelled: cancel,
          ),
        );
      },
    );
  }

  FutureOr<void> _onStartListenUpdateInterviews(
    StartListenUpdateInterviews event,
    Emitter<HomeState> emit,
  ) {
    return emit.onEach(
      repository.updateInterviews,
      onData: (interview) {
        if (!(interview == null)) {
          List<Interview> allInterviews = List.from(state.interviews);
          final index = allInterviews.indexWhere((e) => e.id == interview.id);
          if (index != -1) {
            allInterviews[index] = interview;
            final pending = allInterviews
                .where((i) => i.status == InterviewStatus.PENDING)
                .toList();

            final accept = allInterviews
                .where((i) => i.status == InterviewStatus.ACCEPTED)
                .toList();

            final complete = allInterviews
                .where((i) => i.status == InterviewStatus.COMPLETED)
                .toList();

            final cancel = allInterviews
                .where((i) => i.status == InterviewStatus.CANCELLED)
                .toList();

            emit(
              state.copyWith(
                interviews: allInterviews,
                pending: pending,
                accepted: accept,
                completed: complete,
                cancelled: cancel,
              ),
            );
          }
        }
      },
    );
  }
}
