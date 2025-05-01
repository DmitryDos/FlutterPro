import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:flutter_pro/services/image_service.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttpClient mockClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
    registerFallbackValue(<String, String>{});
  });

  setUp(() {
    mockClient = MockHttpClient();
    ImageService.client = mockClient;
  });

  test('successfully fetches cat images', () async {
    when(() => mockClient.get(
          Uri.parse(
              'https://api.thecatapi.com/v1/images/search?has_breeds=true&limit=1'),
          headers: any(named: 'headers'),
        )).thenAnswer((final _) async => http.Response('''
      [{
        "url": "https://cat.jpg",
        "breeds": [{
          "name": "Siamese",
          "temperament": "Curious",
          "origin": "Thailand",
          "description": "Very talkative cat"
        }]
      }]
    ''', 200));

    final images = await ImageService.fetchRandomImages(
      url: 'https://api.thecatapi.com/v1/images/search?has_breeds=true&limit=1',
      count: 1,
      onError: (final _) {},
    );

    expect(images, isNotNull);
    expect(images!.length, 1);
    expect(images[0].url, 'https://cat.jpg');
  });

  test('handles network errors', () async {
    when(() => mockClient.get(
          any(),
          headers: any(named: 'headers'),
        )).thenThrow(const SocketException('No internet'));

    String? errorMessage;
    final images = await ImageService.fetchRandomImages(
      url: 'https://api.thecatapi.com/v1/images/search',
      count: 1,
      onError: (final msg) => errorMessage = msg,
    );

    expect(images, isNull);
    expect(errorMessage, 'No internet connection');
  });
}
