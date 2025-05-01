import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedCardContainer extends StatelessWidget {
  final Widget child;
  final bool isTopCard;
  final void Function()? onTap;
  final void Function(DragUpdateDetails)? onDragUpdate;
  final void Function(DragEndDetails)? onDragEnd;
  final double offsetX;
  final double offsetY;
  final double angle;
  final double height;
  final Gradient gradient;

  const AnimatedCardContainer({
    super.key,
    required this.child,
    required this.isTopCard,
    this.onTap,
    this.onDragUpdate,
    this.onDragEnd,
    required this.offsetX,
    required this.offsetY,
    required this.angle,
    required this.height,
    required this.gradient,
  });

  @override
  Widget build(final BuildContext context) {
    return Visibility(
      visible: isTopCard,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(offsetX, offsetY)
          ..rotateZ(angle * pi / 6),
        child: GestureDetector(
          onTap: isTopCard ? onTap : null,
          onPanUpdate: isTopCard ? onDragUpdate : null,
          onPanEnd: isTopCard ? onDragEnd : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: gradient,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: height,
                    width: height * 4 / 7,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
