import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/sync_individual_status_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_all_individual_info_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/sync_all_individual_info/sync_all_individual_info_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/sync_all_individual_info/sync_all_individual_info_state.dart';

class MockSyncAllMultipleInfoUsecase extends Mock
    implements SyncAllIndividualInfoUsecase {}

void main() {
  late SyncAllIndividualInfoCubit syncAllMultipleInfoCubit;
  late SyncAllIndividualInfoUsecase syncAllMultipleInfoUsecase;

  setUp(() {
    syncAllMultipleInfoUsecase = MockSyncAllMultipleInfoUsecase();

    when(
      () => syncAllMultipleInfoUsecase.call(),
    ).thenAnswer((_) async => SyncIndividualStatusType.success);

    syncAllMultipleInfoCubit = SyncAllIndividualInfoCubit(
      syncAllIndividualInfoUsecase: syncAllMultipleInfoUsecase,
    );
  });

  group('SyncAllIndividualInfoCubit', () {
    blocTest(
      'success sync test',
      setUp: () {
        when(
          () => syncAllMultipleInfoUsecase.call(),
        ).thenAnswer((_) async => SyncIndividualStatusType.success);
      },
      build: () => syncAllMultipleInfoCubit,
      act: (bloc) => bloc.syncAllIndividualInfo(),
      expect: () => [
        isA<SyncAllIndividualInfoInProgressState>(),
        isA<SyncAllIndividualInfoSuccessState>(),
      ],
      verify: (bloc) {
        verify(() => syncAllMultipleInfoUsecase.call());

        verifyNoMoreInteractions(syncAllMultipleInfoUsecase);
      },
    );

    blocTest(
      'tokenUnavailable sync test',
      setUp: () {
        when(
          () => syncAllMultipleInfoUsecase.call(),
        ).thenAnswer((_) async => SyncIndividualStatusType.tokenUnavailable);
      },
      build: () => syncAllMultipleInfoCubit,
      act: (bloc) => bloc.syncAllIndividualInfo(),
      expect: () => [
        isA<SyncAllIndividualInfoInProgressState>(),
        isA<SyncAllIndividualInfoNotTokenState>(),
      ],
      verify: (bloc) {
        verify(() => syncAllMultipleInfoUsecase.call());

        verifyNoMoreInteractions(syncAllMultipleInfoUsecase);
      },
    );

    blocTest(
      'connectionUnavailable sync test',
      setUp: () {
        when(
          () => syncAllMultipleInfoUsecase.call(),
        ).thenAnswer(
          (_) async => SyncIndividualStatusType.connectionUnavailable,
        );
      },
      build: () => syncAllMultipleInfoCubit,
      act: (bloc) => bloc.syncAllIndividualInfo(),
      expect: () => [
        isA<SyncAllIndividualInfoInProgressState>(),
        isA<SyncAllIndividualInfoNoConnectionState>(),
      ],
      verify: (bloc) {
        verify(() => syncAllMultipleInfoUsecase.call());

        verifyNoMoreInteractions(syncAllMultipleInfoUsecase);
      },
    );

    blocTest(
      'error sync test',
      setUp: () {
        when(
          () => syncAllMultipleInfoUsecase.call(),
        ).thenAnswer((_) async => SyncIndividualStatusType.failure);
      },
      build: () => syncAllMultipleInfoCubit,
      act: (bloc) => bloc.syncAllIndividualInfo(),
      expect: () => [
        isA<SyncAllIndividualInfoInProgressState>(),
        isA<SyncAllIndividualInfoFailureState>(),
      ],
      verify: (bloc) {
        verify(() => syncAllMultipleInfoUsecase.call());

        verifyNoMoreInteractions(syncAllMultipleInfoUsecase);
      },
    );
  });
}
