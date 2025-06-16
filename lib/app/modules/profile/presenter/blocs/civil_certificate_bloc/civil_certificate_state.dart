import 'package:equatable/equatable.dart';

import '../../../domain/entities/civil_certificate_entity.dart';

abstract class CivilCertificateState extends Equatable {
  final List<CivilCertificateEntity> civilCertificateList;
  final CivilCertificateEntity? selectedCivilCertificate;

  const CivilCertificateState({
    this.civilCertificateList = const [],
    this.selectedCivilCertificate,
  });

  CivilCertificateState initialCivilCertificateState() {
    return InitialCivilCertificateState(
      selectedCivilCertificateEntity: selectedCivilCertificate,
    );
  }

  CivilCertificateState loadedSelectCivilCertificateState({
    required CivilCertificateEntity selectedCivilCertificateEntity,
  }) {
    return LoadedSelectCivilCertificateState(
      civilCertificateList: civilCertificateList,
      selectedCivilCertificateEntity: selectedCivilCertificateEntity,
    );
  }

  CivilCertificateState unselectCivilCertificateState({
    required CivilCertificateEntity selectedselectedCivilCertificateEntity,
  }) {
    return UnselectCivilCertificateState(
      civilCertificateList: civilCertificateList,
      selectedCivilCertificateEntity: selectedselectedCivilCertificateEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      civilCertificateList,
      selectedCivilCertificate,
    ];
  }
}

class InitialCivilCertificateState extends CivilCertificateState {
  const InitialCivilCertificateState({
    CivilCertificateEntity? selectedCivilCertificateEntity,
  }) : super(
          civilCertificateList: const [],
          selectedCivilCertificate: selectedCivilCertificateEntity,
        );
}

class LoadingCivilCertificateState extends CivilCertificateState {
  const LoadingCivilCertificateState({
    CivilCertificateEntity? selectedCivilCertificateEntity,
  }) : super(
          civilCertificateList: const [],
          selectedCivilCertificate: selectedCivilCertificateEntity,
        );
}

class LoadedCivilCertificateState extends CivilCertificateState {
  const LoadedCivilCertificateState({
    required List<CivilCertificateEntity> civilCertificateList,
    CivilCertificateEntity? selectedCivilCertificateEntity,
  }) : super(
          civilCertificateList: civilCertificateList,
          selectedCivilCertificate: selectedCivilCertificateEntity,
        );
}

class LoadingSelectCivilCertificateState extends CivilCertificateState {
  const LoadingSelectCivilCertificateState({
    CivilCertificateEntity? selectedCivilCertificateEntity,
  }) : super(
          selectedCivilCertificate: selectedCivilCertificateEntity,
        );
}

class LoadedSelectCivilCertificateState extends CivilCertificateState {
  const LoadedSelectCivilCertificateState({
    required List<CivilCertificateEntity> civilCertificateList,
    required CivilCertificateEntity selectedCivilCertificateEntity,
  }) : super(
          civilCertificateList: civilCertificateList,
          selectedCivilCertificate: selectedCivilCertificateEntity,
        );
}

class UnselectCivilCertificateState extends CivilCertificateState {
  const UnselectCivilCertificateState({
    required List<CivilCertificateEntity> civilCertificateList,
    CivilCertificateEntity? selectedCivilCertificateEntity,
  }) : super(
          civilCertificateList: civilCertificateList,
          selectedCivilCertificate: selectedCivilCertificateEntity,
        );
}
