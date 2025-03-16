import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_pro/header.dart';
import 'package:flutter_pro/pulsular_loader.dart';
import 'package:flutter_pro/data/user_data.dart';
import 'package:flutter_pro/utils/utils.dart';
import 'package:provider/provider.dart';
import 'cards/card_provider.dart';
import 'footer.dart';
import 'image_service.dart';
import 'menu.dart';
import 'descriptions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return ChangeNotifierProvider(
      create: (final context) => UserData.instance,
      child: MaterialApp(
        title: 'Cat Tinder',
        theme: ThemeData.dark(),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _images = [];
  final List<Map<String, String>> _lightImageCache = [];
  final List<Map<String, String>> _darkImageCache = [];

  final int _cacheThreshold = 6;

  bool isLoading = false;

  double offsetX = 0;
  double offsetY = 0;
  double angle = 0;

  final ScrollController _scrollController = ScrollController();
  double _savedScrollPosition = 0.0;

  void _onBackgroundChanged(final String background) {
    UserData.instance.setBackground(background);

    _savedScrollPosition = _scrollController.offset;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder<void>(
        pageBuilder:
            (final context, final animation, final secondaryAnimation) => Menu(
          onBackgroundChanged: _onBackgroundChanged,
          scrollController: _scrollController,
        ),
        transitionsBuilder: (final context, final animation,
            final secondaryAnimation, final child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_savedScrollPosition);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _preloadWelcomeCard();
  }

  Future<void> _preloadWelcomeCard() async {
    _images.add({
      'url': 'preload',
    });
    await UserData.instance.loadData();
    _preloadCards();
  }

  Future<void> _preloadFirstCard() async {
    setState(() => isLoading = true);

    Map<String, String>? newImage = getFromCache();

    if (newImage == null) {
      final url = ImageService.getUrl();
      final images = await ImageService.fetchRandomImages(url, 1);
      if (images != null && images.isNotEmpty) {
        newImage = images[0];
      }
    }

    if (newImage != null) {
      setState(() {
        _images.add(newImage!);
        isLoading = false;
      });
      await _preloadCards();
    }
  }

  Future<void> _preloadCards() async {
    final List<Map<String, String>>? newImages =
        await ImageService.fetchRandomImages(
            ImageService.getUrl(count: _cacheThreshold), 5);

    if (newImages != null) {
      setState(() {
        _images.addAll(newImages);
      });
    }

    await _populateCache();
  }

  Future<void> _populateCache() async {
    final cache =
        UserData.instance.darkTheme ? _darkImageCache : _lightImageCache;
    if (cache.length >= _cacheThreshold) return;

    final url = ImageService.getUrl(count: _cacheThreshold);
    final images = await ImageService.fetchRandomImages(url, _cacheThreshold);

    if (images != null) {
      setState(() {
        cache.addAll(images);
      });
    }
  }

  Future<void> _fetchNewCard() async {
    final Map<String, String>? newImage = getFromCache();

    UserData.instance.incrementSwipes();
    if (newImage != null) {
      setState(() {
        _images.add(newImage);
      });
    }

    await _populateCache();
  }

  Map<String, String>? getFromCache() {
    Map<String, String>? newImage;

    if (UserData.instance.darkTheme && _darkImageCache.isNotEmpty) {
      newImage = _darkImageCache.removeAt(0);
    } else if (!UserData.instance.darkTheme && _lightImageCache.isNotEmpty) {
      newImage = _lightImageCache.removeAt(0);
    }

    return newImage;
  }

  void changeTheme() {
    UserData.instance.toggleDarkTheme();
    setState(() {
      _images.clear();
      _preloadFirstCard();
    });
  }

  void onDragUpdate(final DragUpdateDetails details) {
    setState(() {
      offsetX += details.delta.dx;
      offsetY += details.delta.dy;
      angle = offsetX / 500;
    });
  }

  void onDragEnd(final DragEndDetails details) {
    const double swipeThreshold = 100;
    if (offsetX.abs() > swipeThreshold) {
      afterSwipe(offsetX > 0 ? 1 : -1);
    } else {
      resetCardPosition();
    }
  }

  void afterSwipe(final int isLiked) {
    if (offsetX == 0 || offsetY == 0) {
      setState(() {
        offsetX = isLiked > 0
            ? 500
            : isLiked < 0
                ? -500
                : 0;
        angle = isLiked > 0
            ? 0.7
            : isLiked < 0
                ? -0.7
                : 0;
      });
    }

    if (isLiked == 1) {
      UserData.instance.incrementLikes();
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        if (_images.isNotEmpty) {
          _images.removeAt(0);
        }
        resetCardPosition();
      });

      if (_images.length < 2) {
        _preloadCards();
      }
      _fetchNewCard();
    });
  }

  void resetCardPosition() {
    setState(() {
      offsetX = 0;
      offsetY = 0;
      angle = 0;
    });
  }

  void openDescription() {
    setState(() {
      Navigator.push(
        context,
        PageRouteBuilder<void>(
          pageBuilder:
              (final context, final animation, final secondaryAnimation) =>
                  ImageDescriptionScreen(imageData: _images.first),
          transitionsBuilder: (final context, final animation,
              final secondaryAnimation, final child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  void openMenu() {
    Navigator.push(
      context,
      PageRouteBuilder<void>(
        pageBuilder:
            (final context, final animation, final secondaryAnimation) => Menu(
          onBackgroundChanged: _onBackgroundChanged,
          scrollController: _scrollController,
        ),
        transitionsBuilder: (final context, final animation,
            final secondaryAnimation, final child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: isHexColor(userData.selectedBackground)
                ? BoxDecoration(
                    color: Color(
                        int.parse(userData.selectedBackground, radix: 16)),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: getImageProvider(userData.selectedBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  offsetX < 0
                      ? Colors.red.withAlpha(min(offsetX.abs().floor(), 180))
                      : Colors.transparent,
                  offsetX > 0
                      ? Colors.green.withAlpha(min(offsetX.abs().floor(), 180))
                      : Colors.transparent,
                ],
              ),
            ),
          ),
          Header(openMenu: openMenu),
          Center(
            child: isLoading
                ? PulsatingCircle(
                    color: userData.darkTheme ? Colors.pink : Colors.purple)
                : Stack(children: [
                    for (var i = 0; i < _images.length; i++)
                      getCard(
                        imageData: _images[_images.length - i - 1],
                        number: _images.length - i - 1,
                        openDescription: openDescription,
                        onDragUpdate: onDragUpdate,
                        onDragEnd: onDragEnd,
                        offsetX: offsetX,
                        offsetY: offsetY,
                        angle: angle,
                        darkTheme: userData.darkTheme,
                        isAnimated: userData.isCardAnimated,
                      ),
                  ]),
          ),
          Footer(
            images: _images,
            darkTheme: userData.darkTheme,
            afterSwipe: afterSwipe,
            changeTheme: changeTheme,
          ),
        ],
      ),
    );
  }
}
