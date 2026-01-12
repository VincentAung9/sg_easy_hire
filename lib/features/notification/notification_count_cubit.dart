import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCountCubit extends Cubit<int> {
  NotificationCountCubit() : super(0);
  void resetCount() => emit(0);
  void increaseCount() => emit(state + 1);
}
