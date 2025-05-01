// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ViewedImagesTable extends ViewedImages
    with TableInfo<$ViewedImagesTable, ViewedImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ViewedImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Not Set'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Not Set'));
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Not Set'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Not Set'));
  static const VerificationMeta _viewedAtMeta =
      const VerificationMeta('viewedAt');
  @override
  late final GeneratedColumn<DateTime> viewedAt = GeneratedColumn<DateTime>(
      'viewed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isDarkThemeMeta =
      const VerificationMeta('isDarkTheme');
  @override
  late final GeneratedColumn<bool> isDarkTheme = GeneratedColumn<bool>(
      'is_dark_theme', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_dark_theme" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, url, name, title, origin, description, viewedAt, isDarkTheme];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'viewed_images';
  @override
  VerificationContext validateIntegrity(Insertable<ViewedImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('viewed_at')) {
      context.handle(_viewedAtMeta,
          viewedAt.isAcceptableOrUnknown(data['viewed_at']!, _viewedAtMeta));
    }
    if (data.containsKey('is_dark_theme')) {
      context.handle(
          _isDarkThemeMeta,
          isDarkTheme.isAcceptableOrUnknown(
              data['is_dark_theme']!, _isDarkThemeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ViewedImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ViewedImage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      viewedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}viewed_at'])!,
      isDarkTheme: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dark_theme'])!,
    );
  }

  @override
  $ViewedImagesTable createAlias(String alias) {
    return $ViewedImagesTable(attachedDatabase, alias);
  }
}

class ViewedImage extends DataClass implements Insertable<ViewedImage> {
  final int id;
  final String url;
  final String name;
  final String title;
  final String origin;
  final String description;
  final DateTime viewedAt;
  final bool isDarkTheme;
  const ViewedImage(
      {required this.id,
      required this.url,
      required this.name,
      required this.title,
      required this.origin,
      required this.description,
      required this.viewedAt,
      required this.isDarkTheme});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['name'] = Variable<String>(name);
    map['title'] = Variable<String>(title);
    map['origin'] = Variable<String>(origin);
    map['description'] = Variable<String>(description);
    map['viewed_at'] = Variable<DateTime>(viewedAt);
    map['is_dark_theme'] = Variable<bool>(isDarkTheme);
    return map;
  }

  ViewedImagesCompanion toCompanion(bool nullToAbsent) {
    return ViewedImagesCompanion(
      id: Value(id),
      url: Value(url),
      name: Value(name),
      title: Value(title),
      origin: Value(origin),
      description: Value(description),
      viewedAt: Value(viewedAt),
      isDarkTheme: Value(isDarkTheme),
    );
  }

  factory ViewedImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ViewedImage(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      name: serializer.fromJson<String>(json['name']),
      title: serializer.fromJson<String>(json['title']),
      origin: serializer.fromJson<String>(json['origin']),
      description: serializer.fromJson<String>(json['description']),
      viewedAt: serializer.fromJson<DateTime>(json['viewedAt']),
      isDarkTheme: serializer.fromJson<bool>(json['isDarkTheme']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'name': serializer.toJson<String>(name),
      'title': serializer.toJson<String>(title),
      'origin': serializer.toJson<String>(origin),
      'description': serializer.toJson<String>(description),
      'viewedAt': serializer.toJson<DateTime>(viewedAt),
      'isDarkTheme': serializer.toJson<bool>(isDarkTheme),
    };
  }

  ViewedImage copyWith(
          {int? id,
          String? url,
          String? name,
          String? title,
          String? origin,
          String? description,
          DateTime? viewedAt,
          bool? isDarkTheme}) =>
      ViewedImage(
        id: id ?? this.id,
        url: url ?? this.url,
        name: name ?? this.name,
        title: title ?? this.title,
        origin: origin ?? this.origin,
        description: description ?? this.description,
        viewedAt: viewedAt ?? this.viewedAt,
        isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      );
  ViewedImage copyWithCompanion(ViewedImagesCompanion data) {
    return ViewedImage(
      id: data.id.present ? data.id.value : this.id,
      url: data.url.present ? data.url.value : this.url,
      name: data.name.present ? data.name.value : this.name,
      title: data.title.present ? data.title.value : this.title,
      origin: data.origin.present ? data.origin.value : this.origin,
      description:
          data.description.present ? data.description.value : this.description,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
      isDarkTheme:
          data.isDarkTheme.present ? data.isDarkTheme.value : this.isDarkTheme,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ViewedImage(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('name: $name, ')
          ..write('title: $title, ')
          ..write('origin: $origin, ')
          ..write('description: $description, ')
          ..write('viewedAt: $viewedAt, ')
          ..write('isDarkTheme: $isDarkTheme')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, url, name, title, origin, description, viewedAt, isDarkTheme);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViewedImage &&
          other.id == this.id &&
          other.url == this.url &&
          other.name == this.name &&
          other.title == this.title &&
          other.origin == this.origin &&
          other.description == this.description &&
          other.viewedAt == this.viewedAt &&
          other.isDarkTheme == this.isDarkTheme);
}

class ViewedImagesCompanion extends UpdateCompanion<ViewedImage> {
  final Value<int> id;
  final Value<String> url;
  final Value<String> name;
  final Value<String> title;
  final Value<String> origin;
  final Value<String> description;
  final Value<DateTime> viewedAt;
  final Value<bool> isDarkTheme;
  const ViewedImagesCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.name = const Value.absent(),
    this.title = const Value.absent(),
    this.origin = const Value.absent(),
    this.description = const Value.absent(),
    this.viewedAt = const Value.absent(),
    this.isDarkTheme = const Value.absent(),
  });
  ViewedImagesCompanion.insert({
    this.id = const Value.absent(),
    required String url,
    this.name = const Value.absent(),
    this.title = const Value.absent(),
    this.origin = const Value.absent(),
    this.description = const Value.absent(),
    this.viewedAt = const Value.absent(),
    this.isDarkTheme = const Value.absent(),
  }) : url = Value(url);
  static Insertable<ViewedImage> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<String>? name,
    Expression<String>? title,
    Expression<String>? origin,
    Expression<String>? description,
    Expression<DateTime>? viewedAt,
    Expression<bool>? isDarkTheme,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (name != null) 'name': name,
      if (title != null) 'title': title,
      if (origin != null) 'origin': origin,
      if (description != null) 'description': description,
      if (viewedAt != null) 'viewed_at': viewedAt,
      if (isDarkTheme != null) 'is_dark_theme': isDarkTheme,
    });
  }

  ViewedImagesCompanion copyWith(
      {Value<int>? id,
      Value<String>? url,
      Value<String>? name,
      Value<String>? title,
      Value<String>? origin,
      Value<String>? description,
      Value<DateTime>? viewedAt,
      Value<bool>? isDarkTheme}) {
    return ViewedImagesCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      name: name ?? this.name,
      title: title ?? this.title,
      origin: origin ?? this.origin,
      description: description ?? this.description,
      viewedAt: viewedAt ?? this.viewedAt,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<DateTime>(viewedAt.value);
    }
    if (isDarkTheme.present) {
      map['is_dark_theme'] = Variable<bool>(isDarkTheme.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViewedImagesCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('name: $name, ')
          ..write('title: $title, ')
          ..write('origin: $origin, ')
          ..write('description: $description, ')
          ..write('viewedAt: $viewedAt, ')
          ..write('isDarkTheme: $isDarkTheme')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ViewedImagesTable viewedImages = $ViewedImagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [viewedImages];
}

typedef $$ViewedImagesTableCreateCompanionBuilder = ViewedImagesCompanion
    Function({
  Value<int> id,
  required String url,
  Value<String> name,
  Value<String> title,
  Value<String> origin,
  Value<String> description,
  Value<DateTime> viewedAt,
  Value<bool> isDarkTheme,
});
typedef $$ViewedImagesTableUpdateCompanionBuilder = ViewedImagesCompanion
    Function({
  Value<int> id,
  Value<String> url,
  Value<String> name,
  Value<String> title,
  Value<String> origin,
  Value<String> description,
  Value<DateTime> viewedAt,
  Value<bool> isDarkTheme,
});

class $$ViewedImagesTableFilterComposer
    extends Composer<_$AppDatabase, $ViewedImagesTable> {
  $$ViewedImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get viewedAt => $composableBuilder(
      column: $table.viewedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDarkTheme => $composableBuilder(
      column: $table.isDarkTheme, builder: (column) => ColumnFilters(column));
}

class $$ViewedImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ViewedImagesTable> {
  $$ViewedImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get viewedAt => $composableBuilder(
      column: $table.viewedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDarkTheme => $composableBuilder(
      column: $table.isDarkTheme, builder: (column) => ColumnOrderings(column));
}

class $$ViewedImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ViewedImagesTable> {
  $$ViewedImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get viewedAt =>
      $composableBuilder(column: $table.viewedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDarkTheme => $composableBuilder(
      column: $table.isDarkTheme, builder: (column) => column);
}

class $$ViewedImagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ViewedImagesTable,
    ViewedImage,
    $$ViewedImagesTableFilterComposer,
    $$ViewedImagesTableOrderingComposer,
    $$ViewedImagesTableAnnotationComposer,
    $$ViewedImagesTableCreateCompanionBuilder,
    $$ViewedImagesTableUpdateCompanionBuilder,
    (
      ViewedImage,
      BaseReferences<_$AppDatabase, $ViewedImagesTable, ViewedImage>
    ),
    ViewedImage,
    PrefetchHooks Function()> {
  $$ViewedImagesTableTableManager(_$AppDatabase db, $ViewedImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ViewedImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ViewedImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ViewedImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> viewedAt = const Value.absent(),
            Value<bool> isDarkTheme = const Value.absent(),
          }) =>
              ViewedImagesCompanion(
            id: id,
            url: url,
            name: name,
            title: title,
            origin: origin,
            description: description,
            viewedAt: viewedAt,
            isDarkTheme: isDarkTheme,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String url,
            Value<String> name = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> viewedAt = const Value.absent(),
            Value<bool> isDarkTheme = const Value.absent(),
          }) =>
              ViewedImagesCompanion.insert(
            id: id,
            url: url,
            name: name,
            title: title,
            origin: origin,
            description: description,
            viewedAt: viewedAt,
            isDarkTheme: isDarkTheme,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ViewedImagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ViewedImagesTable,
    ViewedImage,
    $$ViewedImagesTableFilterComposer,
    $$ViewedImagesTableOrderingComposer,
    $$ViewedImagesTableAnnotationComposer,
    $$ViewedImagesTableCreateCompanionBuilder,
    $$ViewedImagesTableUpdateCompanionBuilder,
    (
      ViewedImage,
      BaseReferences<_$AppDatabase, $ViewedImagesTable, ViewedImage>
    ),
    ViewedImage,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ViewedImagesTableTableManager get viewedImages =>
      $$ViewedImagesTableTableManager(_db, _db.viewedImages);
}
