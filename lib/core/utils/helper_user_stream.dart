import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/box_keys.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

void subscribeUserOr(BuildContext context) {
  final helperCoreBloc = context.read<HelperCoreBloc>();
  final box = Hive.box<User>(name: userBox);
  final user = box.get(userBoxKey);
  if (!(user == null)) {
    helperCoreBloc.add(StartSubscribeToUser());
  }
}
