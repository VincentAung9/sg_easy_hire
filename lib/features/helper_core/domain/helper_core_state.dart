import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/User.dart';

part 'helper_core_state.freezed.dart';

@freezed
class HelperCoreState with _$HelperCoreState {
  const factory HelperCoreState({
    User? currentUser,
  }) = _HelperCoreState;
}
