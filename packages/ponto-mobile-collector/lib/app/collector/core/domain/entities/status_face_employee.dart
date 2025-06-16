import 'dart:convert';

import 'package:equatable/equatable.dart';

class StatusFaceEmployee extends Equatable {
  final String? message;
  final int? statusCode;
  final bool? success;

  const StatusFaceEmployee({
    this.message,
    this.statusCode,
    this.success,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'statusCode': statusCode,
      'success': success,
    };
  }

  factory StatusFaceEmployee.fromMap(Map<String, dynamic> map) {
    return StatusFaceEmployee(
      message: map['message'],
      statusCode: map['statusCode'],
      success: map['success'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusFaceEmployee.fromJson(String source) =>
      StatusFaceEmployee.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        message,
        statusCode,
        success,
      ];
}
