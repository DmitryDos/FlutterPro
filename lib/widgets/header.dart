import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final void Function() openMenu;
  final void Function() openHistory;

  const Header({
    super.key,
    required this.openMenu,
    required this.openHistory,
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
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, size: 30, color: Colors.white),
              color: Colors.blueGrey[800],
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (final String value) {
                if (value == 'settings') {
                  openMenu();
                } else if (value == 'gallery') {
                  openHistory();
                }
              },
              itemBuilder: (final BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.list, color: Colors.amber),
                        SizedBox(width: 10),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'gallery',
                    child: Row(
                      children: [
                        Icon(Icons.history, color: Colors.amber),
                        SizedBox(width: 10),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
