import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final void Function() openMenu;

  const Header({
    super.key,
    required this.openMenu,
  });

  @override
  Widget build(final BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 70 + padding.top,
        padding: EdgeInsets.fromLTRB(12, padding.top, 12, 0),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(150),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 140,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const Expanded(child: SizedBox()),
            IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: openMenu,
            ),
          ],
        ),
      ),
    );
  }
}
