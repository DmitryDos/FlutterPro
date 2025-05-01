// database.dart
import 'dart:io';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pro/data/image_dto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class ViewedImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get url => text()();
  TextColumn get name => text().withDefault(const Constant('Not Set'))();
  TextColumn get title => text().withDefault(const Constant('Not Set'))();
  TextColumn get origin => text().withDefault(const Constant('Not Set'))();
  TextColumn get description => text().withDefault(const Constant('Not Set'))();
  DateTimeColumn get viewedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDarkTheme => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [ViewedImages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> saveViewedImage(
      final UniqueImageDTO image, final bool isDarkTheme) async {
    final file = await _saveImageLocally(image.url);

    await into(viewedImages).insert(
      ViewedImagesCompanion.insert(
        viewedAt: Value(image.date),
        url: file.path,
        name: Value(image.name),
        title: Value(image.title),
        origin: Value(image.origin),
        description: Value(image.description),
        isDarkTheme: Value(isDarkTheme),
      ),
    );
  }

  Future<File> _saveImageLocally(final String imageUrl) async {
    final cacheManager = DefaultCacheManager();
    final file = await cacheManager.getSingleFile(imageUrl);

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(imageUrl);
    final localFile = File('${appDir.path}/images/$fileName');

    await localFile.parent.create(recursive: true);
    await file.copy(localFile.path);

    return localFile;
  }

  Future<List<UniqueImageDTO>> getRandomImages(
      final bool isDarkTheme, final int limit) async {
    final countQuery = select(viewedImages)
      ..where((final t) => t.isDarkTheme.equals(isDarkTheme));

    final totalCount =
        await countQuery.get().then((final items) => items.length);

    if (totalCount == 0) return [];

    final randomOffset = Random().nextInt(max(1, totalCount - limit));

    final query = select(viewedImages)
      ..where((final t) => t.isDarkTheme.equals(isDarkTheme))
      ..limit(limit, offset: randomOffset);

    final images = await query.get();

    return images
        .map((final img) => UniqueImageDTO(
              date: img.viewedAt,
              url: img.url,
              name: img.name,
              title: img.title,
              origin: img.origin,
              description: img.description,
            ))
        .toList();
  }

  Future<List<UniqueImageDTO>> getImages() async {
    final query = select(viewedImages);

    final totalCount = await query.get().then((final items) => items.length);

    if (totalCount == 0) return [];

    final images = await query.get();

    return images
        .map((final img) => UniqueImageDTO(
              date: img.viewedAt,
              url: img.url,
              name: img.name,
              title: img.title,
              origin: img.origin,
              description: img.description,
            ))
        .toList();
  }

  Future<void> removeImage(final UniqueImageDTO image) async {
    final query = delete(viewedImages)
      ..where((final tbl) =>
          tbl.url.equals(image.url) & tbl.viewedAt.equals(image.date));

    await query.go();
  }

  Future<void> clear() async {
    final query = delete(viewedImages);

    await query.go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'images.db'));
    return NativeDatabase(file);
  });
}
