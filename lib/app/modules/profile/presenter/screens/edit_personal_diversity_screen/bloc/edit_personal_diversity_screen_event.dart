import 'package:equatable/equatable.dart';

import '../../../blocs/diversity_bloc/diversity_state.dart';
import '../../../blocs/gender_identity_bloc/gender_identity_state.dart';
import '../../../blocs/sexual_orientation_bloc/sexual_orientation_state.dart';
import '../../../blocs/update_personal_diversity_bloc/update_personal_diversity_state.dart';

abstract class EditPersonalDiversityScreenEvent extends Equatable {}

class ChangeGenderIdentityStateEvent extends EditPersonalDiversityScreenEvent {
  final GenderIdentityState getGenderIdentityState;

  ChangeGenderIdentityStateEvent({
    required this.getGenderIdentityState,
  });

  @override
  List<Object?> get props {
    return [
      getGenderIdentityState,
    ];
  }
}

class ChangeSexualOrientationStateEvent extends EditPersonalDiversityScreenEvent {
  final SexualOrientationState getSexualOrientationState;

  ChangeSexualOrientationStateEvent({
    required this.getSexualOrientationState,
  });

  @override
  List<Object?> get props {
    return [
      getSexualOrientationState,
    ];
  }
}

class ChangeDiversityStateEvent extends EditPersonalDiversityScreenEvent {
  final DiversityState getDiversityState;

  ChangeDiversityStateEvent({
    required this.getDiversityState,
  });

  @override
  List<Object?> get props {
    return [
      getDiversityState,
    ];
  }
}

class ChangeUpdatePersonalDiversityStateEvent extends EditPersonalDiversityScreenEvent {
  final UpdatePersonalDiversityState updatePersonalDiversityState;

  ChangeUpdatePersonalDiversityStateEvent({
    required this.updatePersonalDiversityState,
  });

  @override
  List<Object?> get props {
    return [
      updatePersonalDiversityState,
    ];
  }
}
