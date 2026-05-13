import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Для работы с LogicalKeyboardKey
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../providers/library_provider.dart';
import '../providers/settings_provider.dart';

// 1. Определяем Интенты (намерения пользователя)
class AddLibraryIntent extends Intent {
  const AddLibraryIntent();
}

class LogoutIntent extends Intent {
  const LogoutIntent();
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  // ИСПРАВЛЕНО: Теперь этот метод открывает карту, а не создает фейковую библиотеку
  void _openMapScreen() {
    context.push('/map');
  }

  @override
  Widget build(BuildContext context) {
    final libraries = ref.watch(libraryProvider);
    final l10n = AppLocalizations.of(context);

    if (l10n == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    // 2. Настраиваем Shortcuts и Actions
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        // Ctrl + N (New) -> Откроет карту
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN): const AddLibraryIntent(),
        // Ctrl + Q (Quit/Logout)
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ): const LogoutIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          AddLibraryIntent: CallbackAction<AddLibraryIntent>(
            onInvoke: (intent) => _openMapScreen(), // Вызываем переход на карту
          ),
          LogoutIntent: CallbackAction<LogoutIntent>(
            onInvoke: (intent) => ref.read(authProvider.notifier).logout(),
          ),
        },
        child: Focus( // Focus нужен, чтобы Shortcuts "слышали" нажатия
          autofocus: true,
          child: AdaptiveScaffold(
            selectedIndex: _selectedIndex,
            onSelectedIndexChange: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              NavigationDestination(icon: const Icon(Icons.library_books), label: l10n.libraries),
              NavigationDestination(icon: const Icon(Icons.settings), label: l10n.settings),
            ],
            body: (context) {
              if (_selectedIndex == 1) {
                return _buildSettingsScreen(ref, l10n);
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text(l10n.appTitle),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.logout),
                      tooltip: 'Ctrl+Q', // Подсказка для пользователя
                      onPressed: () => ref.read(authProvider.notifier).logout(),
                    )
                  ],
                ),
                body: libraries.isEmpty
                    ? Center(child: Text(l10n.emptyList))
                    : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: libraries.length,
                  itemBuilder: (context, index) {
                    final lib = libraries[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Hero(
                          tag: 'lib-icon-${lib.id}',
                          child: const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.menu_book, color: Colors.white),
                          ),
                        ),
                        title: Text(lib.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(lib.address),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => ref.read(libraryProvider.notifier).deleteLibrary(lib.id),
                        ),
                        onTap: () => context.push('/details', extra: lib),
                      ),
                    );
                  },
                ),
                // ИСПРАВЛЕНО: Кнопка Плюс
                floatingActionButton: FloatingActionButton(
                  onPressed: _openMapScreen,
                  tooltip: 'Добавить (Ctrl+N)', // Подсказка
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add_location_alt, color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsScreen(WidgetRef ref, AppLocalizations l10n) {
    final currentTheme = ref.watch(themeProvider);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text(l10n.theme),
            leading: const Icon(Icons.palette),
            trailing: DropdownButton<ThemeMode>(
              value: currentTheme,
              onChanged: (mode) => ref.read(themeProvider.notifier).setTheme(mode!),
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.language),
            leading: const Icon(Icons.language),
            trailing: DropdownButton<Locale>(
              value: currentLocale,
              onChanged: (loc) => ref.read(localeProvider.notifier).setLocale(loc!),
              items: const [
                DropdownMenuItem(value: Locale('ru'), child: Text('Русский')),
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('be'), child: Text('Беларуская')),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.appVersion),
            subtitle: const Text('1.0.0 (Сборка 1)'),
            leading: const Icon(Icons.info_outline),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.clearCache),
            leading: const Icon(Icons.delete_sweep, color: Colors.red),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Кэш будет очищен в следующей версии!')),
              );
            },
          ),
        ],
      ),
    );
  }
}