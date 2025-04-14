import 'package:flutter/material.dart';
import 'package:flutter_pro/widgets/interactive/footer_button.dart';
import '../../utils/utils.dart';

class Links extends StatelessWidget {
  const Links({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FooterButton(
              icon: Icons.telegram,
              text: screenWidth > 450 ? "Telegram" : "",
              onPressed: () {
                launchURL("https://t.me/belldh");
              },
            ),
            const SizedBox(width: 8),
            FooterButton(
              icon: Icons.code,
              text: screenWidth > 450 ? "GitHub" : "",
              onPressed: () {
                launchURL("https://github.com/DmitryDos");
              },
            ),
            const SizedBox(width: 8),
            FooterButton(
              icon: Icons.forum,
              text: screenWidth > 450 ? "Chanel" : "",
              onPressed: () {
                launchURL("https://t.me/beiidh");
              },
            ),
          ],
        ),
      ),
    );
  }
}
