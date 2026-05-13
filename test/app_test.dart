import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_4/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});

    const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
          (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return Directory.systemTemp.path;
        }
        return null;
      },
    );
  });

  group('Интеграционные тесты (Весь флоу)', () {

    testWidgets('Полный цикл: Логин -> Переход на настройки -> Смена вкладки', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      final loginBtn = find.byType(ElevatedButton).first;

      if (textFields.evaluate().length >= 2) {
        await tester.enterText(textFields.first, 'test@mail.com');
        await tester.enterText(textFields.last, '123456');
        await tester.pumpAndSettle();
      }

      await tester.tap(loginBtn);
      await tester.pumpAndSettle();

      final settingsIcon = find.byIcon(Icons.settings);
      expect(settingsIcon, findsWidgets);

      if (settingsIcon.evaluate().isNotEmpty) {
        await tester.tap(settingsIcon.first);
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.language), findsOneWidget);
      }
    });
  });
}