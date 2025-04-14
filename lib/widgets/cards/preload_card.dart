import 'dart:math';
import 'package:flutter/material.dart';

class PreloadCard extends StatefulWidget {
  final void Function(DragUpdateDetails) onDragUpdate;
  final void Function(DragEndDetails) onDragEnd;
  final double offsetX;
  final double offsetY;
  final double angle;

  const PreloadCard({
    super.key,
    required this.onDragUpdate,
    required this.onDragEnd,
    required this.offsetX,
    required this.offsetY,
    required this.angle,
  });

  @override
  PreloadCardState createState() => PreloadCardState();
}

class PreloadCardState extends State<PreloadCard> {
  bool _showSwipeText = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showSwipeText = true;
        });
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double padding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    final double cardHeight = min(screenHeight - 185 - padding, 700);
    const threshold = 500;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transform: Matrix4.identity()
        ..translate(widget.offsetX, widget.offsetY)
        ..rotateZ(widget.angle * pi / 6),
      child: GestureDetector(
        onPanUpdate: widget.onDragUpdate,
        onPanEnd: widget.onDragEnd,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.pink[100]!.withAlpha(100),
                  Colors.blue[100]!.withAlpha(100),
                ],
              ),
            ),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/backgrounds/preloadGround.jpg',
                        width: cardHeight * 4 / 7,
                        height: cardHeight,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: -75,
                        height: 200,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/catL.png',
                          width: cardHeight * 4 / 7,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: _buildHeart(20),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: _buildHeart(24),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: _buildHeart(18),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: _buildHeart(22),
                      ),
                      Positioned(
                        top: 50,
                        left: 30,
                        child: _buildHeart(16),
                      ),
                      Positioned(
                        top: 80,
                        right: 40,
                        child: _buildHeart(20),
                      ),
                      Positioned(
                        bottom: 60,
                        left: 40,
                        child: _buildHeart(18),
                      ),
                      Positioned(
                        bottom: 90,
                        right: 30,
                        child: _buildHeart(22),
                      ),
                      SizedBox(
                        width: cardHeight * 4 / 7,
                        height: cardHeight,
                        child: Center(
                          child: Text(
                            'Загружаем\nмурчание\nи\nлюбовь!',
                            style: TextStyle(
                              color: Colors.purple[100]!,
                              fontSize: cardHeight > threshold ? 36 : 24,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withAlpha(125),
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -75,
                        height: 200,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/catD.png',
                          width: cardHeight * 4 / 7,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        right: 20,
                        child: AnimatedOpacity(
                          opacity: _showSwipeText ? 1.0 : 0.0, // Прозрачность
                          duration: const Duration(
                              milliseconds: 500), // Длительность анимации
                          child: Center(
                            child: Text(
                              'Свайпните, чтобы начать',
                              style: TextStyle(
                                color: Colors.white.withAlpha(150),
                                fontSize: cardHeight > threshold ? 24 : 18,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2,
                                    color: Colors.black.withAlpha(50),
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
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
    );
  }

  Widget _buildHeart(final double size) {
    return Image.asset(
      'assets/images/heart.png',
      width: size,
      height: size,
      color: Colors.pink.withAlpha(200),
    );
  }
}
