import 'package:equatable/equatable.dart';

abstract class CompanyNameEvent extends Equatable {
  const CompanyNameEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetCompanyNameEvent extends CompanyNameEvent {
  final String employeeId;

  const GetCompanyNameEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      employeeId,
    ];
  }
}
