import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_out_state.freezed.dart';

@freezed
class SignOutState with _$SignOutState {
  factory SignOutState({
    @Default(false) bool isPending,
    @Default(false) bool isSuccess,
    @Default(false) bool isError,
  }) = _SignOutState;
}
