import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/input_model/response_gryfo_face_employee_dto.dart';

class ResponseGryfoFaceEmployeeOutput extends Equatable {
  final ResponseGryfoFaceEmployeeDto? responseGryfoFaceEmployeeInsert;

  const ResponseGryfoFaceEmployeeOutput({
    required this.responseGryfoFaceEmployeeInsert,
  });

  Map<String, dynamic> toMap() {
    return {
      'responseGryfoFaceEmployeeInsert':
          responseGryfoFaceEmployeeInsert?.toMap(),
    };
  }

  factory ResponseGryfoFaceEmployeeOutput.fromMap(Map<String, dynamic> map) {
    return ResponseGryfoFaceEmployeeOutput(
      responseGryfoFaceEmployeeInsert: map['responseGryfoFaceEmployeeInsert'] ==
              null
          ? null
          : ResponseGryfoFaceEmployeeDto.fromMap(
              map['responseGryfoFaceEmployeeInsert'] as Map<String, dynamic>,
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseGryfoFaceEmployeeOutput.fromJson(String source) =>
      ResponseGryfoFaceEmployeeOutput.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        responseGryfoFaceEmployeeInsert,
      ];
}
