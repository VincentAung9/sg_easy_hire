import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sg_easy_hire/models/User.dart';

part 'auth_change_state.freezed.dart';

@freezed
class AuthChangeState with _$AuthChangeState {
  factory AuthChangeState({User? user}) = _AuthChangeState;
}
