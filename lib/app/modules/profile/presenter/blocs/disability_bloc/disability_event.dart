import 'package:equatable/equatable.dart';

import '../../../domain/entities/disability_entity.dart';

abstract class DisabilityEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class DisabilityProfileEvent extends DisabilityEvent {
  DisabilityProfileEvent();

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}

class SelectDisabilityFromEntityToProfileEvent extends DisabilityEvent {
  final DisabilityEntity disabilityEntity;

  SelectDisabilityFromEntityToProfileEvent({
    required this.disabilityEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      disabilityEntity,
    ];
  }
}

class UnselectDisabilityFromEntityToProfileEvent extends DisabilityEvent {
  final DisabilityEntity disabilityEntity;

  UnselectDisabilityFromEntityToProfileEvent({
    required this.disabilityEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      disabilityEntity,
    ];
  }
}

class ClearDisabilityProfileEvent extends DisabilityEvent {}
