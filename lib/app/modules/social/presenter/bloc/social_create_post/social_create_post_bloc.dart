import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/create_post_usecase.dart';
import 'social_create_post_event.dart';
import 'social_create_post_state.dart';

class SocialCreatePostBloc extends Bloc<SocialCreatePostEvent, SocialCreatePostState> {
  final CreatePostUsecase _socialCreatePostUseCase;

  SocialCreatePostBloc({
    required CreatePostUsecase socialCreatePostUseCase,
  })  : _socialCreatePostUseCase = socialCreatePostUseCase,
        super(InitialSocialCreatePostState()) {
    on<CreateSocialPostEvent>(_createSocialPost);
  }

  Future<void> _createSocialPost(
    CreateSocialPostEvent event,
    Emitter emit,
  ) async {
    emit(LoadingSocialCreatePostState());

    final result = await _socialCreatePostUseCase.call(
      socialCreatePostIntputModel: event.socialCreatePostInputModel,
    );

    result.fold(
      (left) {
        emit(ErrorSocialCreatePostState());
      },
      (right) {
        emit(CreatedSocialCreatePostState(socialPostEntity: right));
      },
    );
  }
}
