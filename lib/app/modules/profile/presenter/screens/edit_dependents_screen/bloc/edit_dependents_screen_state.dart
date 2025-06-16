import 'package:equatable/equatable.dart';

import '../../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/dependent_bloc/dependent_state.dart';
import '../../../blocs/edit_dependents_bloc/edit_dependents_bloc.dart';
import '../../../blocs/education_degree_bloc/education_degree_state.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';

abstract class EditDependentsScreenState extends Equatable {
  final EducationDegreeState getEducationDegreeState;
  final NeedAttachmentEditState getNeedAttachmentEditState;
  final SearchNaturalityState searchNaturalityState;
  final WaapiManagementPanelUploaderState waapiManagementPanelUploaderState;
  final EditDependentsState editDependentsState;
  final ActiveContractState activeContractState;
  final DependentState dependentState;
  final AuthorizationState authorizationState;
  const EditDependentsScreenState({
    required this.getEducationDegreeState,
    required this.getNeedAttachmentEditState,
    required this.searchNaturalityState,
    required this.waapiManagementPanelUploaderState,
    required this.editDependentsState,
    required this.activeContractState,
    required this.dependentState,
    required this.authorizationState,
  });

  CurrentEditDependentsScreenState currentState({
    EducationDegreeState? getEducationDegreeState,
    NeedAttachmentEditState? getNeedAttachmentEditState,
    SearchNaturalityState? searchNaturalityState,
    WaapiManagementPanelUploaderState? waapiManagementPanelUploaderState,
    EditDependentsState? editDependentsState,
    ActiveContractState? activeContractState,
    DependentState? dependentState,
    AuthorizationState? authorizationState,
  }) {
    return CurrentEditDependentsScreenState(
      getEducationDegreeState: getEducationDegreeState ?? this.getEducationDegreeState,
      getNeedAttachmentEditState: getNeedAttachmentEditState ?? this.getNeedAttachmentEditState,
      searchNaturalityState: searchNaturalityState ?? this.searchNaturalityState,
      waapiManagementPanelUploaderState: waapiManagementPanelUploaderState ?? this.waapiManagementPanelUploaderState,
      editDependentsState: editDependentsState ?? this.editDependentsState,
      activeContractState: activeContractState ?? this.activeContractState,
      dependentState: dependentState ?? this.dependentState,
      authorizationState: authorizationState ?? this.authorizationState,
    );
  }

  @override
  List<Object> get props => [
        getEducationDegreeState,
        getNeedAttachmentEditState,
        searchNaturalityState,
        editDependentsState,
        waapiManagementPanelUploaderState,
        activeContractState,
        dependentState,
        authorizationState,
      ];
}

class CurrentEditDependentsScreenState extends EditDependentsScreenState {
  const CurrentEditDependentsScreenState({
    required final EducationDegreeState getEducationDegreeState,
    required final NeedAttachmentEditState getNeedAttachmentEditState,
    required final SearchNaturalityState searchNaturalityState,
    required final WaapiManagementPanelUploaderState waapiManagementPanelUploaderState,
    required final EditDependentsState editDependentsState,
    required final ActiveContractState activeContractState,
    required final DependentState dependentState,
    required final AuthorizationState authorizationState,
  }) : super(
          getEducationDegreeState: getEducationDegreeState,
          getNeedAttachmentEditState: getNeedAttachmentEditState,
          searchNaturalityState: searchNaturalityState,
          waapiManagementPanelUploaderState: waapiManagementPanelUploaderState,
          editDependentsState: editDependentsState,
          activeContractState: activeContractState,
          dependentState: dependentState,
          authorizationState: authorizationState,
        );
}
