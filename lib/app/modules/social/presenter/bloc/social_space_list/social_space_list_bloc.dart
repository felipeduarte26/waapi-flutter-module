import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_spaces_usecase.dart';
import 'social_space_list_event.dart';
import 'social_space_list_state.dart';

class SocialSpaceListBloc extends Bloc<SocialSpaceListEvent, SocialSpaceListState> {
  final GetSpacesUsecase _getSpacesUsecase;

  SocialSpaceListBloc({
    required GetSpacesUsecase getSpacesUsecase,
  })  : _getSpacesUsecase = getSpacesUsecase,
        super(InitialSocialSpaceListState()) {
    on<GetSocialSpaceListEvent>(_getSocialSpaceListEvent);
  }

  Future<void> _getSocialSpaceListEvent(
    GetSocialSpaceListEvent event,
    Emitter<SocialSpaceListState> emit,
  ) async {
    event.socialSpaceEntityList.isEmpty
        ? emit(
            LoadingSocialSpaceListState(),
          )
        : emit(
            LoadingMoreSocialSpaceListState(socialSpaceEntityList: event.socialSpaceEntityList),
          );

    final socialSpaceList = await _getSpacesUsecase.call(
      paginationRequirements: event.paginationRequirements,
    );

    socialSpaceList.fold(
      (left) {
        if (event.socialSpaceEntityList.isNotEmpty) {
          return emit(ErrorLoadedMoreSocialSpaceListState(socialSpaceEntityList: event.socialSpaceEntityList));
        }
        return emit(
          const ErrorSocialSpaceListState(
            socialSpaceEntityList: [],
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          if (event.socialSpaceEntityList.isEmpty) {
            return emit(
              EmptySocialSpaceListState(),
            );
          }
          return emit(
            EmptyLoadedMoreSocialSpaceListState(socialSpaceEntityList: event.socialSpaceEntityList),
          );
        }

        if (event.socialSpaceEntityList.isNotEmpty) {
          emit(
            LoadedMoreSocialSpaceListState(
              socialSpaceEntityList: [
                ...event.socialSpaceEntityList,
                ...right,
              ],
            ),
          );
        } else {
          emit(
            LoadedSocialSpaceListState(socialSpaceEntityList: right),
          );
        }
      },
    );
  }
}
