import 'package:flutter/material.dart';

class PulsatingCircle extends StatefulWidget {
  final Color color;
  const PulsatingCircle({
    super.key,
    required this.color,
  });

  @override
  PulsatingCircleState createState() => PulsatingCircleState();
}

class PulsatingCircleState extends State<PulsatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (final context, final child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withAlpha(150),
            ),
          ),
        );
      },
    );
  }
}
