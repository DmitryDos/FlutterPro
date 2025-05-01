import 'package:flutter/material.dart';
import 'package:flutter_pro/widgets/cards/card_factory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pro/data/image_dto.dart';
import 'package:flutter_pro/widgets/cards/container/animated_card_container.dart';
import 'package:flutter_pro/widgets/cards/container/static_card_container.dart';

void main() {
  group('CardFactory', () {
    test('determineCardType returns correct type for different URLs', () {
      expect(
        CardFactory.determineCardType(ImageDTO(url: 'preload')),
        CardType.preload,
      );
      expect(
        CardFactory.determineCardType(ImageDTO(url: 'noInternet')),
        CardType.internet,
      );
      expect(
        CardFactory.determineCardType(ImageDTO(url: 'error')),
        CardType.error,
      );
      expect(
        CardFactory.determineCardType(ImageDTO(url: 'regular')),
        CardType.regular,
      );
    });

    testWidgets('create returns AnimatedCardContainer when isAnimated=true',
        (final WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Material(child: Container())));

      final widget = CardFactory.create(
        imageData: ImageDTO(url: 'regular', name: 'Test'),
        number: 0,
        openDescription: () {},
        onDragUpdate: (final _) {},
        onDragEnd: (final _) {},
        offsetX: 0,
        offsetY: 0,
        angle: 0,
        darkTheme: false,
        isAnimated: true,
        context: tester.element(find.byType(Container)),
      );

      expect(widget, isA<AnimatedCardContainer>());
    });

    testWidgets('create returns StaticCardContainer when isAnimated=false',
        (final WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Material(child: Container())));

      final widget = CardFactory.create(
        imageData: ImageDTO(url: 'regular', name: 'Test'),
        number: 0,
        openDescription: () {},
        onDragUpdate: (final _) {},
        onDragEnd: (final _) {},
        offsetX: 0,
        offsetY: 0,
        angle: 0,
        darkTheme: false,
        isAnimated: false,
        context: tester.element(find.byType(Container)),
      );

      expect(widget, isA<StaticCardContainer>());
    });

    testWidgets('create returns correct card for preload type',
        (final WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Material(child: Container())));

      final widget = CardFactory.create(
        imageData: ImageDTO(url: 'preload'),
        number: 0,
        openDescription: () {},
        onDragUpdate: (final _) {},
        onDragEnd: (final _) {},
        offsetX: 0,
        offsetY: 0,
        angle: 0,
        darkTheme: false,
        isAnimated: true,
        context: tester.element(find.byType(Container)),
      );

      expect(widget, isA<AnimatedCardContainer>());
    });

    testWidgets('create returns correct card for error type',
        (final WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Material(child: Container())));

      final widget = CardFactory.create(
        imageData: ImageDTO(url: 'error'),
        number: 0,
        openDescription: () {},
        onDragUpdate: (final _) {},
        onDragEnd: (final _) {},
        offsetX: 0,
        offsetY: 0,
        angle: 0,
        darkTheme: false,
        isAnimated: true,
        context: tester.element(find.byType(Container)),
      );

      expect(widget, isA<AnimatedCardContainer>());
    });
  });
}
