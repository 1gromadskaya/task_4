import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../main.dart';
import '../database/app_database.dart';

final libraryProvider = StateNotifierProvider<LibraryNotifier, List<Library>>((ref) {
  final db = ref.watch(databaseProvider);
  return LibraryNotifier(db);
});

class LibraryNotifier extends StateNotifier<List<Library>> {
  final AppDatabase _db;

  LibraryNotifier(this._db) : super([]) {
    _init();
  }

  Future<void> _init() async {
    await fetchLibraries();
    if (state.isEmpty) {
      await _seedInitialData();
    }
  }

  Future<void> fetchLibraries() async {
    state = await _db.getAllLibraries();
  }

  Future<void> addLibrary(String name, String address, {double lat = 53.9, double lon = 27.56}) async {
    await _db.insertLibrary(
      LibrariesCompanion.insert(
        name: name,
        address: address,
        latitude: lat,
        longitude: lon,
        district: const Value('Минск'),
      ),
    );
    await fetchLibraries();
  }

  Future<void> deleteLibrary(int id) async {
    await _db.deleteLibraryById(id);
    await fetchLibraries();
  }

  Future<void> _seedInitialData() async {
    final List<Map<String, dynamic>> minskLibraries = [
      {'name': 'Национальная библиотека Беларуси', 'address': 'пр-т Независимости, 116', 'lat': 53.9314, 'lon': 27.6461},
      {'name': 'Центральная библиотека им. Янки Купалы', 'address': 'ул. Веры Хоружей, 16', 'lat': 53.9197, 'lon': 27.5794},
    ];

    for (var data in minskLibraries) {
      await _db.insertLibrary(
        LibrariesCompanion.insert(
          name: data['name'],
          address: data['address'],
          latitude: data['lat'],
          longitude: data['lon'],
          district: const Value('Минск'),
        ),
      );
    }
    await fetchLibraries();
  }
}