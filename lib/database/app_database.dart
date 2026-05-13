import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Libraries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get district => text().nullable()();
}

@DriftDatabase(tables: [Libraries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Library>> getAllLibraries() => select(libraries).get();

  Future<int> insertLibrary(LibrariesCompanion entry) =>
      into(libraries).insert(entry);

  Future<int> deleteLibraryById(int id) =>
      (delete(libraries)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}