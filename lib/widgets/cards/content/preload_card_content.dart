import 'package:flutter/material.dart';

class PreloadCardContent extends StatefulWidget {
  final double height;
  final bool initiallyShowSwipeText;
  final double threshold;

  const PreloadCardContent({
    super.key,
    required this.height,
    this.initiallyShowSwipeText = false,
    this.threshold = 500,
  });

  @override
  State<PreloadCardContent> createState() => _PreloadCardContentState();
}

class _PreloadCardContentState extends State<PreloadCardContent> {
  late bool _showSwipeText;

  @override
  void initState() {
    super.initState();
    _showSwipeText = widget.initiallyShowSwipeText;

    if (!_showSwipeText) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() => _showSwipeText = true);
        }
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    final cardWidth = widget.height * 4 / 7;

    return ClipRRect(
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
          width: cardWidth,
          height: widget.height,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  // Фоновое изображение
                  Image.asset(
                    'assets/backgrounds/preloadGround.jpg',
                    width: cardWidth,
                    height: widget.height,
                    fit: BoxFit.cover,
                  ),

                  // Верхний кот
                  Positioned(
                    top: -75,
                    height: 200,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/catL.png',
                      width: cardWidth,
                      fit: BoxFit.fitHeight,
                    ),
                  ),

                  // Сердечки
                  ..._buildHearts(),

                  // Центральный текст
                  Center(
                    child: Text(
                      'Загружаем\nмурчание\nи\nлюбовь!',
                      style: TextStyle(
                        color: Colors.purple[100]!,
                        fontSize: widget.height > widget.threshold ? 36 : 24,
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

                  // Нижний кот
                  Positioned(
                    bottom: -75,
                    height: 200,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/catD.png',
                      width: cardWidth,
                      fit: BoxFit.fitHeight,
                    ),
                  ),

                  // Текст свайпа
                  if (_showSwipeText)
                    Positioned(
                      bottom: 30,
                      left: 20,
                      right: 20,
                      child: AnimatedOpacity(
                        opacity: _showSwipeText ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Center(
                          child: Text(
                            'Свайпните, чтобы начать',
                            style: TextStyle(
                              color: Colors.white.withAlpha(150),
                              fontSize:
                                  widget.height > widget.threshold ? 24 : 18,
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
    );
  }

  List<Widget> _buildHearts() {
    return [
      Positioned(top: 10, left: 10, child: _buildHeart(20)),
      Positioned(top: 10, right: 10, child: _buildHeart(24)),
      Positioned(bottom: 10, left: 10, child: _buildHeart(18)),
      Positioned(bottom: 10, right: 10, child: _buildHeart(22)),
      Positioned(top: 50, left: 30, child: _buildHeart(16)),
      Positioned(top: 80, right: 40, child: _buildHeart(20)),
      Positioned(bottom: 60, left: 40, child: _buildHeart(18)),
      Positioned(bottom: 90, right: 30, child: _buildHeart(22)),
    ];
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
