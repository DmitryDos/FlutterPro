import 'package:flutter/material.dart';
import 'package:flutter_pro/data/image_dto.dart';
import 'package:flutter_pro/providers/user_provider.dart';
import 'package:flutter_pro/services/image_service.dart';
import 'package:flutter_pro/services/cached_images_service.dart';

class CardsModel {
  var isOnline = true;
  final List<ImageDTO> _images = [];
  final List<ImageDTO> _lightImageQueue = [];
  final List<ImageDTO> _darkImageQueue = [];
  final int _queueThreshold = 6;
  final CachedImagesService _cacheService;

  CardsModel({required final CachedImagesService cacheService})
      : _cacheService = cacheService;

  List<ImageDTO> get images => _images;
  List<ImageDTO> get lightImageQueue => _lightImageQueue;
  List<ImageDTO> get darkImageQueue => _darkImageQueue;

  ImageDTO top() {
    if (_images.isNotEmpty) {
      return _images[0];
    }
    return ImageDTO(url: 'error');
  }

  Future<void> preloadWelcomeCard() async {
    _images.add(ImageDTO(url: 'preload'));
    await UserData.instance.loadData();
    await preloadCards();
  }

  Future<List<ImageDTO>> getCards(final int limit) async {
    final hasInternet = await _cacheService.hasInternetConnection;
    checkInternet(hasInternet);

    final fromQueue = _getFromQueue(limit);
    if (fromQueue.isNotEmpty) {
      return fromQueue;
    }

    if (hasInternet) {
      try {
        final fromNetwork = await ImageService.fetchRandomImages(
          url: ImageService.getUrl(count: limit),
          count: limit,
          onError: (final error) => debugPrint('Network error: $error'),
        );

        if (fromNetwork != null && fromNetwork.isNotEmpty) {
          return fromNetwork;
        }
      } catch (e) {
        return [ImageDTO(url: 'error')];
      }
    }

    final fromCache = await _getFromCache(limit);
    if (fromCache.isNotEmpty) {
      return fromCache;
    }
    return [ImageDTO(url: 'error')];
  }

  Future<void> preloadFirstCard() async {
    final cards = await getCards(1);
    if (cards.isNotEmpty) {
      _images.add(cards.first);
    }
    await preloadCards();
  }

  Future<void> preloadCards() async {
    final newCards = await getCards(_queueThreshold);
    if (newCards.isNotEmpty) {
      _images.addAll(newCards);
    }
  }

  Future<void> fetchNewCard() async {
    UserData.instance.incrementSwipes();
    final newCard = (await getCards(1)).firstOrNull;
    if (newCard != null) {
      _images.add(newCard);
    }
    if (_images.isEmpty) {
      _images.add(ImageDTO(url: 'error'));
    }
    await _ensureQueueFilled();
  }

  List<ImageDTO> _getFromQueue(final int limit) {
    final queue =
        UserData.instance.darkTheme ? _darkImageQueue : _lightImageQueue;
    final count = limit.clamp(0, queue.length);
    return List.generate(count, (final i) => queue.removeAt(0));
  }

  Future<void> _addToQueue(final List<ImageDTO> images) async {
    final queue =
        UserData.instance.darkTheme ? _darkImageQueue : _lightImageQueue;
    queue.addAll(images);
  }

  Future<void> _ensureQueueFilled() async {
    final hasInternet = await _cacheService.hasInternetConnection;
    final queue =
        UserData.instance.darkTheme ? _darkImageQueue : _lightImageQueue;
    if (hasInternet && queue.length < _queueThreshold) {
      final fromNetwork = await ImageService.fetchRandomImages(
        url: ImageService.getUrl(count: _queueThreshold * 2),
        count: _queueThreshold * 2,
        onError: (final error) => debugPrint('Network error: $error'),
      );
      if (fromNetwork != null && fromNetwork.isNotEmpty) {
        _addToQueue(fromNetwork);
      }
    } else if (!hasInternet && queue.length < _queueThreshold) {
      final fromCache = await _getFromCache(_queueThreshold * 2);
      _addToQueue(fromCache);
    }
  }

  Future<List<ImageDTO>> _getFromCache(final int limit) async {
    final list = <ImageDTO>[];

    final fromCache = await _cacheService.getCachedImages(
      UserData.instance.darkTheme,
      limit,
    );

    if (UserData.instance.showInternetError) {
      list.add(ImageDTO(url: 'noInternet'));
    }

    list.addAll(fromCache);

    return list;
  }

  void checkInternet(final bool hasInternet) {
    if (isOnline != hasInternet) {
      isOnline = hasInternet;
      _lightImageQueue.clear();
      _darkImageQueue.clear();
      cleanUpImages();
    }
  }

  void clearImages() {
    _images.clear();
  }

  void cleanUpImages() {
    if (_images.isEmpty) return;
    final firstCard = top();
    _images.clear();
    _images.add(firstCard);
  }
}
