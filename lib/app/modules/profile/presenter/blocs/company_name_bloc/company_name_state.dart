import 'package:equatable/equatable.dart';

abstract class CompanyNameState extends Equatable {
  const CompanyNameState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialCompanyNameState extends CompanyNameState {}

class LoadingCompanyNameState extends CompanyNameState {}

class LoadedCompanyNameState extends CompanyNameState {
  final String companyName;

  const LoadedCompanyNameState({
    required this.companyName,
  });
}

class ErrorCompanyNameState extends CompanyNameState {}
