import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_pro/models/cards_model.dart';
import 'package:flutter_pro/providers/cards_provider.dart';
import 'package:flutter_pro/widgets/header.dart';
import 'package:flutter_pro/widgets/interactive/background.dart';
import 'package:flutter_pro/widgets/list_screen.dart';
import 'package:flutter_pro/widgets/pulsular_loader.dart';
import 'package:flutter_pro/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'widgets/cards/card_provider.dart';
import 'widgets/footer.dart';
import 'widgets/menu_screen.dart';
import 'widgets/descriptions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (final context) => UserData.instance),
        ChangeNotifierProvider(
            create: (final context) => LikedCatsProvider.instance),
      ],
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
  final CardsModel _cardsModel = CardsModel();
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
    _cardsModel.preloadWelcomeCard();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeTheme() async {
    UserData.instance.toggleDarkTheme();
    _cardsModel.clearImages();
    isLoading = true;
    await _cardsModel.preloadFirstCard();
    setState(() {
      isLoading = false;
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

    if (isLiked == 1 && _cardsModel.top().url != 'preload') {
      UserData.instance.incrementLikes();
      LikedCatsProvider.instance.addCat(_cardsModel.top());
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        if (_cardsModel.images.isNotEmpty) {
          _cardsModel.images.removeAt(0);
        }
        resetCardPosition();
      });

      if (_cardsModel.images.length < 2) {
        _cardsModel.preloadCards();
      }
      _cardsModel.fetchNewCard();
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
                  ImageDescriptionScreen(imageData: _cardsModel.top()),
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

  void openHistory() {
    Navigator.push(
      context,
      PageRouteBuilder<void>(
        pageBuilder:
            (final context, final animation, final secondaryAnimation) =>
                const LikedCardsScreen(),
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
          Background(selectedBackground: userData.selectedBackground),
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
          Header(openMenu: openMenu, openHistory: openHistory),
          Center(
            child: isLoading
                ? PulsatingCircle(
                    color: userData.darkTheme ? Colors.pink : Colors.purple)
                : Stack(children: [
                    for (var i = 0; i < _cardsModel.images.length; i++)
                      getCard(
                        imageData: _cardsModel
                            .images[_cardsModel.images.length - i - 1],
                        number: _cardsModel.images.length - i - 1,
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
            images: _cardsModel.images,
            darkTheme: userData.darkTheme,
            afterSwipe: afterSwipe,
            changeTheme: changeTheme,
          ),
        ],
      ),
    );
  }
}
