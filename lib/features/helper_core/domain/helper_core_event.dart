part of 'helper_core_bloc.dart';

class HelperCoreEvent {}

class GetInitialUserData extends HelperCoreEvent {
  final String id;
  GetInitialUserData({required this.id});
}

class StartSubscribeToUser extends HelperCoreEvent {}

class StartSubscribeToHiveUser extends HelperCoreEvent {}
