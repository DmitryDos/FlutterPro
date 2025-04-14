import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class Background extends StatelessWidget {
  final String selectedBackground;

  const Background({
    super.key,
    required this.selectedBackground,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: isHexColor(selectedBackground)
          ? BoxDecoration(
              color: Color(
                  int.parse(selectedBackground.substring(1), radix: 16) +
                      0xFF000000),
            )
          : BoxDecoration(
              image: DecorationImage(
                image: getImageProvider(selectedBackground),
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
