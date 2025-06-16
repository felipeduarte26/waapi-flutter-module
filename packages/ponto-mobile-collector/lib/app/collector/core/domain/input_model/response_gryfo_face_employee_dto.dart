import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResponseGryfoFaceEmployeeDto extends Equatable {
  final String? message;
  final int? statusCode;
  final bool? success;

  const ResponseGryfoFaceEmployeeDto({
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

  factory ResponseGryfoFaceEmployeeDto.fromMap(Map<String, dynamic> map) {
    return ResponseGryfoFaceEmployeeDto(
      message: map['message'],
      statusCode: map['statusCode'],
      success: map['success'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseGryfoFaceEmployeeDto.fromJson(String source) =>
      ResponseGryfoFaceEmployeeDto.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        message,
        statusCode,
        success,
      ];
}
