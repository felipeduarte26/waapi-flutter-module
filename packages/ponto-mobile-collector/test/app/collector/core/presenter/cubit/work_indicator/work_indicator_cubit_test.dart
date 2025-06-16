import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/work_indicator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_state.dart';

class MockWorkIndicatorService extends Mock implements WorkIndicatorService {}

void main() {
  late WorkIndicatorCubit workIndicatorCubit;
  late MockWorkIndicatorService mockWorkIndicatorService;
  final StreamController<bool> streamController =
      StreamController<bool>.broadcast();

  setUp(() {
    mockWorkIndicatorService = MockWorkIndicatorService();

    when(() => mockWorkIndicatorService.isWorkInProgress).thenAnswer(
      (_) => false,
    );

    when(() => mockWorkIndicatorService.stream).thenAnswer(
      (_) => streamController.stream,
    );

    workIndicatorCubit =
        WorkIndicatorCubit(workIndicatorService: mockWorkIndicatorService);
  });

  tearDown(() {
    workIndicatorCubit.dispose();
  });

  group('WorkIndicatorCubit', () {
    blocTest<WorkIndicatorCubit, WorkIndicatorState>(
      'emits [WorkindicatorInProgressState] when isWorkInProgress is true',
      setUp: () {
        when(() => mockWorkIndicatorService.isWorkInProgress).thenAnswer(
          (_) => true,
        );
      },
      build: () => workIndicatorCubit,
      act: (bloc) {
        streamController.add(true);
      },
      expect: () {
        expect(workIndicatorCubit.isWorkInProgress, true);
        return [isA<WorkIndicatorUpdate>()];
      },
    );

    blocTest<WorkIndicatorCubit, WorkIndicatorState>(
      'emits [WorkindicatorReadyState] when isWorkInProgress is false',
      build: () => workIndicatorCubit,
      act: (bloc) {
        streamController.add(false);
      },
      expect: () {
        expect(workIndicatorCubit.isWorkInProgress, false);
        return [isA<WorkIndicatorUpdate>()];
      },
    );

    blocTest<WorkIndicatorCubit, WorkIndicatorState>(
      'emits [WorkindicatorInProgressState, WorkindicatorReadyState] when stream emits true then false',
      build: () => workIndicatorCubit,
      act: (bloc) {
        streamController.add(true);
        streamController.add(false);
      },
      expect: () {
        expect(workIndicatorCubit.isWorkInProgress, false);
        return [
          isA<WorkIndicatorUpdate>(),
          isA<WorkIndicatorUpdate>(),
        ];
      },
    );
  });
}
