import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

class ShareMock extends Mock implements SharePlatform {}

void main() {
  late ShareService shareService;
  late File fileToShare;
  late SharePlatform shareMock;

  setUp(() {
    shareMock = ShareMock();
    shareService = ShareService(
      sharePlatform: shareMock,
    );

    fileToShare = File('custom_path.png');
    fileToShare.createSync();
  });

  tearDown(() {
    if (fileToShare.existsSync()) {
      fileToShare.deleteSync();
    }
  });

  group('ShareServiceTest', () {
    test('Should share correctly when shareString is call', () {
      // Arrange
      String msg = 'Olá, olha esse feedback que eu recebi';
      when(
        () => shareMock.share(msg),
      ).thenAnswer(
        (_) async {
          return const ShareResult('', ShareResultStatus.success);
        },
      );

      // Act
      shareService.shareString(
        text: msg,
      );

      // Asserts
      verify(
        () => shareMock.share(msg),
      );

      verifyNoMoreInteractions(shareMock);
    });

    test('Should share correctly when shareFiles is call', () {
      // Arrange
      final tFile = XFile(fileToShare.path);

      when(
        () => shareMock.shareXFiles([
          tFile,
        ]),
      ).thenAnswer(
        (_) async {
          return const ShareResult(
            '',
            ShareResultStatus.success,
          );
        },
      );

      // Act
      shareService.shareFiles(
        files: [
          tFile,
        ],
      );

      // Asserts
      verify(
        () => shareMock.shareXFiles([
          tFile,
        ]),
      );

      verifyNoMoreInteractions(shareMock);
    });
  });
}
