import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/set_space_membership_usecase.dart';
import '../../../enums/social_space_membership_enum.dart';
import '../../../enums/social_space_privacy_enum.dart';
import 'social_space_membership_event.dart';
import 'social_space_membership_state.dart';

class SocialSpaceMembershipBloc extends Bloc<SocialSpaceMembershipEvent, SocialSpaceMembershipState> {
  final SetSpaceMembershipUsecase _setSpaceMembershipUsecase;

  SocialSpaceMembershipBloc({required SetSpaceMembershipUsecase setSpaceMembershipUsecase})
      : _setSpaceMembershipUsecase = setSpaceMembershipUsecase,
        super(InitialSocialSpaceMembershipState()) {
    on<GetSocialSpaceMembershipEvent>(_setSpaceMembership);
  }

  Future<void> _setSpaceMembership(
    GetSocialSpaceMembershipEvent event,
    Emitter emit,
  ) async {
    emit(LoadingSocialSpaceMembershipState());

    final result = await _setSpaceMembershipUsecase.call(
      spaceId: event.socialSpaceModel.spaceId!,
      isMember: _isMember(event.socialSpaceModel.isMember!),
    );

    result.fold((left) {
      emit(ErrorSocialSpaceMembershipState());
    }, (right) {
      final isPublic = event.socialSpaceModel.privacy == SocialSpacePrivacyEnum.public;
      if (isPublic && _isMember(right.isMember)) {
        emit(EnterSocialSpaceMembershipState());
      }
      if (_isNotAMember(right.isMember)) {
        emit(LeaveSocialSpaceMembershipState());
      }
      if (!isPublic && _isWaitingApproval(right.isMember)) {
        emit(WaitingAprovalSocialSpaceMembershipState());
      }
    });
  }

  bool _isMember(SocialSpaceMembershipEnum membershipEnum) {
    return membershipEnum == SocialSpaceMembershipEnum.member;
  }

  bool _isWaitingApproval(SocialSpaceMembershipEnum membershipEnum) {
    return membershipEnum == SocialSpaceMembershipEnum.waitingApproval;
  }

  bool _isNotAMember(SocialSpaceMembershipEnum membershipEnum) {
    return membershipEnum == SocialSpaceMembershipEnum.notAMember;
  }
}
