import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';


class LanguageSwitchCubit extends Cubit<String> {
  final Box<String> box = Hive.box<String>(name: languageBox);
  LanguageSwitchCubit() : super('my') {
    final cachedLanguage = box.get(languageKey, defaultValue: "my");
    emit(cachedLanguage!);
  }
  void change(String value) {
    box.put(languageKey, value);
    emit(value);
  }
}
