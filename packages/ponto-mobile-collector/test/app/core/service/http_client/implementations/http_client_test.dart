import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/http_client/exception/http_client_exception.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/http_client/http_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client mockHttpClient;
  late IHttpClient httpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    httpClient = HttpClient(mockHttpClient);
  });

  group('GET', () {
    test('Should return a HttpResponse in success case', () async {
      const statusCode = 200;
      const body = '{"key": "value"}';
      const url = 'https://some-url.com';
      const headers = {'Key': 'value'};

      when(() => mockHttpClient.get(Uri.parse(url), headers: headers))
          .thenAnswer((_) async => http.Response(body, statusCode));

      final result = await httpClient.get(url, headers: headers);

      expect(
        result,
        isA<HttpResponse>()
            .having(
              (response) => response.statusCode,
              'Has the correct status code',
              statusCode,
            )
            .having(
              (response) => response.body,
              'Has the correct body',
              body,
            ),
      );
      verify(() => mockHttpClient.get(Uri.parse(url), headers: headers));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('Should capture any unexpected error', () async {
      const url = 'https://some-url.com';
      const headers = {'Key': 'value'};

      when(() => mockHttpClient.get(Uri.parse(url), headers: headers))
          .thenThrow(Exception('Unexpected Exception'));

      final call = httpClient.get;

      expect(
        call(url, headers: headers),
        throwsA(isA<HttpClientException>()),
      );
      verify(() => mockHttpClient.get(Uri.parse(url), headers: headers));
      verifyNoMoreInteractions(mockHttpClient);
    });
  });

  group('POST', () {
    test('Should return a HttpResponse in success case', () async {
      const statusCode = 200;
      const requestBody = '{"key": "value"}';
      const body = '{"key": "value"}';
      const url = 'https://some-url.com';
      const headers = {'Key': 'value'};

      when(
        () => mockHttpClient.post(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      ).thenAnswer((_) async => http.Response(body, statusCode));

      final result = await httpClient.post(
        url,
        headers: headers,
        body: requestBody,
      );

      expect(
        result,
        isA<HttpResponse>()
            .having(
              (response) => response.statusCode,
              'Has the correct status code',
              statusCode,
            )
            .having(
              (response) => response.body,
              'Has the correct body',
              body,
            ),
      );
      verify(
        () => mockHttpClient.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        ),
      );
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('Should capture any unexpected error', () async {
      const url = 'https://some-url.com';
      const headers = {'Key': 'value'};
      const requestBody = '{"key": "value"}';

      when(
        () => mockHttpClient.post(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      ).thenThrow(Exception('Unexpected Exception'));

      final call = httpClient.post;

      expect(
        call(url, headers: headers, body: requestBody),
        throwsA(isA<HttpClientException>()),
      );
      verify(
        () => mockHttpClient.post(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      );
      verifyNoMoreInteractions(mockHttpClient);
    });
  });

  group('PUT', () {
    test('Should return a HttpResponse in success case', () async {
      const statusCode = 200;
      const requestBody = '{"key": "value"}';
      const body = '{"key": "value"}';
      const url = 'https://some-url.com';
      const headers = {'Key': 'value'};

      when(
        () => mockHttpClient.put(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      ).thenAnswer((_) async => http.Response(body, statusCode));

      final result = await httpClient.put(
        url,
        headers: headers,
        body: requestBody,
      );

      expect(
        result,
        isA<HttpResponse>()
            .having(
              (response) => response.statusCode,
              'Has the correct status code',
              statusCode,
            )
            .having(
              (response) => response.body,
              'Has the correct body',
              body,
            ),
      );
      verify(
        () => mockHttpClient.put(
          Uri.parse(url),
          headers: headers,
          body: body,
        ),
      );
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('Should capture any unexpected error', () async {
      const url = 'https://some-url.com';
      const headers = {'Key': 'value'};
      const requestBody = '{"key": "value"}';

      when(
        () => mockHttpClient.put(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      ).thenThrow(Exception('Unexpected Exception'));

      final call = httpClient.put;

      expect(
        call(url, headers: headers, body: requestBody),
        throwsA(isA<HttpClientException>()),
      );
      verify(
        () => mockHttpClient.put(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      );
      verifyNoMoreInteractions(mockHttpClient);
    });
  });

  group('DELETE', () {
    test('Should return a HttpResponse in success case', () async {
      const statusCode = 200;
      const requestBody = '{"key": "value"}';
      const body = '{"key": "value"}';
      const url = 'https://some-url.com';
      const headers = {'Key': 'value'};

      when(
        () => mockHttpClient.delete(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      ).thenAnswer((_) async => http.Response(body, statusCode));

      final result = await httpClient.delete(
        url,
        headers: headers,
        body: requestBody,
      );

      expect(
        result,
        isA<HttpResponse>()
            .having(
              (response) => response.statusCode,
              'Has the correct status code',
              statusCode,
            )
            .having(
              (response) => response.body,
              'Has the correct body',
              body,
            ),
      );
      verify(
        () => mockHttpClient.delete(
          Uri.parse(url),
          headers: headers,
          body: body,
        ),
      );
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('Should capture any unexpected error', () async {
      const url = 'https://some-url.com';
      const headers = {'Key': 'value'};
      const requestBody = '{"key": "value"}';

      when(
        () => mockHttpClient.delete(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      ).thenThrow(Exception('Unexpected Exception'));

      final call = httpClient.delete;

      expect(
        call(url, headers: headers, body: requestBody),
        throwsA(isA<HttpClientException>()),
      );
      verify(
        () => mockHttpClient.delete(
          Uri.parse(url),
          headers: headers,
          body: requestBody,
        ),
      );
      verifyNoMoreInteractions(mockHttpClient);
    });
  });
}
