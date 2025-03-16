import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_pro/data/user_data.dart';
import 'package:flutter_pro/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  final void Function(String) onBackgroundChanged;
  final ScrollController scrollController;

  const Menu({
    super.key,
    required this.onBackgroundChanged,
    required this.scrollController,
  });

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  final String selectedBackground = UserData.instance.selectedBackground;
  final int backgroundsCount = 9;
  bool isAnimationEnabled = true;

  void _openColorPicker(final BuildContext context) {
    Color currentColor = isHexColor(selectedBackground)
        ? Color(int.parse(selectedBackground, radix: 16))
        : Colors.white;

    showDialog<void>(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите цвет'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (final Color color) {
                currentColor = color;
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Готово'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.onBackgroundChanged(
                      currentColor.toARGB32().toRadixString(16));
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        if (await File(image.path).exists()) {
          widget.onBackgroundChanged(image.path);
        } else {
          _showSnackBar("Error: The selected image file does not exist.");
        }
      }
    } catch (e) {
      _showSnackBar("Error picking image: $e");
    }
  }

  void _showSnackBar(final String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(final BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final padding = MediaQuery.of(context).padding;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: isHexColor(selectedBackground)
                ? BoxDecoration(
                    color: Color(int.parse(selectedBackground, radix: 16)),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: getImageProvider(selectedBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Статистика",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StatCard(label: "Свайпов", value: UserData.instance.swipes),
                  StatCard(label: "Лайков", value: UserData.instance.likes),
                  StatCard(
                      label: "Смен темы",
                      value: UserData.instance.themeChanges),
                  const SizedBox(height: 20),
                  ActionButton(
                      text: "Сбросить данные",
                      onPressed: () {
                        UserData.instance.resetStats();
                        setState(() {});
                      }),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      controller: widget.scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: backgroundsCount + 2,
                      itemBuilder: (final context, final index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              _openColorPicker(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isHexColor(selectedBackground)
                                      ? Colors.transparent
                                      : Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              child: const Icon(
                                Icons.color_lens,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else if (index == 1) {
                          return GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              child: const Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else {
                          final backgroundIndex = index - 2;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.onBackgroundChanged(
                                    "assets/backgrounds/ground$backgroundIndex.jpg");
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedBackground ==
                                          "assets/backgrounds/ground$backgroundIndex.jpg"
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  "assets/backgrounds/ground$backgroundIndex.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(width: 8),
                  FooterButton(
                    text: "Переключить анимацию карточек",
                    icon: isAnimationEnabled ? Icons.animation : Icons.pause,
                    onPressed: () {
                      setState(() {
                        isAnimationEnabled = !isAnimationEnabled;
                      });
                      userData.toggleCardAnimation();
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: padding.top + 16,
            right: 16,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // Footer with 3 buttons
          Positioned(
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
                    text: screenWidth > 400 ? "Telegram" : "",
                    onPressed: () {
                      launchURL("https://t.me/belldh");
                    },
                  ),
                  FooterButton(
                    icon: Icons.code,
                    text: screenWidth > 400 ? "GitHub" : "",
                    onPressed: () {
                      launchURL("https://github.com/DmitryDos");
                    },
                  ),
                  FooterButton(
                    icon: Icons.forum,
                    text: screenWidth > 400 ? "Chanel" : "",
                    onPressed: () {
                      launchURL("https://t.me/beiidh");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;

  const StatCard({super.key, required this.label, required this.value});

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(125),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.black.withAlpha(125),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class FooterButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const FooterButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(final BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        backgroundColor: Colors.black.withAlpha(125),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
