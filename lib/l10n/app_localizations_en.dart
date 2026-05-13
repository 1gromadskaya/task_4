// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Minsk Libraries';

  @override
  String get settings => 'Settings';

  @override
  String get libraries => 'Libraries';

  @override
  String get emptyList => 'List is empty. Add a library!';

  @override
  String get logout => 'Logout';

  @override
  String get login => 'Login';

  @override
  String get theme => 'App Theme';

  @override
  String get language => 'App Language';

  @override
  String get clearCache => 'Clear cache (delete all)';

  @override
  String get appVersion => 'App Version';

  @override
  String get attendance => 'Weekly Attendance';

  @override
  String get visitors => 'Visitors';
}
