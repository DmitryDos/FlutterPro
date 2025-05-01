import 'package:flutter/material.dart';

class ErrorCardContent extends StatefulWidget {
  final double height;
  final bool showSwipeText;
  final double threshold;
  final Map<String, dynamic>? contentProps;

  const ErrorCardContent({
    super.key,
    required this.height,
    this.showSwipeText = false,
    this.threshold = 400,
    this.contentProps,
  });

  @override
  State<ErrorCardContent> createState() => _ErrorCardContentState();
}

class _ErrorCardContentState extends State<ErrorCardContent> {
  bool isDontShowAgainClicked = false;

  @override
  Widget build(final BuildContext context) {
    final cardWidth = widget.height * 4 / 7;
    final isLarge = widget.height > widget.threshold;

    return SizedBox(
      width: cardWidth,
      height: widget.height,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2E1A1A),
                Color(0xFF3E1616),
              ],
            ),
            boxShadow: [
              const BoxShadow(
                color: Color(0x4B000000),
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              const Positioned(
                top: -50,
                right: -30,
                child: Icon(
                  Icons.error_outline,
                  size: 200,
                  color: Color(0x0AFFFFFF),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(isLarge ? 32 : 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Похоже, у нас проболемы!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Закончились котики, готовые к показу! '
                        'Проверьте подключение к интернету или зайдите позже.',
                        style: TextStyle(
                          color: const Color(0xCCFFFFFF),
                          fontSize: isLarge ? 16 : 14,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.showSwipeText)
                const Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      _SwipeHintText(),
                      SizedBox(height: 8),
                      _SwipeIcon(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwipeHintText extends StatelessWidget {
  const _SwipeHintText();

  @override
  Widget build(final BuildContext context) {
    return const Text(
      'Свайпните в сторону',
      style: TextStyle(
        color: Color(0xB3FFFFFF),
        fontSize: 16,
      ),
    );
  }
}

class _SwipeIcon extends StatelessWidget {
  const _SwipeIcon();

  @override
  Widget build(final BuildContext context) {
    return const Icon(
      Icons.swipe,
      color: Color(0xB3FFFFFF),
      size: 30,
    );
  }
}
