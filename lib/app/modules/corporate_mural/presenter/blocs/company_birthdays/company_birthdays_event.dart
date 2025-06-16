import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';

abstract class CompanyBirthdaysEvent extends Equatable {
  const CompanyBirthdaysEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetNext15DaysBirthdaysCompanyEvent extends CompanyBirthdaysEvent {
  final PaginationRequirements paginationRequirements;
  final DateTime currentDate;
  final String employeeId;

  const GetNext15DaysBirthdaysCompanyEvent({
    required this.paginationRequirements,
    required this.currentDate,
    required this.employeeId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      paginationRequirements,
      currentDate,
    ];
  }
}

class ReloadNext15DaysBirthdaysCompanyEvent extends CompanyBirthdaysEvent {
  const ReloadNext15DaysBirthdaysCompanyEvent();

  @override
  List<Object> get props {
    return [
      ...super.props,
    ];
  }
}
