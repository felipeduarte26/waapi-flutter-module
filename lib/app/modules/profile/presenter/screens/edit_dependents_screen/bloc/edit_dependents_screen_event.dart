import 'package:equatable/equatable.dart';

import '../../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/dependent_bloc/dependent_state.dart';
import '../../../blocs/edit_dependents_bloc/edit_dependents_bloc.dart';
import '../../../blocs/education_degree_bloc/education_degree_state.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';

abstract class EditDependentsScreenEvent extends Equatable {}

class ChangeWaapiManagementPanelUploaderStateEvent extends EditDependentsScreenEvent {
  final WaapiManagementPanelUploaderState waapiManagementPanelUploaderState;

  ChangeWaapiManagementPanelUploaderStateEvent({
    required this.waapiManagementPanelUploaderState,
  });

  @override
  List<Object?> get props {
    return [
      waapiManagementPanelUploaderState,
    ];
  }
}

class ChangeEducationDegreeStateEvent extends EditDependentsScreenEvent {
  final EducationDegreeState educationDegreeState;

  ChangeEducationDegreeStateEvent({
    required this.educationDegreeState,
  });

  @override
  List<Object?> get props {
    return [
      educationDegreeState,
    ];
  }
}

class ChangeNeedAttachmentEditStateEvent extends EditDependentsScreenEvent {
  final NeedAttachmentEditState needAttachmentEditState;

  ChangeNeedAttachmentEditStateEvent({
    required this.needAttachmentEditState,
  });

  @override
  List<Object?> get props {
    return [
      needAttachmentEditState,
    ];
  }
}

class ChangeSearchNaturalityStateEvent extends EditDependentsScreenEvent {
  final SearchNaturalityState searchNaturalityState;

  ChangeSearchNaturalityStateEvent({
    required this.searchNaturalityState,
  });

  @override
  List<Object?> get props {
    return [
      searchNaturalityState,
    ];
  }
}

class ChangeEditDependentsStateEvent extends EditDependentsScreenEvent {
  final EditDependentsState editDependentsState;

  ChangeEditDependentsStateEvent({
    required this.editDependentsState,
  });

  @override
  List<Object?> get props {
    return [
      editDependentsState,
    ];
  }
}

class ChangeActiveContractStateEvent extends EditDependentsScreenEvent {
  final ActiveContractState activeContractState;

  ChangeActiveContractStateEvent({
    required this.activeContractState,
  });

  @override
  List<Object?> get props {
    return [
      activeContractState,
    ];
  }
}

class ChangeDependentStateEvent extends EditDependentsScreenEvent {
  final DependentState dependentState;

  ChangeDependentStateEvent({
    required this.dependentState,
  });

  @override
  List<Object?> get props {
    return [
      dependentState,
    ];
  }
}

class ChangeAuthorizationStateEvent extends EditDependentsScreenEvent {
  final AuthorizationState authorizationState;

  ChangeAuthorizationStateEvent({
    required this.authorizationState,
  });

  @override
  List<Object?> get props {
    return [
      authorizationState,
    ];
  }
}
