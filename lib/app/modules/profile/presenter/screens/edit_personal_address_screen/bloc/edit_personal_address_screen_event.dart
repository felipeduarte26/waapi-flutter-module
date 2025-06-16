import 'package:equatable/equatable.dart';

import '../../../blocs/address_by_postal_code_bloc/address_by_postal_code_state.dart';
import '../../../blocs/administrative_region_bloc/administrative_region_state.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';
import '../../../blocs/update_personal_address_bloc/update_personal_address_state.dart';

abstract class EditPersonalAddressScreenEvent extends Equatable {}

class ChangeSearchCityStateEvent extends EditPersonalAddressScreenEvent {
  final SearchNaturalityState searchCityState;

  ChangeSearchCityStateEvent({
    required this.searchCityState,
  });

  @override
  List<Object?> get props {
    return [
      searchCityState,
    ];
  }
}

class ChangeGetProfileStateEvent extends EditPersonalAddressScreenEvent {
  final ProfileState getProfileState;

  ChangeGetProfileStateEvent({required this.getProfileState});

  @override
  List<Object?> get props {
    return [
      getProfileState,
    ];
  }
}

class ChangeGetNeedAttachmentEditStateEvent extends EditPersonalAddressScreenEvent {
  final NeedAttachmentEditState getNeedAttachmentEditState;

  ChangeGetNeedAttachmentEditStateEvent({required this.getNeedAttachmentEditState});

  @override
  List<Object?> get props {
    return [
      getNeedAttachmentEditState,
    ];
  }
}

class ChangeGetPersonStateEvent extends EditPersonalAddressScreenEvent {
  final PersonState getPersonState;

  ChangeGetPersonStateEvent({required this.getPersonState});

  @override
  List<Object?> get props {
    return [
      getPersonState,
    ];
  }
}

class ChangeGetAdministrativeRegionStateEvent extends EditPersonalAddressScreenEvent {
  final AdministrativeRegionState getAdministrativeRegionState;

  ChangeGetAdministrativeRegionStateEvent({required this.getAdministrativeRegionState});

  @override
  List<Object?> get props {
    return [
      getAdministrativeRegionState,
    ];
  }
}

class ChangeGetAddressByPostalCodeStateEvent extends EditPersonalAddressScreenEvent {
  final AddressByPostalCodeState getAddressByPostalCodeState;

  ChangeGetAddressByPostalCodeStateEvent({required this.getAddressByPostalCodeState});

  @override
  List<Object?> get props {
    return [
      getAddressByPostalCodeState,
    ];
  }
}

class ChangeUpdatePersonalAddressStateEvent extends EditPersonalAddressScreenEvent {
  final UpdatePersonalAddressState updatePersonalAddressState;

  ChangeUpdatePersonalAddressStateEvent({
    required this.updatePersonalAddressState,
  });

  @override
  List<Object?> get props {
    return [
      updatePersonalAddressState,
    ];
  }
}
