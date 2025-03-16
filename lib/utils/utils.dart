import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

bool isHexColor(final String input) {
  if (input.startsWith('/')) return false;
  final RegExp hexColorRegex =
      RegExp(r'^(#|0x)?([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$');
  return hexColorRegex.hasMatch(input);
}

ImageProvider getImageProvider(final String input) {
  if (input.startsWith('http') || input.startsWith('https')) {
    return NetworkImage(input);
  } else if (input.startsWith('/')) {
    return FileImage(File(input));
  } else {
    return AssetImage(input);
  }
}

Future<void> launchURL(final String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

// Images Crop around Face - Not Work
// Future<ui.Image?> cropImageAroundFace(String imageUrl) async {
//   FaceDetector? faceDetector; // Объявляем переменную здесь
//
//   try {
//     // Скачиваем изображение
//     final response = await http.get(Uri.parse(imageUrl));
//     if (response.statusCode != 200) throw Exception('Failed to load image');
//
//     // Декодируем изображение
//     final image = decodeImage(response.bodyBytes);
//     if (image == null) throw Exception('Failed to decode image');
//
//     // Сохраняем изображение во временный файл
//     final tempFile = File('${Directory.systemTemp.path}/temp_image.jpg');
//     await tempFile.writeAsBytes(response.bodyBytes);
//
//     // Создаем InputImage из файла
//     final inputImage = InputImage.fromFilePath(tempFile.path);
//
//     // Инициализируем детектор лиц
//     final options = FaceDetectorOptions();
//     faceDetector = FaceDetector(options: options); // Инициализируем здесь
//
//     // Обнаруживаем лица
//     final faces = await faceDetector.processImage(inputImage);
//
//     if (faces.isNotEmpty) {
//       final face = faces.first;
//       final boundingBox = face.boundingBox;
//
//       // Кадрируем изображение вокруг лица
//       final croppedImage = copyCrop(
//         image,
//         x: boundingBox.left.toInt(),
//         y: boundingBox.top.toInt(),
//         width: boundingBox.width.toInt(),
//         height: boundingBox.height.toInt(),
//       );
//
//       // Преобразуем обратно в формат, который можно использовать в UI
//       final codec = await ui.instantiateImageCodec(
//         Uint8List.fromList(encodePng(croppedImage)),
//       );
//       final frame = await codec.getNextFrame();
//       return frame.image;
//     } else {
//       print("Лицо не обнаружено.");
//       return null;
//     }
//   } catch (e) {
//     print("Ошибка при обработке изображения: $e");
//     return null;
//   } finally {
//     // Закрываем детектор, если он был инициализирован
//     faceDetector?.close();
//   }
// }
