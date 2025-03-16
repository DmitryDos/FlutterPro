import 'package:flutter/material.dart';
import 'package:flutter_pro/cards/preload_card.dart';

import 'animated_card.dart';
import 'animated_mystic_card.dart';
import 'card.dart';
import 'mystic_card.dart';

Widget getCard({
  required final dynamic imageData,
  required final int number,
  required final VoidCallback openDescription,
  required final void Function(DragUpdateDetails) onDragUpdate,
  required final void Function(DragEndDetails) onDragEnd,
  required final double offsetX,
  required final double offsetY,
  required final double angle,
  required final bool darkTheme,
  required final bool isAnimated,
}) {
  if (imageData['url'] == 'preload') {
    return PreloadCard(
      onDragUpdate: onDragUpdate,
      onDragEnd: onDragEnd,
      offsetX: offsetX,
      offsetY: offsetY,
      angle: angle,
    );
  }
  if (darkTheme) {
    return isAnimated
        ? AnimatedCatCard(
            imageData: imageData,
            isTopCard: true,
            openDescription: openDescription,
            onDragUpdate: onDragUpdate,
            onDragEnd: onDragEnd,
            offsetX: offsetX,
            offsetY: offsetY,
            angle: angle,
          )
        : CatCard(
            imageData: imageData,
            isTopCard: number == 0,
            openDescription: openDescription,
            onDragUpdate: onDragUpdate,
            onDragEnd: onDragEnd,
            offsetX: offsetX,
            offsetY: offsetY,
            angle: angle,
          );
  } else {
    return isAnimated
        ? AnimatedMysticCard(
            imageData: imageData,
            isTopCard: true,
            openDescription: openDescription,
            onDragUpdate: onDragUpdate,
            onDragEnd: onDragEnd,
            offsetX: offsetX,
            offsetY: offsetY,
            angle: angle,
          )
        : MysticCard(
            imageData: imageData,
            isTopCard: number == 0,
            openDescription: openDescription,
            onDragUpdate: onDragUpdate,
            onDragEnd: onDragEnd,
            offsetX: offsetX,
            offsetY: offsetY,
            angle: angle,
          );
  }
}
