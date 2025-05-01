import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pro/data/image_dto.dart';
import 'package:flutter_pro/providers/user_provider.dart';
import 'package:flutter_pro/widgets/cards/container/animated_card_container.dart';
import 'package:flutter_pro/widgets/cards/container/static_card_container.dart';
import 'package:flutter_pro/widgets/cards/content/error_card_content.dart';
import 'package:flutter_pro/widgets/cards/content/internet_card_content.dart';
import 'package:flutter_pro/widgets/cards/content/mystic_card_content.dart';
import 'package:flutter_pro/widgets/cards/content/preload_card_content.dart';
import 'package:flutter_pro/widgets/cards/content/simple_card_content.dart';

class CardFactory {
  static Widget create({
    required final ImageDTO imageData,
    required final int number,
    required final VoidCallback openDescription,
    required final void Function(DragUpdateDetails) onDragUpdate,
    required final void Function(DragEndDetails) onDragEnd,
    required final double offsetX,
    required final double offsetY,
    required final double angle,
    required final bool darkTheme,
    required final bool isAnimated,
    required final BuildContext context,
  }) {
    final cardType = determineCardType(imageData);

    final content = _createContent(
      cardType: cardType,
      imageData: imageData,
      context: context,
      darkTheme: darkTheme,
      contentProps: _setProps(cardType),
    );

    return _createContainer(
      cardType: cardType,
      content: content,
      isTopCard: isAnimated ? true : number == 0,
      openDescription:
          cardType == CardType.regular ? openDescription : () => {},
      onDragUpdate: onDragUpdate,
      onDragEnd: onDragEnd,
      offsetX: offsetX,
      offsetY: offsetY,
      angle: angle,
      isAnimated: isAnimated,
      darkTheme: darkTheme,
      context: context,
    );
  }

  static Map<String, dynamic>? _setProps(final CardType type) {
    final Map<String, dynamic> props = {};
    if (type == CardType.internet) {
      props['onDontShowAgain'] = UserData.instance.removeInternetErrorCard;
    }
    return props;
  }

  static CardType determineCardType(final ImageDTO imageData) {
    if (imageData.url == 'preload') return CardType.preload;
    if (imageData.url == 'noInternet') return CardType.internet;
    if (imageData.url == 'error') return CardType.error;
    return CardType.regular;
  }

  static Widget _createContent({
    required final CardType cardType,
    required final ImageDTO imageData,
    required final BuildContext context,
    required final bool darkTheme,
    final Map<String, dynamic>? contentProps,
  }) {
    final cardHeight = _calculateCardHeight(context);

    switch (cardType) {
      case CardType.preload:
        return PreloadCardContent(height: cardHeight);
      case CardType.internet:
        return InternetCardContent(
            height: cardHeight, contentProps: contentProps);
      case CardType.error:
        return ErrorCardContent(height: cardHeight);
      case CardType.regular:
        return darkTheme
            ? SimpleCardContent(imageData: imageData, height: cardHeight)
            : MysticCardContent(imageData: imageData, height: cardHeight);
    }
  }

  static Widget _createContainer({
    required final CardType cardType,
    required final Widget content,
    required final bool isTopCard,
    required final VoidCallback openDescription,
    required final void Function(DragUpdateDetails) onDragUpdate,
    required final void Function(DragEndDetails) onDragEnd,
    required final double offsetX,
    required final double offsetY,
    required final double angle,
    required final bool isAnimated,
    required final bool darkTheme,
    required final BuildContext context,
  }) {
    final cardHeight = _calculateCardHeight(context);
    final gradient = darkTheme ? _darkThemeGradient() : _lightThemeGradient();

    return isAnimated
        ? AnimatedCardContainer(
            isTopCard: isTopCard,
            onTap: openDescription,
            onDragUpdate: onDragUpdate,
            onDragEnd: onDragEnd,
            height: cardHeight,
            gradient: gradient,
            offsetX: offsetX,
            offsetY: offsetY,
            angle: angle,
            child: content,
          )
        : StaticCardContainer(
            isTopCard: isTopCard,
            onTap: openDescription,
            onDragUpdate: onDragUpdate,
            onDragEnd: onDragEnd,
            height: cardHeight,
            gradient: gradient,
            offsetX: offsetX,
            offsetY: offsetY,
            angle: angle,
            child: content,
          );
  }

  static double _calculateCardHeight(final BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    return min(screenHeight - 185 - padding, 700);
  }

  static Gradient _darkThemeGradient() => LinearGradient(
        colors: [
          Colors.pink[100]!.withAlpha(200),
          Colors.blue[100]!.withAlpha(200)
        ],
      );

  static Gradient _lightThemeGradient() => LinearGradient(
        colors: [
          Colors.purple.withAlpha(200),
          Colors.deepPurple.withAlpha(200)
        ],
      );
}

enum CardType { preload, internet, regular, error }
