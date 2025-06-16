import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/social_space_entity.dart';
import '../../../domain/usecases/get_social_members_space_usecase.dart';
import 'social_spaces_event.dart';
import 'social_spaces_state.dart';

class SocialSpacesBloc extends Bloc<SocialSpacesEvent, SocialSpacesState> {
  final GetSocialMembersSpaceUsecase _getSocialMembersSpaceUsecase;

  SocialSpacesBloc({
    required GetSocialMembersSpaceUsecase getSocialMembersSpaceUsecase,
  })  : _getSocialMembersSpaceUsecase = getSocialMembersSpaceUsecase,
        super(InitialSocialSpacesState()) {
    on<GetSocialSpacesEvent>(_getSocialSpacesEvent);
    on<GetMoreSocialSpacesEvent>(_getMoreSocialSpacesEvent);
  }

  Future<void> _getSocialSpacesEvent(
    GetSocialSpacesEvent event,
    Emitter<SocialSpacesState> emit,
  ) async {
    emit(LoadingSocialSpacesState());

    final socialSpaces = await _getSocialMembersSpaceUsecase.call(
      paginationRequirements: event.paginationRequirements,
    );

    socialSpaces.fold(
      (left) {
        emit(
          ErrorSocialSpacesState(),
        );
      },
      (right) {
        emit(
          LoadedSocialSpacesState(
            socialSpaces: right,
          ),
        );
      },
    );
    emit(
      InitialSocialSpacesState(),
    );
  }

  Future<void> _getMoreSocialSpacesEvent(
    GetMoreSocialSpacesEvent event,
    Emitter<SocialSpacesState> emit,
  ) async {
    final socialSpaces = await _getSocialMembersSpaceUsecase.call(
      paginationRequirements: event.paginationRequirements,
    );

    socialSpaces.fold(
      (left) {
        emit(
          ErrorSocialSpacesState(),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(
            LoadedMoreSocialSpacesState(
              socialSpaces: event.socialSpaces,
            ),
          );
          return;
        } else {
          var socialSpaces = right;
          for (var space in event.socialSpaces) {
            if (right.contains(space)) {
              socialSpaces.remove(space);
            }
          }
          List<SocialSpaceEntity> newSpaces = event.socialSpaces;
          newSpaces.addAll(socialSpaces);
          emit(
            LoadedMoreSocialSpacesState(
              socialSpaces: newSpaces,
            ),
          );
        }
      },
    );
    emit(
      InitialSocialSpacesState(),
    );
  }
}
