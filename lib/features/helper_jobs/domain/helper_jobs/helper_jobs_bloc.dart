import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_event.dart';
import 'package:sg_easy_hire/features/helper_jobs/domain/helper_jobs/helper_jobs_state.dart';
import 'package:sg_easy_hire/features/helper_jobs/repository/helper_job_repository.dart';
import 'package:sg_easy_hire/models/Job.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:sg_easy_hire/models/VerifyStatus.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

class HelperJobsBloc extends Bloc<HelperJobsEvent, HelperJobsState> {
  final HelperJobRepository repository;
  HelperJobsBloc({required this.repository}) : super(HelperJobsState()) {
    on<GetJobsEvent>(_onGetJobs, transformer: droppable());
    on<GetJobTags>(_onGetJobTags);
    on<FavouriteJob>(_onFavouriteJob, transformer: droppable());
    on<UnfavouriteJob>(_onUnfavouriteJob, transformer: droppable());
    on<ChangeJobTag>(_onChangeJobTag, transformer: restartable());
    on<SearchJobsEvent>(_onSearchJobs, transformer: restartable());
    on<ApplyJobEvent>(_onApplyJobs);
  }

  FutureOr<void> _onGetJobs(
    GetJobsEvent event,
    Emitter<HelperJobsState> emit,
  ) async {
    if (!state.hasNext) return;
    if (state.status == HelperJobsStatus.initialPending) {
      emit(
        state.copyWith(
          action: HelperJobsActions.getJobs,
          status: HelperJobsStatus.initialPending,
        ),
      );
      final result = await repository.getJobs(
        page: state.page,
        limit: state.limit,
        query: state.query,
      );
      final hasNext = result.length < state.limit;
      return emit(
        state.copyWith(
          action: HelperJobsActions.getJobs,
          status: HelperJobsStatus.success,
          hasNext: hasNext,
          page: hasNext ? 1 : 0,
          jobs: result,
        ),
      );
    }
    emit(
      state.copyWith(
        action: HelperJobsActions.getJobs,
        status: HelperJobsStatus.subPending,
      ),
    );
    final jobs = await repository.getJobs(
      page: state.page,
      limit: state.limit,
      query: state.query,
    );
    final hasNext = jobs.length < 20;
    emit(
      state.copyWith(
        action: HelperJobsActions.getJobs,
        status: HelperJobsStatus.none,
        hasNext: hasNext,
        page: hasNext ? state.page + 1 : state.page,
        jobs: List.of(state.jobs)..addAll(jobs),
      ),
    );
  }

  FutureOr<void> _onApplyJobs(
    ApplyJobEvent event,
    Emitter<HelperJobsState> emit,
  ) async {
    if (event.currentUser.verifyStatus != VerifyStatus.VERIFIED) {
      return emit(
        state.copyWith(
          action: HelperJobsActions.applyJob,
          status: HelperJobsStatus.failure,
        ),
      );
    }

    final jobIndex = state.jobs.indexWhere(
      (rj) => rj.id == event.oldJob.id,
    );
    final oldJobs = state.jobs;
    final newJobs = state.jobs;
    newJobs[jobIndex] = event.oldJob.copyWith(
      applications: [...event.oldJob.applications ?? [], event.appliedJob],
    );
    emit(state.copyWith(jobs: newJobs));
    try {
      //await repository.applyJob(event.appliedJob);
      await Future.delayed(const Duration(seconds: 2), () => throw Exception());
    } on Exception catch (_) {
      emit(
        state.copyWith(
          jobs: oldJobs,
          action: HelperJobsActions.applyJob,
          status: HelperJobsStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onSearchJobs(
    SearchJobsEvent event,
    Emitter<HelperJobsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HelperJobsStatus.initialPending,
        jobs: [],
        page: 0,
        hasNext: false,
        query: event.query,
      ),
    );

    // 2. Fetch first page of search
    final jobs = await repository.getJobs(
      page: 0,
      limit: state.limit,
      query: event.query,
    );
    final hasNext = jobs.length < 20;
    emit(
      state.copyWith(
        status: HelperJobsStatus.success,
        jobs: jobs,
        hasNext: hasNext,
        page: hasNext ? 1 : 0,
      ),
    );
  }

  FutureOr<void> _onGetJobTags(
    GetJobTags event,
    Emitter<HelperJobsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HelperJobsStatus.initialPending,
        action: HelperJobsActions.getJobTags,
      ),
    );
    final result = await repository.getJobTags();
    emit(
      state.copyWith(
        jobTags: result,
        action: HelperJobsActions.getJobTags,
        status: HelperJobsStatus.success,
      ),
    );
  }

  FutureOr<void> _onChangeJobTag(
    ChangeJobTag event,
    Emitter<HelperJobsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HelperJobsStatus.initialPending,
        jobs: [],
        page: 0,
        hasNext: false,
        query: state.query,
        selectedJobTag: event.tag,
      ),
    );

    final jobs = await repository.getJobs(
      page: 0,
      limit: state.limit,
      tag: event.tag,
    );
    final hasNext = jobs.length < 20;
    emit(
      state.copyWith(
        status: HelperJobsStatus.success,
        jobs: jobs,
        hasNext: hasNext,
        page: hasNext ? 1 : 0,
      ),
    );
  }

  FutureOr<void> _onFavouriteJob(
    FavouriteJob event,
    Emitter<HelperJobsState> emit,
  ) async {
    final oldJobs = state.jobs;
    final jobIndex = oldJobs.indexWhere((oj) => oj.id == event.oldJob.id);
    List<Job> newJobs = List.from(oldJobs);
    final savedJob = SavedJob(
      user: event.currentUser,
      job: event.oldJob,
    );
    newJobs[jobIndex] = event.oldJob.copyWith(
      savedJobs: [...(event.oldJob.savedJobs ?? []), savedJob],
    );
    emit(state.copyWith(jobs: newJobs));
    try {
      await repository.favouriteJob(savedJob);
      emit(
        state.copyWith(
          status: HelperJobsStatus.success,
          action: HelperJobsActions.favouriteJob,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          jobs: oldJobs,
          status: HelperJobsStatus.failure,
          action: HelperJobsActions.favouriteJob,
        ),
      );
    }
  }

  FutureOr<void> _onUnfavouriteJob(
    UnfavouriteJob event,
    Emitter<HelperJobsState> emit,
  ) async {
    final oldJobs = state.jobs;
    final jobIndex = oldJobs.indexWhere((oj) => oj.id == event.oldJob.id);
    List<Job> newJobs = List.from(oldJobs);
    final savedJobs = event.oldJob.savedJobs ?? []
      ..removeWhere(
        (sj) =>
            sj.job?.id == event.oldJob.id &&
            sj.user?.id == event.currentUser.id,
      );
    newJobs[jobIndex] = event.oldJob.copyWith(
      savedJobs: [...savedJobs],
    );
    emit(state.copyWith(jobs: newJobs));
    try {
      await repository.unfavouriteJob(
        SavedJob(
          user: event.currentUser,
          job: event.oldJob,
        ),
      );
      emit(
        state.copyWith(
          status: HelperJobsStatus.success,
          action: HelperJobsActions.unfavouriteJob,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          jobs: oldJobs,
          status: HelperJobsStatus.failure,
          action: HelperJobsActions.unfavouriteJob,
        ),
      );
    }
  }
}
