import 'package:equatable/equatable.dart';

import '../../../blocs/diversity_bloc/diversity_state.dart';
import '../../../blocs/gender_identity_bloc/gender_identity_state.dart';
import '../../../blocs/sexual_orientation_bloc/sexual_orientation_state.dart';
import '../../../blocs/update_personal_diversity_bloc/update_personal_diversity_state.dart';

abstract class EditPersonalDiversityScreenState extends Equatable {
  final GenderIdentityState getGenderIdentityState;
  final SexualOrientationState getSexualOrientationState;
  final DiversityState getDiversityState;
  final UpdatePersonalDiversityState updatePersonalDiversityState;

  const EditPersonalDiversityScreenState({
    required this.getGenderIdentityState,
    required this.getSexualOrientationState,
    required this.getDiversityState,
    required this.updatePersonalDiversityState,
  });

  CurrentEditPersonalDiversityScreenState currentState({
    GenderIdentityState? getGenderIdentityState,
    SexualOrientationState? getSexualOrientationState,
    DiversityState? getDiversityState,
    UpdatePersonalDiversityState? updatePersonalDiversityState,
  }) {
    return CurrentEditPersonalDiversityScreenState(
      getGenderIdentityState: getGenderIdentityState ?? this.getGenderIdentityState,
      getSexualOrientationState: getSexualOrientationState ?? this.getSexualOrientationState,
      getDiversityState: getDiversityState ?? this.getDiversityState,
      updatePersonalDiversityState: updatePersonalDiversityState ?? this.updatePersonalDiversityState,
    );
  }

  @override
  List<Object?> get props {
    return [
      getGenderIdentityState,
      getSexualOrientationState,
      getDiversityState,
      updatePersonalDiversityState,
    ];
  }
}

class CurrentEditPersonalDiversityScreenState extends EditPersonalDiversityScreenState {
  const CurrentEditPersonalDiversityScreenState({
    required GenderIdentityState getGenderIdentityState,
    required SexualOrientationState getSexualOrientationState,
    required DiversityState getDiversityState,
    required UpdatePersonalDiversityState updatePersonalDiversityState,
  }) : super(
          getGenderIdentityState: getGenderIdentityState,
          getSexualOrientationState: getSexualOrientationState,
          getDiversityState: getDiversityState,
          updatePersonalDiversityState: updatePersonalDiversityState,
        );
}
