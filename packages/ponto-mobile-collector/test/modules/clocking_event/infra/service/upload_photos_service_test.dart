import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/network_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockPlatformService extends Mock implements IPlatformService {}

class MockIPhotoAwsS3Service extends Mock implements clock.IPhotoAwsS3Service {}

class MockLogService extends Mock implements LogService {}

void main() {
  late IPlatformService platformService;
  late clock.IPhotoAwsS3Service photoAwsS3Service;
  late LogService logService;

  setUp(
    () {
      platformService = MockPlatformService();
      photoAwsS3Service = MockIPhotoAwsS3Service();
      logService = MockLogService();
    },
  );

  test(
    'UploadPhotosService test.',
    () async {
      String userId = 'fd89d793-3bf6-4bbb-a451-76f0ccde3249';

      clock.UrlPhotoResponseDto urlPhotoResponseDto =
          clock.UrlPhotoResponseDto(uploadUrls: ['https://www.google.com.br']);

      clock.UrlPhotoRequestDto urlPhotoRequestDto = clock.UrlPhotoRequestDto(
        employeeId: userId,
        photoNames: ['photoNames'],
        uploadType: clock.OperationModeEnum.qrCode,
      );
      registerFallbackValue(urlPhotoRequestDto);

      when(
        () => platformService.connectivityStatus(),
      ).thenAnswer(
        (invocation) => Future.value(NetworkStatusEnum.active),
      );

      when(
        () => photoAwsS3Service.getUploadSelfieUrl(
          urlPhotoRequestDto: any(named: 'urlPhotoRequestDto'),
        ),
      ).thenAnswer((invocation) => Future.value(urlPhotoResponseDto));

      final directory = Directory.systemTemp.createTempSync();
      Directory.current = directory.path;
      final file = File('test_file.jpeg');
      file.writeAsStringSync('Conteúdo do arquivo');

      UploadPhotosService service = UploadPhotosService(
        photoAwsS3Service,
        platformService,
        logService,
      );

      await service.sendFromDirectory(directory: directory, employeeId: userId, operationMode: clock.OperationModeEnum.qrCode);

      verify(
        () => photoAwsS3Service.getUploadSelfieUrl(
          urlPhotoRequestDto: any(named: 'urlPhotoRequestDto'),
        ),
      ).called(1);

      verify(
        () => logService.saveLocalLog(
          exception: any(named: 'exception'),
          stackTrace: any(named: 'stackTrace'),
          fatalError: false,
        ),
      ).called(3);

      verifyNoMoreInteractions(logService);
    },
  );

  test(
    'UploadPhotosService test error.',
    () async {
      String userId = 'fd89d793-3bf6-4bbb-a451-76f0ccde3249';

      clock.UrlPhotoRequestDto urlPhotoRequestDto = clock.UrlPhotoRequestDto(
        employeeId: userId,
        photoNames: ['photoNames'],
        uploadType: clock.OperationModeEnum.single,
      );
      registerFallbackValue(urlPhotoRequestDto);

      when(
        () => platformService.connectivityStatus(),
      ).thenAnswer(
        (invocation) => Future.value(NetworkStatusEnum.active),
      );

      when(
        () => photoAwsS3Service.getUploadSelfieUrl(
          urlPhotoRequestDto: any(named: 'urlPhotoRequestDto'),
        ),
      ).thenAnswer((invocation) => Future.error('Error'));

      final directory = Directory.systemTemp.createTempSync();
      Directory.current = directory.path;
      final file = File('test_file.jpeg');
      file.writeAsStringSync('Conteúdo do arquivo');

      UploadPhotosService service = UploadPhotosService(
        photoAwsS3Service,
        platformService,
        logService,
      );

      await service.sendFromDirectory(directory: directory, employeeId: userId, operationMode: clock.OperationModeEnum.qrCode);

      verify(
        () => photoAwsS3Service.getUploadSelfieUrl(
          urlPhotoRequestDto: any(named: 'urlPhotoRequestDto'),
        ),
      ).called(1);

      verify(
        () => logService.saveLocalLog(
          exception: any(named: 'exception'),
          stackTrace: any(named: 'stackTrace'),
          fatalError: false,
        ),
      ).called(2);

      verifyNoMoreInteractions(logService);
    },
  );

  test(
    'UploadPhotosService test no connectivity.',
    () async {
      String userId = 'fd89d793-3bf6-4bbb-a451-76f0ccde3249';

      clock.UrlPhotoRequestDto urlPhotoRequestDto = clock.UrlPhotoRequestDto(
        employeeId: userId,
        photoNames: ['photoNames'],
        uploadType: clock.OperationModeEnum.qrCode,
      );
      registerFallbackValue(urlPhotoRequestDto);

      when(
        () => platformService.connectivityStatus(),
      ).thenAnswer(
        (invocation) => Future.value(NetworkStatusEnum.inactive),
      );

      final directory = Directory.systemTemp.createTempSync();
      Directory.current = directory.path;
      final file = File('test_file.jpeg');
      file.writeAsStringSync('Conteúdo do arquivo');

      UploadPhotosService service = UploadPhotosService(
        photoAwsS3Service,
        platformService,
        logService,
      );

      await service.sendFromDirectory(directory: directory, employeeId: userId, operationMode: clock.OperationModeEnum.single);

      verifyNever(
        () => photoAwsS3Service.getUploadSelfieUrl(
          urlPhotoRequestDto: any(named: 'urlPhotoRequestDto'),
        ),
      );
    },
  );
}
