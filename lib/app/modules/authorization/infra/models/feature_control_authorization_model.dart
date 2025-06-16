import 'package:equatable/equatable.dart';

class FeatureControlAuthorizationModel extends Equatable {
  final bool allowUpdatePersonalData;
  final bool allowUpdatePersonalContact;
  final bool allowUpdateEmergencyContact;
  final bool allowUpdatePersonalAddress;
  final bool allowUpdatePersonalDocuments;
  final bool allowUpdatePersonalDependents;
  final bool enableDependentIncomeTax;
  final bool allowToPayroll;
  final bool enablePersonalPhoto;
  final bool allowToMaintainSelfDeclaration;

  const FeatureControlAuthorizationModel({
    required this.allowUpdatePersonalData,
    required this.allowUpdateEmergencyContact,
    required this.allowUpdatePersonalAddress,
    required this.allowUpdatePersonalContact,
    required this.allowUpdatePersonalDocuments,
    required this.allowUpdatePersonalDependents,
    required this.enableDependentIncomeTax,
    required this.allowToPayroll,
    required this.enablePersonalPhoto,
    required this.allowToMaintainSelfDeclaration,
  });

  factory FeatureControlAuthorizationModel.empty() {
    return const FeatureControlAuthorizationModel(
      allowUpdatePersonalData: false,
      allowUpdatePersonalContact: false,
      allowUpdateEmergencyContact: false,
      allowUpdatePersonalAddress: false,
      allowUpdatePersonalDocuments: false,
      allowUpdatePersonalDependents: false,
      enableDependentIncomeTax: false,
      allowToPayroll: false,
      enablePersonalPhoto: false,
      allowToMaintainSelfDeclaration: false,
    );
  }

  @override
  List<Object?> get props {
    return [
      allowUpdatePersonalData,
      allowUpdatePersonalContact,
      allowUpdateEmergencyContact,
      allowUpdatePersonalAddress,
      allowUpdatePersonalDocuments,
      allowUpdatePersonalDependents,
      enableDependentIncomeTax,
      allowToPayroll,
      enablePersonalPhoto,
      allowToMaintainSelfDeclaration,
    ];
  }
}
