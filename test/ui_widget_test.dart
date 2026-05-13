import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_4/main.dart';

void main() {
  group('Widget Тесты (UI)', () {

    testWidgets('Отображение элементов на экране авторизации', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsWidgets);

      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('Наличие полей Email и Пароль', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      final textFields = find.byWidgetPredicate(
              (widget) => widget is TextField || widget is TextFormField
      );

      expect(textFields, findsAtLeastNWidgets(2));
    });

    testWidgets('Попытка входа оставляет пользователя на экране при пустых полях', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      final loginBtn = find.byType(ElevatedButton).first;

      await tester.tap(loginBtn);
      await tester.pumpAndSettle();

      expect(find.byType(ElevatedButton), findsWidgets);
    });
  });
}