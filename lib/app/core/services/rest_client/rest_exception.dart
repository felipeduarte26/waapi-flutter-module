import 'package:equatable/equatable.dart';

import 'rest_response.dart';

/// This class represents a HTTP client exception.
class RestException extends Equatable implements Exception {
  /// Contains the message emitted by the exception.
  final String? message;

  /// Contains the HTTP status code from the exception.
  final int? statusCode;

  /// Contains the error emitted by the exception.
  final dynamic error;

  /// Contains the stacktrace emitted by the exception.
  final dynamic stackTrace;

  /// Contains the request HTTP response.
  final RestResponse? response;

  /// Contains the request HTTP any additional information.
  final Map<String, dynamic>? additionalInfo;

  /// Creates a new instance of the HTTP client exception.
  const RestException({
    this.message,
    this.statusCode,
    this.error,
    this.stackTrace,
    this.response,
    this.additionalInfo,
  });

  @override
  List<Object?> get props {
    return [
      message,
      statusCode,
      error,
      stackTrace,
      response,
      additionalInfo,
    ];
  }
}
