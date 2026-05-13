// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Библиотеки Минска';

  @override
  String get settings => 'Настройки';

  @override
  String get libraries => 'Библиотеки';

  @override
  String get emptyList => 'Список пуст. Добавьте библиотеку!';

  @override
  String get logout => 'Выйти';

  @override
  String get login => 'Войти';

  @override
  String get theme => 'Тема оформления';

  @override
  String get language => 'Язык приложения';

  @override
  String get clearCache => 'Очистить кэш (удалить все)';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get attendance => 'Посещаемость за неделю';

  @override
  String get visitors => 'Посетители';
}
