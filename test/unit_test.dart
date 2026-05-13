import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:task_4/providers/settings_provider.dart';
import 'package:task_4/providers/auth_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Unit Тесты (Провайдеры)', () {

    test('Начальная тема должна быть системной', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final theme = container.read(themeProvider);
      expect(theme, equals(ThemeMode.system));
    });

    test('Смена языка на английский', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(localeProvider.notifier).setLocale(const Locale('en'));

      final currentLocale = container.read(localeProvider);
      expect(currentLocale.languageCode, equals('en'));
    });

    test('Пользователь изначально не авторизован', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final isAuth = container.read(authProvider);
      expect(isAuth, isFalse);
    });
  });
}