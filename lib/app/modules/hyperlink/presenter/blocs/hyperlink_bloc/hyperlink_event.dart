// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class HyperlinkEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetHyperlinkEvent extends HyperlinkEvent {
  final String employeeId;
  final String userRoleId;

  GetHyperlinkEvent({
    required this.employeeId,
    required this.userRoleId,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      employeeId,
      userRoleId,
    ];
  }
}
