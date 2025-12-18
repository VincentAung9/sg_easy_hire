class CountdownState {
  final int days;
  final int hours;
  final int minutes;
  final bool isFinished;

  CountdownState({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.isFinished,
  });

  factory CountdownState.initial() => CountdownState(
    days: 0,
    hours: 0,
    minutes: 0,
    isFinished: false,
  );
}
