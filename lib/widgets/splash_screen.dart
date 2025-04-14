import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Анимированная лапка
                _PawPrintAnimation(),
                const SizedBox(height: 30),
                Text(
                  'КотоТиндер',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Pre-loading cards for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),
                _CustomProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _PawPrintAnimation extends StatefulWidget {
  @override
  __PawPrintAnimationState createState() => __PawPrintAnimationState();
}

class __PawPrintAnimationState extends State<_PawPrintAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _pawController;

  @override
  void initState() {
    super.initState();
    _pawController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: _pawController,
      builder: (final context, final child) {
        return Transform.scale(
          scale: 1 + _pawController.value * 0.1,
          child: const Icon(
            Icons.pets,
            size: 80,
            color: Colors.pink,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pawController.dispose();
    super.dispose();
  }
}

class _CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          minHeight: 12,
          backgroundColor: Colors.pink[100],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[400]!),
        ),
      ),
    );
  }
}
