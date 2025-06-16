import 'package:http/http.dart' as http;

import '../../../domain/services/http_client/abstractions/http_response.dart';
import '../../../domain/services/http_client/i_http_client.dart';
import 'exception/http_client_exception.dart';


class HttpClient implements IHttpClient {
  final http.Client _httpClient;

  const HttpClient(this._httpClient);

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: headers,
      );

      return HttpResponse(
        body: response.body,
        statusCode: response.statusCode,
      );
    } catch (exception) {
      throw HttpClientException(exception: exception);
    }
  }

  @override
  Future<HttpResponse> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      return HttpResponse(
        body: response.body,
        statusCode: response.statusCode,
      );
    } catch (exception) {
      throw HttpClientException(exception: exception);
    }
  }

  @override
  Future<HttpResponse> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _httpClient.put(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      return HttpResponse(
        body: response.body,
        statusCode: response.statusCode,
      );
    } catch (exception) {
      throw HttpClientException(exception: exception);
    }
  }

  @override
  Future<HttpResponse> delete(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _httpClient.delete(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      return HttpResponse(
        body: response.body,
        statusCode: response.statusCode,
      );
    } catch (exception) {
      throw HttpClientException(exception: exception);
    }
  }
}
