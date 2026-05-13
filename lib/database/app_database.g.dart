// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LibrariesTable extends Libraries
    with TableInfo<$LibrariesTable, Library> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibrariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _districtMeta =
      const VerificationMeta('district');
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
      'district', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, address, latitude, longitude, district];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'libraries';
  @override
  VerificationContext validateIntegrity(Insertable<Library> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Library map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Library(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      district: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}district']),
    );
  }

  @override
  $LibrariesTable createAlias(String alias) {
    return $LibrariesTable(attachedDatabase, alias);
  }
}

class Library extends DataClass implements Insertable<Library> {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? district;
  const Library(
      {required this.id,
      required this.name,
      required this.address,
      required this.latitude,
      required this.longitude,
      this.district});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    return map;
  }

  LibrariesCompanion toCompanion(bool nullToAbsent) {
    return LibrariesCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      latitude: Value(latitude),
      longitude: Value(longitude),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
    );
  }

  factory Library.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Library(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      district: serializer.fromJson<String?>(json['district']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'district': serializer.toJson<String?>(district),
    };
  }

  Library copyWith(
          {int? id,
          String? name,
          String? address,
          double? latitude,
          double? longitude,
          Value<String?> district = const Value.absent()}) =>
      Library(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        district: district.present ? district.value : this.district,
      );
  Library copyWithCompanion(LibrariesCompanion data) {
    return Library(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      district: data.district.present ? data.district.value : this.district,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Library(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('district: $district')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, address, latitude, longitude, district);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Library &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.district == this.district);
}

class LibrariesCompanion extends UpdateCompanion<Library> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> address;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String?> district;
  const LibrariesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.district = const Value.absent(),
  });
  LibrariesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    this.district = const Value.absent(),
  })  : name = Value(name),
        address = Value(address),
        latitude = Value(latitude),
        longitude = Value(longitude);
  static Insertable<Library> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? district,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (district != null) 'district': district,
    });
  }

  LibrariesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? address,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String?>? district}) {
    return LibrariesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      district: district ?? this.district,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibrariesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('district: $district')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LibrariesTable libraries = $LibrariesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [libraries];
}

typedef $$LibrariesTableCreateCompanionBuilder = LibrariesCompanion Function({
  Value<int> id,
  required String name,
  required String address,
  required double latitude,
  required double longitude,
  Value<String?> district,
});
typedef $$LibrariesTableUpdateCompanionBuilder = LibrariesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> address,
  Value<double> latitude,
  Value<double> longitude,
  Value<String?> district,
});

class $$LibrariesTableFilterComposer
    extends Composer<_$AppDatabase, $LibrariesTable> {
  $$LibrariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get district => $composableBuilder(
      column: $table.district, builder: (column) => ColumnFilters(column));
}

class $$LibrariesTableOrderingComposer
    extends Composer<_$AppDatabase, $LibrariesTable> {
  $$LibrariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get district => $composableBuilder(
      column: $table.district, builder: (column) => ColumnOrderings(column));
}

class $$LibrariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LibrariesTable> {
  $$LibrariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);
}

class $$LibrariesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LibrariesTable,
    Library,
    $$LibrariesTableFilterComposer,
    $$LibrariesTableOrderingComposer,
    $$LibrariesTableAnnotationComposer,
    $$LibrariesTableCreateCompanionBuilder,
    $$LibrariesTableUpdateCompanionBuilder,
    (Library, BaseReferences<_$AppDatabase, $LibrariesTable, Library>),
    Library,
    PrefetchHooks Function()> {
  $$LibrariesTableTableManager(_$AppDatabase db, $LibrariesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibrariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibrariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LibrariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String?> district = const Value.absent(),
          }) =>
              LibrariesCompanion(
            id: id,
            name: name,
            address: address,
            latitude: latitude,
            longitude: longitude,
            district: district,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String address,
            required double latitude,
            required double longitude,
            Value<String?> district = const Value.absent(),
          }) =>
              LibrariesCompanion.insert(
            id: id,
            name: name,
            address: address,
            latitude: latitude,
            longitude: longitude,
            district: district,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LibrariesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LibrariesTable,
    Library,
    $$LibrariesTableFilterComposer,
    $$LibrariesTableOrderingComposer,
    $$LibrariesTableAnnotationComposer,
    $$LibrariesTableCreateCompanionBuilder,
    $$LibrariesTableUpdateCompanionBuilder,
    (Library, BaseReferences<_$AppDatabase, $LibrariesTable, Library>),
    Library,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LibrariesTableTableManager get libraries =>
      $$LibrariesTableTableManager(_db, _db.libraries);
}
