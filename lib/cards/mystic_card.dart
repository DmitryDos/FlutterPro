import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter_pro/pulsular_loader.dart';

class MysticCard extends StatelessWidget {
  final Map<String, String> imageData;
  final bool isTopCard;
  final void Function() openDescription;
  final void Function(DragUpdateDetails) onDragUpdate;
  final void Function(DragEndDetails) onDragEnd;
  final double offsetX;
  final double offsetY;
  final double angle;

  const MysticCard({
    super.key,
    required this.imageData,
    required this.isTopCard,
    required this.openDescription,
    required this.onDragUpdate,
    required this.onDragEnd,
    required this.offsetX,
    required this.offsetY,
    required this.angle,
  });

  @override
  Widget build(final BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double padding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    final double cardHeight = min(screenHeight - 185 - padding, 700);
    const threshold = 600;

    return AnimatedScale(
      scale: isTopCard ? 1 : 0.95,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: isTopCard ? openDescription : null,
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
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withAlpha(200),
                      Colors.deepPurple.withAlpha(200),
                    ],
                  ),
                ),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: imageData['url'] ?? '',
                          width: cardHeight * 4 / 7,
                          height: cardHeight,
                          fit: BoxFit.cover,
                          placeholder: (final context, final url) =>
                              const Center(
                            child: PulsatingCircle(color: Colors.purple),
                          ),
                          errorWidget:
                              (final context, final url, final error) =>
                                  const Icon(Icons.error),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Opacity(
                            opacity: 0.6,
                            child: Image.asset(
                              'assets/images/paw_print.png',
                              width: cardHeight / 14,
                              height: cardHeight / 14,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: cardHeight > threshold ? 20 : 5,
                          left: cardHeight > threshold ? 20 : 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Верхний блок (Имя)
                              Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(
                                      cardHeight > threshold ? 12 : 6),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    imageData['name'] ?? "No Name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          cardHeight > threshold ? 24 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: cardHeight > threshold
                                    ? 300
                                    : cardHeight / 7 * 4 - 16,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(
                                      cardHeight > threshold ? 12 : 6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      imageData['origin'] ?? 'Not Set',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            cardHeight > threshold ? 14 : 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      imageData['title'] ?? 'Not Set',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            cardHeight > threshold ? 14 : 10,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              if (cardHeight > threshold)
                                const SizedBox(height: 10),
                              if (cardHeight > threshold)
                                const Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 20),
                                    SizedBox(width: 5),
                                    Icon(Icons.nights_stay,
                                        color: Colors.blue, size: 20),
                                    SizedBox(width: 5),
                                    Icon(Icons.auto_awesome,
                                        color: Colors.purple, size: 20),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
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
