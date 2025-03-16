import 'package:flutter/material.dart';
import 'package:flutter_pro/data/user_data.dart';

import 'download_button.dart';

class Footer extends StatefulWidget {
  final List<Map<String, String>> images;
  final bool darkTheme;

  final void Function(int) afterSwipe;
  final void Function() changeTheme;

  const Footer({
    super.key,
    required this.images,
    required this.darkTheme,
    required this.afterSwipe,
    required this.changeTheme,
  });

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isApproveButtonActive = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _onTapDown() {
    setState(() {
      _isApproveButtonActive = true;
    });
    _controller.forward();
  }

  void _onTapUp() {
    _controller.reverse().then((final _) {
      setState(() {
        _isApproveButtonActive = false;
      });
      widget.afterSwipe(1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60 + padding.bottom,
            padding: EdgeInsets.only(bottom: padding.bottom),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Center(
              child: SizedBox(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShareImageButton(images: widget.images),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => widget.afterSwipe(-1),
                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/cross.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(100),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.withAlpha(130)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.favorite,
                              color: Colors.red, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            UserData.instance.likes,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.favorite,
                              color: Colors.red, size: 30),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: widget.changeTheme,
                      child: SizedBox(
                        width: 35,
                        height: 50,
                        child: Image.asset(
                          widget.darkTheme
                              ? 'assets/images/lModeD_L.png'
                              : 'assets/images/lModeL_L.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: -30,
          child: GestureDetector(
            onTapDown: (final _) => _onTapDown(),
            onTapUp: (final _) => _onTapUp(),
            onTapCancel: () {
              _controller.reverse();
              setState(() {
                _isApproveButtonActive = false;
              });
            },
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (final context, final child) {
                return Transform.scale(
                  scale: _isApproveButtonActive ? _scaleAnimation.value : 1.0,
                  child: child,
                );
              },
              child: Container(
                width: 120,
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  fit: BoxFit.cover,
                  'assets/images/fire.png',
                  width: 64,
                  height: 64,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
