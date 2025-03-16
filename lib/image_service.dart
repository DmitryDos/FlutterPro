import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pro/data/user_data.dart';
import 'package:http/http.dart' as http;

import 'data_storage.dart';

class ImageService {
  static final http.Client client = http.Client();
  static String apiKey =
      "live_l3tS0mKRATK9w9QXexXfYZirsfQ3R8rwgQR2LXIAF6o8Esbij0ZYOkrhTP9teF1I";

  static Future<List<Map<String, String>>?> fetchRandomImages(
      final String url, final int count) async {
    try {
      final Uri uri = Uri.parse(url);
      final response = await client.get(
        uri,
        headers: {
          'x-api-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final List<Map<String, String>> images = [];

        if (url.contains("thecatapi.com")) {
          if (decodedData is List<dynamic> && decodedData.isNotEmpty) {
            for (var imageData in decodedData.take(count)) {
              if (imageData.containsKey('url')) {
                images.add({
                  'url': imageData['url'],
                  'name': imageData['breeds']?.isNotEmpty == true
                      ? imageData['breeds'][0]['name']
                      : "Ω_Ω",
                  'title': imageData['breeds']?.isNotEmpty == true
                      ? imageData['breeds'][0]['temperament']
                      : "Not Set",
                  'origin': imageData['breeds']?.isNotEmpty == true
                      ? imageData['breeds'][0]['origin']
                      : "Not Set",
                  'description': imageData['breeds']?.isNotEmpty == true
                      ? imageData['breeds'][0]['description']
                      : "Not Set",
                });
              }
            }
          } else {
            images.add({
              'url': decodedData['url'],
              'name': decodedData['breeds']?.isNotEmpty == true
                  ? decodedData['breeds'][0]['name']
                  : "Ω_Ω",
              'title': decodedData['breeds']?.isNotEmpty == true
                  ? decodedData['breeds'][0]['temperament']
                  : "Not Set",
              'origin': decodedData['breeds']?.isNotEmpty == true
                  ? decodedData['breeds'][0]['origin']
                  : "Not Set",
              'description': decodedData['breeds']?.isNotEmpty == true
                  ? decodedData['breeds'][0]['description']
                  : "Not Set",
            });
          }
        } else if (url.contains("nekogirl")) {
          if (decodedData is Map<String, dynamic> &&
              decodedData.containsKey('results')) {
            for (var characterData in decodedData['results']) {
              images.add({
                'url': characterData['url'],
                'name': DataStorage.getRandomName(),
                'title': DataStorage.getRandomTitle(),
                'origin': DataStorage.getRandomOrigin(),
                'description': DataStorage.getRandomDescription(),
              });
            }
          } else {
            images.add({
              'url': decodedData['url'],
              'name': DataStorage.getRandomName(),
              'title': DataStorage.getRandomTitle(),
              'origin': DataStorage.getRandomOrigin(),
              'description': DataStorage.getRandomDescription(),
            });
          }
        } else if (url.contains("nekosia")) {
          if (decodedData is Map<String, dynamic> &&
              decodedData.containsKey('images')) {
            for (var characterData in decodedData['images']) {
              images.add({
                'url': characterData['image']['original']['url'],
                'name': DataStorage.getRandomName(),
                'title': DataStorage.getRandomTitle(),
                'origin': DataStorage.getRandomOrigin(),
                'description': DataStorage.getRandomDescription(),
              });
            }
          } else {
            images.add({
              'url': decodedData['image']['original']['url'],
              'name': DataStorage.getRandomName(),
              'title': DataStorage.getRandomTitle(),
              'origin': DataStorage.getRandomOrigin(),
              'description': DataStorage.getRandomDescription(),
            });
          }
        }

        return images;
      }
    } catch (e) {
      debugPrint('Ошибка загрузки изображения: $e');
    }
    return null;
  }

  static String getUrl({final int count = 1}) {
    switch (UserData.instance.darkTheme) {
      case false:
        return 'https://api.nekosia.cat/api/v1/images/catgirl?count=$count&rating=questionable';
      // return 'https://api.nekogirl.net/v2/neko';
      // return 'https://nekos.best/api/v2/neko?amount=$count';
      default:
        return 'https://api.thecatapi.com/v1/images/search?has_breeds=true&limit=$count';
    }
  }
}
