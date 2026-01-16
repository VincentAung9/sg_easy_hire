import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';

class LanguageSwitchCubit extends Cubit<String> {
  final Box<String> box = Hive.box<String>(name: languageBox);
  LanguageSwitchCubit() : super('en') {
    final cachedLanguage = box.get(languageKey, defaultValue: "en");
    emit(cachedLanguage!);
  }
  void change(String value) {
    box.put(languageKey, value);
    emit(value);
  }
}
