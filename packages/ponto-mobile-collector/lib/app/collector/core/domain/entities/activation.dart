import 'package:equatable/equatable.dart';
import '../enums/activation_situation_type.dart';
import '../enums/status_device.dart';

class Activation extends Equatable {
  final String? id;
  final StatusDevice deviceSituation;
  final ActivationSituationType employeeSituation;
  final String requestDate;
  final String requestTime;

  const Activation({
    this.id,
    required this.deviceSituation,
    required this.employeeSituation,
    required this.requestDate,
    required this.requestTime,
  });

  Activation copyWith({
    String? id,
    StatusDevice? deviceSituation,
    ActivationSituationType? employeeSituation,
    String? requestDate,
    String? requestTime,
  }) {
    return Activation(
      id: id ?? this.id,
      deviceSituation: deviceSituation ?? this.deviceSituation,
      employeeSituation: employeeSituation ?? this.employeeSituation,
      requestDate: requestDate ?? this.requestDate,
      requestTime: requestTime ?? this.requestTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        deviceSituation,
        employeeSituation,
        requestDate,
        requestTime,
      ];
}
