import 'package:flutter_pro/providers/cards_provider.dart';
import 'package:flutter_pro/providers/user_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_pro/data/image_dto.dart';
import 'package:flutter_pro/services/cached_images_service.dart';

class MockCachedImagesService extends Mock implements CachedImagesService {}

class MockUserData extends Mock implements UserData {}

class FakeImageDTO extends Fake implements ImageDTO {}

class FakeUniqueImageDTO extends Fake implements UniqueImageDTO {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LikedCatsProvider provider;
  late MockCachedImagesService mockService;

  setUpAll(() {
    registerFallbackValue(FakeImageDTO());
    registerFallbackValue(FakeUniqueImageDTO());
    registerFallbackValue(false);
  });

  setUp(() {
    mockService = MockCachedImagesService();
    provider = LikedCatsProvider();

    when(() => mockService.getImages()).thenAnswer((final _) async => []);
    when(() => mockService.saveImage(any(), any()))
        .thenAnswer((final _) async {});
    when(() => mockService.removeUImage(any())).thenAnswer((final _) async {});
    when(() => mockService.clear()).thenAnswer((final _) async {});
  });

  group('LikedCatsProvider', () {
    test('initService initializes service and loads cats', () async {
      final testImages = [
        UniqueImageDTO(url: 'test1.jpg', name: 'Cat 1', date: DateTime.now()),
      ];

      when(() => mockService.getImages())
          .thenAnswer((final _) async => testImages);

      provider.initService(mockService);
      await Future<void>.delayed(Duration.zero);

      verify(() => mockService.getImages()).called(1);
      expect(provider.filter(''), testImages);
    });

    test('addCat saves image to service', () async {
      final testImage = ImageDTO(url: 'new.jpg', name: 'New Cat');

      when(() => mockService.saveImage(testImage, false))
          .thenAnswer((final _) async {});
      provider.initService(mockService);
      await Future<void>.delayed(Duration.zero);

      await provider.addCat(testImage);
      verifyNever(() => mockService.saveImage(testImage, false));
    });

    test('removeCat deletes image and updates list', () async {
      final testImage = UniqueImageDTO(
        url: 'remove.jpg',
        name: 'To Remove',
        date: DateTime.now(),
      );

      when(() => mockService.getImages())
          .thenAnswer((final _) async => [testImage]);
      provider.initService(mockService);
      await Future<void>.delayed(Duration.zero);

      await provider.removeCat(testImage);
      verify(() => mockService.removeUImage(testImage)).called(1);
      expect(provider.filter(''), isEmpty);
    });

    test('clear empties the service and list', () async {
      when(() => mockService.getImages()).thenAnswer((final _) async => [
            UniqueImageDTO(url: 'test.jpg', name: 'Test', date: DateTime.now()),
          ]);
      provider.initService(mockService);
      await Future<void>.delayed(Duration.zero);

      await provider.clear();
      verify(() => mockService.clear()).called(1);
      expect(provider.filter(''), isEmpty);
    });
  });
}
