// card_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_pro/data/image_dto.dart';
import 'package:flutter_pro/providers/user_provider.dart';
import 'package:flutter_pro/services/image_service.dart';

class CardsModel {
  final List<ImageDTO> _images = [];
  final List<ImageDTO> _lightImageCache = [];
  final List<ImageDTO> _darkImageCache = [];
  final int _cacheThreshold = 6;

  CardsModel();

  List<ImageDTO> get images => _images;

  List<ImageDTO> get lightImageCache => _lightImageCache;

  List<ImageDTO> get darkImageCache => _darkImageCache;

  ImageDTO top() {
    return _images[0];
  }

  Future<void> preloadWelcomeCard() async {
    _images.add(ImageDTO(url: 'preload'));
    await UserData.instance.loadData();
    await preloadCards();
  }

  Future<void> preloadFirstCard() async {
    ImageDTO? newImage = getFromCache();

    if (newImage != null) {
      _images.add(newImage);
      return;
    }

    final url = ImageService.getUrl();
    final images = await ImageService.fetchRandomImages(
      url: url,
      count: 1,
      onError: (final error) => debugPrint(error),
    );
    if (images != null && images.isNotEmpty) {
      newImage = images[0];
    }

    if (newImage != null) {
      _images.add(newImage);
    }
    await preloadCards();
  }

  Future<void> preloadCards() async {
    final newImages = await ImageService.fetchRandomImages(
      url: ImageService.getUrl(count: _cacheThreshold),
      count: _cacheThreshold,
      onError: (final error) => debugPrint(error),
    );

    if (newImages != null) {
      _images.addAll(newImages);
    }

    await populateCache();
  }

  Future<void> populateCache() async {
    final cache =
        UserData.instance.darkTheme ? _darkImageCache : _lightImageCache;

    if (cache.length >= 2 * _cacheThreshold) return;

    final images = await ImageService.fetchRandomImages(
      url: ImageService.getUrl(count: _cacheThreshold),
      count: _cacheThreshold,
      onError: (final error) => debugPrint(error),
    );

    if (images != null) {
      cache.addAll(images);
    }
  }

  Future<void> fetchNewCard() async {
    final newImage = getFromCache();
    UserData.instance.incrementSwipes();

    if (newImage != null) {
      _images.add(newImage);
    }

    await populateCache();
  }

  ImageDTO? getFromCache() {
    final userData = UserData.instance;

    if (userData.darkTheme && _darkImageCache.isNotEmpty) {
      return _darkImageCache.removeAt(0);
    } else if (!userData.darkTheme && _lightImageCache.isNotEmpty) {
      return _lightImageCache.removeAt(0);
    }
    return null;
  }

  void clearImages() {
    _images.clear();
  }
}
