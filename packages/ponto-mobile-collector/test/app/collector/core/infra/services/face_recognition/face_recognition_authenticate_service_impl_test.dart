import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_token_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_authenticate_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/face_recognition/face_recognition_authenticate_service_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/shared_preferences/shared_preferences_service.dart';

class MockFaceRecognitionTokenRepository extends Mock
    implements FaceRecognitionTokenRepository {}

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

void main() {
  String tToken = 'tToken';
  Map<dynamic, dynamic> resultSuccessfully = {'status': 'success'};
  Map<dynamic, dynamic> resultError = {'status': 'error'};
  Map<dynamic, dynamic> resultAuthenticationError = {'status': 'authentication_error'};
  late FaceRecognitionAuthenticateService faceRecognitionAuthenticateService;
  late FaceRecognitionTokenRepository faceRecognitionTokenRepository;
  late FlutterGryfoLib flutterGryfoLib;
  late SharedPreferencesService sharedPreferencesService;

  setUp(() {

    faceRecognitionTokenRepository = MockFaceRecognitionTokenRepository();
    flutterGryfoLib = MockFlutterGryfoLib();
    sharedPreferencesService = MockSharedPreferencesService();

    faceRecognitionAuthenticateService = FaceRecognitionAuthenticateServiceImpl(
      faceRecognitionTokenRepository: faceRecognitionTokenRepository,
      gryfoLib: flutterGryfoLib,
      sharedPreferencesService: sharedPreferencesService,
    );

    when(
      () => faceRecognitionTokenRepository.call(),
    ).thenAnswer((_) async => tToken);

    when(
      () => flutterGryfoLib.authenticate(tToken),
    ).thenAnswer((_) async => resultSuccessfully);

    when(
          () => sharedPreferencesService.setFacialRecognitionAuthToken(token: any(named: 'token')),
    ).thenAnswer((invocation) {
      return Future.value();
    },);
    
  });

  void mockVerifyNoMoreInteractions() {
    verifyNoMoreInteractions(faceRecognitionTokenRepository);
    verifyNoMoreInteractions(flutterGryfoLib);
  }

  group('MockFaceRecognitionTokenRepository', () {

    test('call authentication successfully test with valid token from cache', () async {

      var tokenJWT = getTokenJWT(DateTime.timestamp());

      when(
            () => sharedPreferencesService.getFacialRecognitionAuthToken(),
      ).thenAnswer((_) async => tokenJWT);

      when(
            () => flutterGryfoLib.authenticate(tokenJWT),
      ).thenAnswer((_) async => resultSuccessfully);


      bool resultValue =
      await faceRecognitionAuthenticateService.authenticate();

      expect(resultValue, true);

      verify(() => sharedPreferencesService.getFacialRecognitionAuthToken()).called(1);
      verify(() => flutterGryfoLib.authenticate(tokenJWT)).called(1);
      verifyNever(() => faceRecognitionTokenRepository.call());

      mockVerifyNoMoreInteractions();
    });

    test('call authentication successfully test with invalid token from cache', () async {

      var tokenJWTFromCache = '123';

      var tokenJWTFromBackend = '1234';


      expect(true, tokenJWTFromCache != tokenJWTFromBackend);

      when(
            () => sharedPreferencesService.getFacialRecognitionAuthToken(),
      ).thenAnswer((_) async => tokenJWTFromCache);

      when(
            () => flutterGryfoLib.authenticate(tokenJWTFromCache),
      ).thenAnswer((_) async => resultAuthenticationError);

      when(
            () => faceRecognitionTokenRepository.call(),
      ).thenAnswer((_) async => tokenJWTFromBackend);

      when(
            () => flutterGryfoLib.authenticate(tokenJWTFromBackend),
      ).thenAnswer((_) async => resultSuccessfully);


      bool resultValue =
      await faceRecognitionAuthenticateService.authenticate();

      expect(resultValue, true);

      verify(() => sharedPreferencesService.getFacialRecognitionAuthToken()).called(1);
      verify(() => faceRecognitionTokenRepository.call()).called(1);
      verify(() => flutterGryfoLib.authenticate(tokenJWTFromCache)).called(1);
      verify(() => flutterGryfoLib.authenticate(tokenJWTFromBackend)).called(1);

      mockVerifyNoMoreInteractions();
    });

    test('call authentication successfully test without token from cache', () async {

      when(
            () => sharedPreferencesService.getFacialRecognitionAuthToken(),
      ).thenAnswer((_) async => '');

      bool resultValue =
          await faceRecognitionAuthenticateService.authenticate();

      expect(resultValue, true);

      verify(() => sharedPreferencesService.getFacialRecognitionAuthToken()).called(1);
      verify(() => faceRecognitionTokenRepository.call()).called(1);
      verify(() => flutterGryfoLib.authenticate(tToken)).called(1);

      mockVerifyNoMoreInteractions();
    });

    test('return false when token is null test', () async {
      when(
        () => faceRecognitionTokenRepository.call(),
      ).thenAnswer((_) async => null);

      when(
            () => sharedPreferencesService.getFacialRecognitionAuthToken(),
      ).thenAnswer((_) async => '');

      bool resultValue =
          await faceRecognitionAuthenticateService.authenticate();

      expect(resultValue, false);

      verify(() => faceRecognitionTokenRepository.call()).called(1);
      verify(() => flutterGryfoLib.authenticate('')).called(1);

      mockVerifyNoMoreInteractions();
    });

    test('return false when gryfo authentication error test', () async {
      when(
        () => flutterGryfoLib.authenticate(tToken),
      ).thenAnswer((_) async => resultError);

      when(
            () => sharedPreferencesService.getFacialRecognitionAuthToken(),
      ).thenAnswer((_) async => '');

      bool resultValue =
          await faceRecognitionAuthenticateService.authenticate();

      expect(resultValue, false);

      verify(() => faceRecognitionTokenRepository.call()).called(1);
      verify(() => flutterGryfoLib.authenticate(tToken)).called(1);

      mockVerifyNoMoreInteractions();
    });
  });
}

String getTokenJWT(DateTime iat) {

  final jwt = JWT(
    {
      'id': 123,
      'name': 'Example',
      'iat': iat.millisecondsSinceEpoch,
    },
    issuer: 'example.com',
  );

  return jwt.sign(
    SecretKey('secrettest'),
    algorithm: JWTAlgorithm.HS256,
  );
}
