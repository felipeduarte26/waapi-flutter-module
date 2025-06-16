import 'package:equatable/equatable.dart';

import '../../../domain/entities/civil_certificate_entity.dart';

abstract class CivilCertificateEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class CivilCertificateProfileEvent extends CivilCertificateEvent {
  CivilCertificateProfileEvent();

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}

class SelectCivilCertificateFromEntityToProfileEvent extends CivilCertificateEvent {
  final CivilCertificateEntity civilCertificateEntity;

  SelectCivilCertificateFromEntityToProfileEvent({
    required this.civilCertificateEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      civilCertificateEntity,
    ];
  }
}

class UnselectCivilCertificateFromEntityToProfileEvent extends CivilCertificateEvent {
  final CivilCertificateEntity civilCertificateEntity;

  UnselectCivilCertificateFromEntityToProfileEvent({
    required this.civilCertificateEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      civilCertificateEntity,
    ];
  }
}

class ClearCivilCertificateProfileEvent extends CivilCertificateEvent {}
