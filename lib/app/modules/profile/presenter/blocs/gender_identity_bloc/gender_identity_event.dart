import 'package:equatable/equatable.dart';

import '../../../domain/entities/gender_identity_entity.dart';

abstract class GenderIdentityEvent extends Equatable {
  @override
  List<Object> get props {
    return [];
  }
}

class GetGenderIdentityProfileEvent extends GenderIdentityEvent {}

class SelectGenderIdentityFromEntityToProfileEvent extends GenderIdentityEvent {
  final GenderIdentityEntity genderIdentityEntity;

  SelectGenderIdentityFromEntityToProfileEvent({
    required this.genderIdentityEntity,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      genderIdentityEntity,
    ];
  }
}

class UnselectGenderIdentityFromEntityToProfileEvent extends GenderIdentityEvent {
  final GenderIdentityEntity genderIdentityEntity;

  UnselectGenderIdentityFromEntityToProfileEvent({
    required this.genderIdentityEntity,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      genderIdentityEntity,
    ];
  }
}

class ClearGenderIdentityProfileEvent extends GenderIdentityEvent {}
