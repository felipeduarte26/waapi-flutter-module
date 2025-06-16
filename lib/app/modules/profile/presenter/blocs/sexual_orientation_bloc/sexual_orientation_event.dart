import 'package:equatable/equatable.dart';

import '../../../domain/entities/sexual_orientation_entity.dart';

abstract class SexualOrientationEvent extends Equatable {
  @override
  List<Object> get props {
    return [];
  }
}

class GetSexualOrientationProfileEvent extends SexualOrientationEvent {}

class SelectSexualOrientationFromEntityToProfileEvent extends SexualOrientationEvent {
  final SexualOrientationEntity genderIdentityEntity;

  SelectSexualOrientationFromEntityToProfileEvent({
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

class UnselectSexualOrientationFromEntityToProfileEvent extends SexualOrientationEvent {
  final SexualOrientationEntity genderIdentityEntity;

  UnselectSexualOrientationFromEntityToProfileEvent({
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

class ClearSexualOrientationProfileEvent extends SexualOrientationEvent {}
