import 'package:flutter_bloc/flutter_bloc.dart';

class JobofferCountCubit extends Cubit<int> {
  JobofferCountCubit() : super(0);
  void resetCount() => emit(0);
  void increaseCount() => emit(state + 1);
}
