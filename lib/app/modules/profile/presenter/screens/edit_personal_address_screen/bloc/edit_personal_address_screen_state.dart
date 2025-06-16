import 'package:equatable/equatable.dart';

import '../../../blocs/address_by_postal_code_bloc/address_by_postal_code_state.dart';
import '../../../blocs/administrative_region_bloc/administrative_region_state.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';
import '../../../blocs/update_personal_address_bloc/update_personal_address_state.dart';

abstract class EditPersonalAddressScreenState extends Equatable {
  final SearchNaturalityState searchCityState;
  final AdministrativeRegionState getAdministrativeRegionState;
  final ProfileState getProfileState;
  final NeedAttachmentEditState getNeedAttachmentEditState;
  final PersonState getPersonState;
  final AddressByPostalCodeState getAddressByPostalCodeState;
  final UpdatePersonalAddressState updatePersonalAddressState;

  const EditPersonalAddressScreenState({
    required this.searchCityState,
    required this.getAdministrativeRegionState,
    required this.getProfileState,
    required this.getNeedAttachmentEditState,
    required this.getPersonState,
    required this.getAddressByPostalCodeState,
    required this.updatePersonalAddressState,
  });

  CurrentEditPersonalAddressScreenState currentState({
    SearchNaturalityState? searchCityState,
    AdministrativeRegionState? getAdministrativeRegionState,
    ProfileState? getProfileState,
    NeedAttachmentEditState? getNeedAttachmentEditState,
    PersonState? getPersonState,
    AddressByPostalCodeState? getAddressByPostalCodeState,
    UpdatePersonalAddressState? updatePersonalAddressState,
  }) {
    return CurrentEditPersonalAddressScreenState(
      searchCityState: searchCityState ?? this.searchCityState,
      getAdministrativeRegionState: getAdministrativeRegionState ?? this.getAdministrativeRegionState,
      getProfileState: getProfileState ?? this.getProfileState,
      getNeedAttachmentEditState: getNeedAttachmentEditState ?? this.getNeedAttachmentEditState,
      getPersonState: getPersonState ?? this.getPersonState,
      getAddressByPostalCodeState: getAddressByPostalCodeState ?? this.getAddressByPostalCodeState,
      updatePersonalAddressState: updatePersonalAddressState ?? this.updatePersonalAddressState,
    );
  }

  @override
  List<Object?> get props {
    return [
      searchCityState,
      getAdministrativeRegionState,
      getProfileState,
      getNeedAttachmentEditState,
      getPersonState,
      updatePersonalAddressState,
      getAddressByPostalCodeState,
    ];
  }
}

class CurrentEditPersonalAddressScreenState extends EditPersonalAddressScreenState {
  const CurrentEditPersonalAddressScreenState({
    required SearchNaturalityState searchCityState,
    required AdministrativeRegionState getAdministrativeRegionState,
    required ProfileState getProfileState,
    required NeedAttachmentEditState getNeedAttachmentEditState,
    required PersonState getPersonState,
    required AddressByPostalCodeState getAddressByPostalCodeState,
    required UpdatePersonalAddressState updatePersonalAddressState,
  }) : super(
          searchCityState: searchCityState,
          getAdministrativeRegionState: getAdministrativeRegionState,
          getProfileState: getProfileState,
          getNeedAttachmentEditState: getNeedAttachmentEditState,
          getPersonState: getPersonState,
          getAddressByPostalCodeState: getAddressByPostalCodeState,
          updatePersonalAddressState: updatePersonalAddressState,
        );
}
