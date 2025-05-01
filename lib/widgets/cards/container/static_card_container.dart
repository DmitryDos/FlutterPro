import 'dart:math';
import 'package:flutter/material.dart';

class StaticCardContainer extends StatelessWidget {
  final Widget child;
  final bool isTopCard;
  final void Function()? onTap;
  final void Function(DragUpdateDetails)? onDragUpdate;
  final void Function(DragEndDetails)? onDragEnd;
  final double height;
  final Gradient gradient;
  final double offsetX;
  final double offsetY;
  final double angle;

  const StaticCardContainer({
    super.key,
    required this.child,
    required this.isTopCard,
    this.onTap,
    this.onDragUpdate,
    this.onDragEnd,
    required this.height,
    required this.gradient,
    required this.offsetX,
    required this.offsetY,
    required this.angle,
  });

  @override
  Widget build(final BuildContext context) {
    return AnimatedScale(
      scale: isTopCard ? 1 : 0.95,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: isTopCard ? onTap : null,
        onPanUpdate: isTopCard ? onDragUpdate : null,
        onPanEnd: isTopCard ? onDragEnd : null,
        child: Transform.translate(
          offset: isTopCard ? Offset(offsetX, offsetY) : Offset.zero,
          child: Transform.rotate(
            angle: isTopCard ? angle * pi / 6 : 0,
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
      ),
    );
  }
}
