import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/diversity_bloc/diversity_bloc.dart';
import '../../../blocs/gender_identity_bloc/gender_identity_bloc.dart';
import '../../../blocs/sexual_orientation_bloc/sexual_orientation_bloc.dart';
import '../../../blocs/update_personal_diversity_bloc/update_personal_diversity_bloc.dart';
import 'edit_personal_diversity_screen_event.dart';
import 'edit_personal_diversity_screen_state.dart';

class EditPersonalDiversityScreenBloc extends Bloc<EditPersonalDiversityScreenEvent, EditPersonalDiversityScreenState> {
  final GenderIdentityBloc getGenderIdentityBloc;
  final SexualOrientationBloc getSexualOrientationBloc;
  final DiversityBloc getDiversityBloc;
  final UpdatePersonalDiversityBloc updatePersonalDiversityBloc;

  late StreamSubscription getGenderIdentitySubscription;
  late StreamSubscription getSexualOrientationSubscription;
  late StreamSubscription getDiversitySubscription;
  late StreamSubscription updatePersonalDiversitySubscription;

  EditPersonalDiversityScreenBloc({
    required this.getGenderIdentityBloc,
    required this.getSexualOrientationBloc,
    required this.getDiversityBloc,
    required this.updatePersonalDiversityBloc,
  }) : super(
          CurrentEditPersonalDiversityScreenState(
            getGenderIdentityState: getGenderIdentityBloc.state,
            getSexualOrientationState: getSexualOrientationBloc.state,
            getDiversityState: getDiversityBloc.state,
            updatePersonalDiversityState: updatePersonalDiversityBloc.state,
          ),
        ) {
    on<ChangeGenderIdentityStateEvent>(_changeGetGenderIdentityStateEvent);
    on<ChangeSexualOrientationStateEvent>(_changeGetSexualOrientationStateEvent);
    on<ChangeDiversityStateEvent>(_changeGetDiversityStateEvent);
    on<ChangeUpdatePersonalDiversityStateEvent>(_changeUpdatePersonalDiversityStateEvent);

    getGenderIdentitySubscription = getGenderIdentityBloc.stream.listen(
      (getGenderIdentityState) {
        add(
          ChangeGenderIdentityStateEvent(
            getGenderIdentityState: getGenderIdentityState,
          ),
        );
      },
    );

    getSexualOrientationSubscription = getSexualOrientationBloc.stream.listen(
      (getSexualOrientationState) {
        add(
          ChangeSexualOrientationStateEvent(
            getSexualOrientationState: getSexualOrientationState,
          ),
        );
      },
    );

    getDiversitySubscription = getDiversityBloc.stream.listen(
      (getDiversityState) {
        add(
          ChangeDiversityStateEvent(
            getDiversityState: getDiversityState,
          ),
        );
      },
    );

    updatePersonalDiversitySubscription = updatePersonalDiversityBloc.stream.listen(
      (updatePersonalDiversityState) {
        add(
          ChangeUpdatePersonalDiversityStateEvent(
            updatePersonalDiversityState: updatePersonalDiversityState,
          ),
        );
      },
    );
  }

  Future<void> _changeGetGenderIdentityStateEvent(
    ChangeGenderIdentityStateEvent event,
    Emitter<EditPersonalDiversityScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getGenderIdentityState: event.getGenderIdentityState,
      ),
    );
  }

  Future<void> _changeGetSexualOrientationStateEvent(
    ChangeSexualOrientationStateEvent event,
    Emitter<EditPersonalDiversityScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getSexualOrientationState: event.getSexualOrientationState,
      ),
    );
  }

  Future<void> _changeGetDiversityStateEvent(
    ChangeDiversityStateEvent event,
    Emitter<EditPersonalDiversityScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getDiversityState: event.getDiversityState,
      ),
    );
  }

  Future<void> _changeUpdatePersonalDiversityStateEvent(
    ChangeUpdatePersonalDiversityStateEvent event,
    Emitter<EditPersonalDiversityScreenState> emit,
  ) async {
    emit(
      state.currentState(
        updatePersonalDiversityState: event.updatePersonalDiversityState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await getGenderIdentitySubscription.cancel();
    await getSexualOrientationSubscription.cancel();
    await getDiversitySubscription.cancel();
    await updatePersonalDiversitySubscription.cancel();
    return super.close();
  }
}
