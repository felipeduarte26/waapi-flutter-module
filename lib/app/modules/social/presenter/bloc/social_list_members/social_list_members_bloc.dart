import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_members_usecase.dart';

import 'social_list_members_bloc_event_transformer.dart';
import 'social_list_members_event.dart';
import 'social_list_members_state.dart';

class SocialListMembersBloc extends Bloc<SocialListMembersEvent, SocialListMembersState> {
  final GetMembersUsecase _getListMembersUsecase;

  SocialListMembersBloc({
    required GetMembersUsecase getListMembersUsecase,
  })  : _getListMembersUsecase = getListMembersUsecase,
        super(const InitialSocialListMembersState()) {
    on<GetSocialListMembersEvent>(
      _getSocialListMembersEvent,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );
  }

  Future<void> _getSocialListMembersEvent(
    GetSocialListMembersEvent event,
    Emitter<SocialListMembersState> emit,
  ) async {
    final bool isAllowedToGetMorePerson = (state is! LoadingMoreSocialListMembersState &&
        state is! LastPageSocialListMembersState &&
        (state is! ErrorSocialListMembersState || state is! ErrorMoreSocialListMembersState));

    if (!isAllowedToGetMorePerson) {
      return;
    }

    if (state.searchTerm != event.paginationRequirements.queryText) {
      emit(
        state.loadingSocialListMembersState(
          searchTerm: event.paginationRequirements.queryText.trim(),
        ),
      );
    } else {
      emit(
        state.loadingMoreSocialListMembersState(
          socialProfiles: event.paginationRequirements.page == 0 ? [] : state.socialProfiles,
          searchTerm: state.searchTerm.trim(),
        ),
      );
    }

    final people = await _getListMembersUsecase.call(
      paginationRequirements: event.paginationRequirements,
    );

    people.fold(
      (left) {
        if (state.socialProfiles.isEmpty) {
          emit(
            state.errorSocialListMembersState(
              searchTerm: event.paginationRequirements.queryText.trim(),
            ),
          );
        } else {
          emit(
            state.errorMoreSocialListMembersState(
              socialProfiles: state.socialProfiles,
              searchTerm: state.searchTerm.trim(),
            ),
          );
        }
      },
      (right) {
        if (right.isEmpty) {
          if (state.socialProfiles.isEmpty) {
            emit(
              state.emptySocialListMembersState(
                searchTerm: event.paginationRequirements.queryText.trim(),
              ),
            );
          } else {
            emit(
              state.lastPageSocialListMembersState(
                socialProfiles: state.socialProfiles,
                searchTerm: state.searchTerm.trim(),
              ),
            );
          }
        } else {
          emit(
            state.loadedSocialListMembersState(
              socialProfiles: state.socialProfiles + right,
              searchTerm: state.searchTerm.trim(),
            ),
          );
        }
      },
    );
  }
}
