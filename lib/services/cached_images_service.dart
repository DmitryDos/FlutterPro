import 'package:flutter_pro/data/image_dto.dart';
import 'package:flutter_pro/data/datasources/database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CachedImagesService {
  final Connectivity _connectivity = Connectivity();
  late final AppDatabase _database;

  CachedImagesService() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = AppDatabase();
  }

  Future<bool> get hasInternetConnection async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> saveUImage(
      final UniqueImageDTO image, final bool isDarkTheme) async {
    await _database.saveViewedImage(image, isDarkTheme);
  }

  Future<void> saveImage(final ImageDTO image, final bool isDarkTheme) async {
    final uImage = UniqueImageDTO(
      date: DateTime.now(),
      url: image.url,
      title: image.title,
      description: image.description,
      name: image.name,
    );
    await saveUImage(uImage, isDarkTheme);
  }

  Future<void> removeUImage(final UniqueImageDTO image) async {
    await _database.removeImage(image);
  }

  Future<List<UniqueImageDTO>> getCachedImages(
      final bool isDarkTheme, final int limit) async {
    return await _database.getRandomImages(isDarkTheme, limit);
  }

  Future<List<UniqueImageDTO>> getImages() async {
    return await _database.getImages();
  }

  Future<void> clear() async {
    return await _database.clear();
  }
}
