import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/helper/scroll_helper.dart';

class ScrollControllerMock extends Mock implements ScrollController {}

class ScrollPositionMock extends Mock implements ScrollPosition {}

void main() {
  late ScrollController controller;
  late ScrollPosition position;

  setUp(() {
    controller = ScrollControllerMock();
    position = ScrollPositionMock();
  });

  group('ScrollHelperTest', () {
    test('Should return false when scroll has no client attached.', () {
      // Arrange
      when(
        () => controller.hasClients,
      ).thenReturn(false);

      // Act
      final canLoadMore = ScrollHelper.reachedListEnd(
        scrollController: controller,
      );

      // Asserts
      expect(canLoadMore, isFalse);
    });

    test('Should return false when scroll position is bellow 80%.', () {
      // Arrange
      when(
        () => controller.hasClients,
      ).thenReturn(true);
      when(
        () => controller.position,
      ).thenReturn(position);
      when(
        () => position.maxScrollExtent,
      ).thenReturn(1.0);
      when(
        () => controller.offset,
      ).thenReturn(0.0);

      // Act
      final canLoadMore = ScrollHelper.reachedListEnd(
        scrollController: controller,
      );

      // Asserts
      expect(
        canLoadMore,
        isFalse,
      );
    });

    test('Should return true when scroll position is above 80%.', () {
      // Arrange
      when(
        () => controller.hasClients,
      ).thenReturn(true);
      when(
        () => controller.position,
      ).thenReturn(position);
      when(
        () => position.maxScrollExtent,
      ).thenReturn(1.0);
      when(
        () => controller.offset,
      ).thenReturn(0.8);

      // Act
      final canLoadMore = ScrollHelper.reachedListEnd(
        scrollController: controller,
      );

      // Asserts
      expect(
        canLoadMore,
        isTrue,
      );
    });
  });
}
