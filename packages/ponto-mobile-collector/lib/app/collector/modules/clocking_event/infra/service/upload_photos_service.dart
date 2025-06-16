import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:http/http.dart' as http;
import 'package:mobile_authentication/mobile_authentication_service.dart';
import 'package:path/path.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/enums/network_status.dart';

class UploadPhotosService implements IUploadPhotosService {
  final IPlatformService _platformService;
  final clock.IPhotoAwsS3Service _photoAwsS3Service;
  final LogService _logService;

  UploadPhotosService(
    this._photoAwsS3Service,
    this._platformService,
    this._logService,
  );

  /// Send to AWS S3 all photos from a specific user directory
  @override
  Future<void> sendFromDirectory({
    required Directory directory,
    required String employeeId,
    required clock.OperationModeEnum operationMode,
  }) async {
    if (!directory.existsSync()) {
      return Future.value();
    }

    bool hasConnectivity = (await _platformService.connectivityStatus()) ==
        NetworkStatusEnum.active;

    /// Get files from directory
    List<FileSystemEntity> filesSystem = directory.listSync().toList();

    if (hasConnectivity && filesSystem.isNotEmpty) {
      List<File> files = [];
      List<String> photoNames = [];

      /// Get photo names
      for (FileSystemEntity entity in filesSystem) {
        if (entity is File) {
          files.add(entity);
          photoNames.add(basename(entity.path));
        }
      }

      _logService.saveLocalLog(
        exception: 'TraceRouteLog',
        stackTrace: 'Qtd photoNames: ${photoNames.length}, Employee: $employeeId, PhotoNames:  ${photoNames.join(', ')}',
        fatalError: false,
      );

      /// Create Url Request
      clock.UrlPhotoRequestDto urlRequest = clock.UrlPhotoRequestDto(
        employeeId: employeeId,
        photoNames: photoNames,
        uploadType: operationMode,
      );

      /// Do request to generate Url
      clock.UrlPhotoResponseDto responseUrl;
      Stopwatch stopwatch = Stopwatch();
      try {
        stopwatch.start();
        responseUrl = await _photoAwsS3Service.getUploadSelfieUrl(
          urlPhotoRequestDto: urlRequest,
        );
        stopwatch.stop();
        _logService.saveLocalLog(
          exception: 'TraceRouteLog',
          stackTrace: 'Photo upload urls generated in ${stopwatch.elapsedMilliseconds} ms',
          fatalError: false,
        );
      } catch (e) {
        stopwatch.stop();
        _logService.saveLocalLog(
          exception: 'Error generating photo upload urls',
          stackTrace: 'Error generating photo upload urls in ${stopwatch.elapsedMilliseconds} ms, error: $e',
          fatalError: false,
        );
        log('UploadPhotosService: Error generating photo upload urls');
        return;
      } finally {
        stopwatch.stop();
      }

      /// Send file do Aws S3, one by one
      int index = 0;
      for (File file in files) {
        try {
          await send(
            imageBytes: file.readAsBytesSync(),
            signedUrl: responseUrl.uploadUrls[index++],
          );

          file.deleteSync();

          log('Photo sent successfully ${file.absolute}');
        } catch (e) {
          log('Error sending photo to AWS ${file.absolute}');
        }
      }
    } else {
      _logService.saveLocalLog(
        exception: 'TraceRouteLog',
        stackTrace: 'No connectivity or no photos to send. HasConnectivity: $hasConnectivity',
        fatalError: false,
      );
    }

    return Future.value();
  }

  Future<bool> send({
    required List<int> imageBytes,
    required String signedUrl,
  }) async {
    var request = http.Request('PUT', Uri.parse(signedUrl));
    request.bodyBytes = imageBytes;
    request.headers.addAll({
      'Content-Type': 'image/jpeg',
      'Content-Length': imageBytes.length.toString(),
    });

    final stopwatch = Stopwatch()..start();
    var response = await request.send();
    stopwatch.stop();

    _logService.saveLocalLog(
      exception: 'TraceRouteLog',
      stackTrace: 'Photo sent to AWS in ${stopwatch.elapsedMilliseconds} ms, response: ${response.statusCode}',
      fatalError: false,
    );
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      throw ServiceException.fromJson(
        json.decode(response.statusCode.toString()),
      );
    }
  }
}
