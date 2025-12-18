import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sg_easy_hire/features/helper_home/domain/other/count_down_state.dart';


class CountdownCubit extends Cubit<CountdownState> {
  Timer? _timer;

  CountdownCubit() : super(CountdownState.initial());

  void startCountdown(TemporalDateTime confirmDate) {
    final target = confirmDate.getDateTimeInUtc().toLocal();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      Duration diff = target.difference(now);
      if (diff.isNegative) {
        emit(CountdownState(days: 0, hours: 0, minutes: 0, isFinished: true));
        _timer?.cancel();
        return;
      }

      final days = diff.inDays;
      final hours = diff.inHours % 24;
      final mins = diff.inMinutes % 60;
      emit(
        CountdownState(
          days: days,
          hours: hours,
          minutes: mins,
          isFinished: false,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
