import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/navigator/navigator_service_impl.dart';

class MockModularNavigator extends Mock implements IModularNavigator {}

class MockMaterialPageRoute extends Mock
    implements MaterialPageRoute<dynamic> {}

void main() {
  const String tRouter = 'router';
  late NavigatorService navigatorService;
  late IModularNavigator modularNavigator;

  setUp(() {
    modularNavigator = MockModularNavigator();
    navigatorService = NavigatorServiceImpl(modularNavigator: modularNavigator);
  });

  group('NavigatorService', () {
    test('navigate test', () async {
      when(
        () => modularNavigator.navigate(tRouter),
      ).thenReturn(null);

      navigatorService.navigate(route: tRouter);

      verify(() => modularNavigator.navigate(tRouter));
    });

    test('pop test', () async {
      dynamic input = true;

      when(
        () => modularNavigator.pop(input),
      ).thenReturn(null);

      await navigatorService.pop(value: true);
      verify(() => modularNavigator.pop(input)).called(1);
    });

    test('pushNamed test', () async {
      when(
        () => modularNavigator.pushNamed(tRouter),
      ).thenAnswer((_) async => true);

      navigatorService.pushNamed(route: tRouter);

      verify(() => modularNavigator.pushNamed(tRouter));
    });

    test('popAndPushNamed test', () async {
      when(
        () => modularNavigator.popAndPushNamed(tRouter),
      ).thenAnswer((_) async => true);

      navigatorService.popAndPushNamed(route: tRouter);

      verify(() => modularNavigator.popAndPushNamed(tRouter));
    });

    test('pushNamedAndRemoveUntil test', () async {
      registerFallbackValue((route) => {false});
      when(
        () => modularNavigator.pushNamedAndRemoveUntil(
          tRouter,
          any(),
        ),
      ).thenAnswer((_) async => true);

      navigatorService.pushNamedAndRemoveUntil(
        tRouter,
        (p0) => false,
      );

      verify(
        () => modularNavigator.pushNamedAndRemoveUntil(
          tRouter,
          any(),
        ),
      );
    });

    test('push test', () async {
      MaterialPageRoute<dynamic> pageRoute = MockMaterialPageRoute();
      registerFallbackValue(pageRoute);
      when(
        () => modularNavigator.push(any()),
      ).thenAnswer((_) async => true);

      expect(await navigatorService.push(pageRoute: pageRoute), true);

      verify(() => modularNavigator.push(any()));
    });
  });
}
