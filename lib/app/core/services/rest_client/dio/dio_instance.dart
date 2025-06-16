import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'dio_interceptor.dart';

class DioInstance {
  Dio getDioInstance() {
    Dio dio = Dio();

    if (kDebugMode) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient(
            context: SecurityContext(
              withTrustedRoots: false,
            ),
          );

          client.badCertificateCallback = (cert, host, port) => true;
          return client;
        },
      );
    }

    dio.options.sendTimeout = const Duration(
      milliseconds: 30000,
    );

    dio.options.connectTimeout = const Duration(
      milliseconds: 30000,
    );

    dio.interceptors.add(
      DioInterceptor(
        dio: dio,
      ),
    );
    return dio;
  }
}
