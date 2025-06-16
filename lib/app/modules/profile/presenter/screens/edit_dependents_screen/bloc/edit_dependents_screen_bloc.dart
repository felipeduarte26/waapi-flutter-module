import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_bloc.dart';
import '../../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../blocs/dependent_bloc/dependent_bloc.dart';
import '../../../blocs/edit_dependents_bloc/edit_dependents_bloc.dart';
import '../../../blocs/education_degree_bloc/education_degree_bloc.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_bloc.dart';
import '../../../blocs/search_naturality/search_naturality_bloc.dart';
import 'edit_dependents_screen_event.dart';
import 'edit_dependents_screen_state.dart';

class EditDependentsScreenBloc extends Bloc<EditDependentsScreenEvent, EditDependentsScreenState> {
  final EducationDegreeBloc educationDegreeBloc;
  final NeedAttachmentEditBloc needAttachmentEditBloc;
  final SearchNaturalityBloc searchNaturalityBloc;
  final WaapiManagementPanelUploaderBloc waapiManagementPanelUploaderBloc;
  final EditDependentsBloc editDependentsBloc;
  final ActiveContractBloc activeContractBloc;
  final DependentBloc dependentBloc;
  final AuthorizationBloc authorizationBloc;

  late StreamSubscription getNeedAttachmentSubscription;
  late StreamSubscription searchNaturalitySubscription;
  late StreamSubscription getEducationDegreeSubscription;
  late StreamSubscription getWaapiManagementPanelUploaderSubscription;
  late StreamSubscription editDependentsSubscription;
  late StreamSubscription activeContractSubscription;
  late StreamSubscription dependentSubscription;
  late StreamSubscription authorizationSubscription;

  EditDependentsScreenBloc({
    required this.educationDegreeBloc,
    required this.searchNaturalityBloc,
    required this.needAttachmentEditBloc,
    required this.waapiManagementPanelUploaderBloc,
    required this.editDependentsBloc,
    required this.activeContractBloc,
    required this.dependentBloc,
    required this.authorizationBloc,
  }) : super(
          CurrentEditDependentsScreenState(
            getEducationDegreeState: educationDegreeBloc.state,
            getNeedAttachmentEditState: needAttachmentEditBloc.state,
            searchNaturalityState: searchNaturalityBloc.state,
            waapiManagementPanelUploaderState: waapiManagementPanelUploaderBloc.state,
            editDependentsState: editDependentsBloc.state,
            activeContractState: activeContractBloc.state,
            dependentState: dependentBloc.state,
            authorizationState: authorizationBloc.state,
          ),
        ) {
    on<ChangeEducationDegreeStateEvent>(_changeEducationDegreeBlocEvent);
    on<ChangeNeedAttachmentEditStateEvent>(_changeNeedAttachmentEditBlocEvent);
    on<ChangeSearchNaturalityStateEvent>(_changeSearchNaturalityStateEvent);
    on<ChangeWaapiManagementPanelUploaderStateEvent>(_changeWaapiManagementPanelUploaderStateEvent);
    on<ChangeEditDependentsStateEvent>(_changeEditDependentsStateEvent);
    on<ChangeActiveContractStateEvent>(_changeActiveContractStateEvent);
    on<ChangeDependentStateEvent>(_changeDependentStateEvent);
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationStateEvent);

    getWaapiManagementPanelUploaderSubscription =
        waapiManagementPanelUploaderBloc.stream.listen((waapiManagementPanelUploaderState) {
      add(
        ChangeWaapiManagementPanelUploaderStateEvent(
          waapiManagementPanelUploaderState: waapiManagementPanelUploaderState,
        ),
      );
    });

    getEducationDegreeSubscription = educationDegreeBloc.stream.listen((educationDegreeState) {
      add(
        ChangeEducationDegreeStateEvent(
          educationDegreeState: educationDegreeState,
        ),
      );
    });

    getNeedAttachmentSubscription = needAttachmentEditBloc.stream.listen((needAttachmentEditState) {
      add(
        ChangeNeedAttachmentEditStateEvent(
          needAttachmentEditState: needAttachmentEditState,
        ),
      );
    });

    searchNaturalitySubscription = searchNaturalityBloc.stream.listen((searchNaturalityState) {
      add(
        ChangeSearchNaturalityStateEvent(
          searchNaturalityState: searchNaturalityState,
        ),
      );
    });

    editDependentsSubscription = editDependentsBloc.stream.listen((editDependentsState) {
      add(
        ChangeEditDependentsStateEvent(
          editDependentsState: editDependentsState,
        ),
      );
    });

    activeContractSubscription = activeContractBloc.stream.listen((activeContractState) {
      add(
        ChangeActiveContractStateEvent(
          activeContractState: activeContractState,
        ),
      );
    });

    dependentSubscription = dependentBloc.stream.listen((dependentState) {
      add(
        ChangeDependentStateEvent(
          dependentState: dependentState,
        ),
      );
    });

    authorizationSubscription = authorizationBloc.stream.listen((authorizationState) {
      add(
        ChangeAuthorizationStateEvent(
          authorizationState: authorizationState,
        ),
      );
    });
  }

  Future<void> _changeWaapiManagementPanelUploaderStateEvent(
    ChangeWaapiManagementPanelUploaderStateEvent event,
    Emitter<EditDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        waapiManagementPanelUploaderState: event.waapiManagementPanelUploaderState,
      ),
    );
  }

  Future<void> _changeEducationDegreeBlocEvent(
    ChangeEducationDegreeStateEvent event,
    Emitter<EditDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getEducationDegreeState: event.educationDegreeState,
      ),
    );
  }

  Future<void> _changeNeedAttachmentEditBlocEvent(
    ChangeNeedAttachmentEditStateEvent event,
    Emitter<EditDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getNeedAttachmentEditState: event.needAttachmentEditState,
      ),
    );
  }

  Future<void> _changeSearchNaturalityStateEvent(
    ChangeSearchNaturalityStateEvent event,
    Emitter<EditDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchNaturalityState: event.searchNaturalityState,
      ),
    );
  }

  Future<void> _changeEditDependentsStateEvent(
    ChangeEditDependentsStateEvent event,
    Emitter<EditDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        editDependentsState: event.editDependentsState,
      ),
    );
  }

  Future<void> _changeActiveContractStateEvent(
    ChangeActiveContractStateEvent event,
    Emitter<EditDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        activeContractState: event.activeContractState,
      ),
    );
  }

  Future<void> _changeDependentStateEvent(
    ChangeDependentStateEvent event,
    Emitter<EditDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        dependentState: event.dependentState,
      ),
    );
  }

  Future<void> _changeAuthorizationStateEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<EditDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authorizationState: event.authorizationState,
      ),
    );
  }

  @override
  Future<void> close() {
    getEducationDegreeSubscription.cancel();
    getNeedAttachmentSubscription.cancel();
    searchNaturalitySubscription.cancel();
    editDependentsSubscription.cancel();
    activeContractSubscription.cancel();
    dependentSubscription.cancel();
    activeContractSubscription.cancel();
    return super.close();
  }
}
