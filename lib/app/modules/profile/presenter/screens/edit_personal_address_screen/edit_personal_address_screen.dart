import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/components/components.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/enum_helper.dart';
import '../../../../../core/widgets/input_attachments_widget.dart';
import '../../../../../core/widgets/input_notes_widget.dart';
import '../../../../../core/widgets/waapi_page_view_widget.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/entities/administrative_region_entity.dart';
import '../../../domain/entities/city_entity.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/input_models/attachments_input_model.dart';
import '../../../domain/input_models/edit_personal_address_dto_input_model.dart';
import '../../../domain/input_models/edit_personal_address_input_model.dart';
import '../../../enums/address_type_enum.dart';
import '../../../infra/models/administrative_region_model.dart';
import '../../../infra/models/city_model.dart';
import '../../../infra/models/country_model.dart';
import '../../../infra/models/state_model.dart';
import '../../blocs/address_by_postal_code_bloc/address_by_postal_code_bloc.dart';
import '../../blocs/address_by_postal_code_bloc/address_by_postal_code_event.dart';
import '../../blocs/address_by_postal_code_bloc/address_by_postal_code_state.dart';
import '../../blocs/administrative_region_bloc/administrative_region_bloc.dart';
import '../../blocs/administrative_region_bloc/administrative_region_event.dart';
import '../../blocs/administrative_region_bloc/administrative_region_state.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_event.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../blocs/person_bloc/person_state.dart';
import '../../blocs/profile_bloc/profile_event.dart';
import '../../blocs/search_naturality/search_naturality_bloc.dart';
import '../../blocs/search_naturality/search_naturality_event.dart';
import '../../blocs/search_naturality/search_naturality_state.dart';
import '../../blocs/update_personal_address_bloc/update_personal_address_bloc.dart';
import '../../blocs/update_personal_address_bloc/update_personal_address_event.dart';
import '../../blocs/update_personal_address_bloc/update_personal_address_state.dart';
import 'bloc/edit_personal_address_screen_bloc.dart';
import 'bloc/edit_personal_address_screen_state.dart';
import 'components/input_personal_address_screen.dart';

class EditPersonalAddressScreen extends StatefulWidget {
  const EditPersonalAddressScreen({
    super.key,
  });

  @override
  State<EditPersonalAddressScreen> createState() {
    return _EditPersonalAddressScreenState();
  }
}

class _EditPersonalAddressScreenState extends State<EditPersonalAddressScreen> {
  final PageController _pageController = PageController();

  final TextEditingController _addressZipCodeController = TextEditingController();
  final TextEditingController _addressPatioTypeController = TextEditingController();
  final TextEditingController _addressPatioController = TextEditingController();
  final TextEditingController _addressNumberController = TextEditingController();
  final TextEditingController _addressComplementController = TextEditingController();
  final TextEditingController _addressNeighborhoodController = TextEditingController();
  final TextEditingController _addressCityController = TextEditingController();
  final TextEditingController _administrativeRegionController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  var currentStep = 1;
  bool needAttachment = false;
  bool isLoadingAddress = false;
  bool isLoadingAdmRegion = false;
  bool isLoadingAddressSubmit = false;
  bool trueInformation = false;

  late final EditPersonalAddressScreenBloc _editPersonalAddressScreenBloc;
  late final WaapiManagementPanelUploaderBloc _waapiManagementPanelUploaderBloc;
  late final String _addressUpdateDate;

  late ProfileEntity _profileEntity;
  CityEntity addressCity = const CityEntity();
  AddressEntity address = const AddressEntity();
  AdministrativeRegionEntity administrativeRegion = const AdministrativeRegionEntity();

  final List<SeniorDropdownButtonItem> _administrativeRegionItems = [];

  @override
  void initState() {
    super.initState();

    _waapiManagementPanelUploaderBloc = Modular.get<WaapiManagementPanelUploaderBloc>();
    _editPersonalAddressScreenBloc = Modular.get<EditPersonalAddressScreenBloc>();

    if (_editPersonalAddressScreenBloc.getNeedAttachmentEditBloc.state is! LoadedNeedAttachmentEditState) {
      _editPersonalAddressScreenBloc.getNeedAttachmentEditBloc.add(
        const GetNeedAttachmentEditEvent(
          role: 'ADDRESS',
        ),
      );
    }

    _addressCityController.addListener(() {
      setState(() {});
    });

    _addressComplementController.addListener(() {
      setState(() {});
    });

    _addressNeighborhoodController.addListener(() {
      setState(() {});
    });

    _addressNumberController.addListener(() {
      setState(() {});
    });

    _addressPatioController.addListener(() {
      setState(() {});
    });

    _addressPatioTypeController.addListener(() {
      setState(() {});
    });

    _addressZipCodeController.addListener(() {
      setState(() {});
    });

    _administrativeRegionController.addListener(() {
      setState(() {});
    });

    _notesController.addListener(() {
      setState(() {});
    });

    _profileEntity = _editPersonalAddressScreenBloc.getProfileBloc.state.profileEntity!;

    _addressCityController.text = _profileEntity.currentAddress?.city?.name ?? '';
    _addressComplementController.text = _profileEntity.currentAddress?.additional ?? '';
    _addressNeighborhoodController.text = _profileEntity.currentAddress?.neighborhood ?? '';
    _addressNumberController.text = _profileEntity.currentAddress?.number ?? '';
    _addressPatioTypeController.text = _profileEntity.currentAddress?.addressType?.name ?? 'RUA';
    _addressPatioController.text = _profileEntity.currentAddress?.address ?? '';
    _administrativeRegionController.text = _profileEntity.currentAddress?.administrativeRegion?.name ?? '';
    _addressUpdateDate = _profileEntity.currentAddress?.updateDate ?? '';

    if (_profileEntity.currentAddress?.postalCode != null) {
      String postalCode = _profileEntity.currentAddress!.postalCode!.toString().trim();
      if (postalCode.length > 5) {
        _addressZipCodeController.text = '${postalCode.substring(0, 5)}-${postalCode.substring(5, postalCode.length)}';
      }
    }

    if (_profileEntity.currentAddress?.city != null) {
      _editPersonalAddressScreenBloc.searchCityBloc.add(
        SelectNaturalityFromEntityToProfileEvent(
          naturalityEntity: _profileEntity.currentAddress!.city!,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<WaapiManagementPanelUploaderBloc>();
    _addressCityController.dispose();
    _addressComplementController.dispose();
    _addressNeighborhoodController.dispose();
    _addressNumberController.dispose();
    _addressPatioController.dispose();
    _addressPatioTypeController.dispose();
    _addressZipCodeController.dispose();
    _administrativeRegionController.dispose();
    _notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WaapiManagementPanelUploaderBloc, WaapiManagementPanelUploaderState>(
          bloc: _waapiManagementPanelUploaderBloc,
          listener: (context, state) {
            if (state is InitialPanelUploaderState) {
              setState(() {
                goNextPage();
              });
            }
          },
        ),
        BlocListener<SearchNaturalityBloc, SearchNaturalityState>(
          bloc: _editPersonalAddressScreenBloc.searchCityBloc,
          listener: ((context, state) {
            if (state is LoadedSelectNaturalityState && state.selectedNaturalityEntity != null) {
              addressCity = state.selectedNaturalityEntity!;
              _addressCityController.text = addressCity.name!;

              _administrativeRegionItems.clear();
              _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.add(
                GetAdministrativeRegionProfileEvent(
                  cityId: addressCity.id!,
                ),
              );
            }

            if (state is LoadedSearchNaturalityState &&
                state.naturalityList.isNotEmpty &&
                _editPersonalAddressScreenBloc.getAddressByPostalCodeBloc.state is LoadedAddressByPostalCodeState) {
              addressCity = state.naturalityList.first;
              _addressCityController.text = addressCity.name!;

              if (addressCity.id != null) {
                _administrativeRegionItems.clear();
                _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.add(
                  GetAdministrativeRegionProfileEvent(
                    cityId: addressCity.id!,
                  ),
                );
              }
            }

            if (state is ErrorSearchNaturalityState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.searchNaturalityError,
                  action: SeniorSnackBarAction(
                    onPressed: () => _editPersonalAddressScreenBloc.searchCityBloc.add(
                      SearchNaturalityProfileEvent(
                        search: state.search,
                      ),
                    ),
                    label: context.translate.repeat,
                  ),
                ),
              );
            }
          }),
        ),
        BlocListener<AddressByPostalCodeBloc, AddressByPostalCodeState>(
          bloc: _editPersonalAddressScreenBloc.getAddressByPostalCodeBloc,
          listener: ((context, state) {
            isLoadingAddress = (state is LoadingAddressByPostalCodeState);

            if (state is LoadedAddressByPostalCodeState) {
              address = state.addressByPostalCodeEntity!;
              _addressCityController.text = address.city?.name != null ? address.city!.name! : '';
              _addressNeighborhoodController.text = address.neighborhood != null ? address.neighborhood! : '';
              _addressPatioController.text = address.address != null
                  ? address.address!.replaceAll(address.address!.split(' ').first.trim(), '')
                  : '';

              _addressPatioTypeController.text =
                  address.address != null ? address.address!.split(' ').first.trim() : 'RUA';

              if (address.city?.name != null) {
                _editPersonalAddressScreenBloc.searchCityBloc.add(
                  SearchNaturalityProfileEvent(
                    search: address.city!.name!,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: context.translate.noCityFound,
                  ),
                );
              }
            }

            if (state is ErrorAddressByPostalCodeState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.wrongAlert,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () {
                      _editPersonalAddressScreenBloc.getAddressByPostalCodeBloc.add(
                        GetAddressByPostalCodeEvent(
                          postalCode: state.addressByPostalCodeEntity!.postalCode!,
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }),
        ),
        BlocListener<AdministrativeRegionBloc, AdministrativeRegionState>(
          bloc: _editPersonalAddressScreenBloc.getAdministrativeRegionBloc,
          listener: ((context, state) {
            if (state is LoadedSelectAdministrativeRegionState && state.selectedAdministrativeRegionEntity != null) {
              administrativeRegion = state.selectedAdministrativeRegionEntity!;
              _administrativeRegionController.text = administrativeRegion.id!;
            }

            if (state is EmptyStateAdministrativeRegionState) {
              _administrativeRegionController.text = '';
              _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.add(
                UnselectAdministrativeRegionFromEntityToProfileEvent(
                  administrativeRegionEntity: null,
                ),
              );
            }

            if (state is ErrorAdministrativeRegionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.administrativeRegionErrorDescription,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () {
                      _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.add(
                        GetAdministrativeRegionProfileEvent(
                          cityId: addressCity.id!,
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            if (state is LoadedAdministrativeRegionState && state.administrativeRegionList.isNotEmpty) {
              for (var administrativeRegion in state.administrativeRegionList) {
                _administrativeRegionItems.add(
                  SeniorDropdownButtonItem(
                    value: administrativeRegion.id,
                    title: administrativeRegion.name!,
                  ),
                );
              }
            }
          }),
        ),
        BlocListener<UpdatePersonalAddressBloc, UpdatePersonalAddressState>(
          bloc: _editPersonalAddressScreenBloc.updatePersonalAddressBloc,
          listener: ((context, state) {
            isLoadingAddressSubmit = (state is LoadingUpdatePersonalAddressState);

            if (state is SentUpdatePersonalAddressState &&
                _editPersonalAddressScreenBloc.state.getPersonState is LoadedPersonState) {
              _editPersonalAddressScreenBloc.getProfileBloc.add(
                GetProfileEvent(
                  employeeId: _editPersonalAddressScreenBloc.state.getProfileState.profileEntity!.contract!.employeeId!,
                  personId: (_editPersonalAddressScreenBloc.state.getPersonState as LoadedPersonState).personId,
                ),
              );

              Modular.to.pop(true);
              Modular.to.pop(true);

              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.success(
                  message: context.translate.personalAddressSubmitted,
                ),
              );
            }

            if (state is ErrorUpdatePersonalAddressState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.alertErrorSubmit,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () => _sendUpdatePersonalAddress(),
                  ),
                ),
              );
            }
          }),
        ),
      ],
      child: BlocBuilder<EditPersonalAddressScreenBloc, EditPersonalAddressScreenState>(
        bloc: _editPersonalAddressScreenBloc,
        builder: (context, state) {
          isLoadingAdmRegion =
              _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.state is LoadingAdministrativeRegionState;

          if (state.getNeedAttachmentEditState is LoadedNeedAttachmentEditState && !isLoadingAdmRegion) {
            needAttachment = (state.getNeedAttachmentEditState as LoadedNeedAttachmentEditState).needAttachmentEdit;
          }

          return WaapiPageViewWidget(
            pageController: _pageController,
            validationExitIncompleteAction: true,
            listPagesViews: [
              InputPersonalAddressScreen(
                addressZipCode: _addressZipCodeController,
                addressPatioType: _addressPatioTypeController,
                addressPatio: _addressPatioController,
                addressNumber: _addressNumberController,
                addressComplement: _addressComplementController,
                addressNeighborhood: _addressNeighborhoodController,
                addressCity: _addressCityController,
                administrativeRegion: _administrativeRegionController,
                administrativeRegionItems: _administrativeRegionItems,
              ),
              InputAttachmentsWidget(
                panelUploaderBloc: _waapiManagementPanelUploaderBloc,
                isRequiredAttachments: needAttachment,
                header: context.translate.proofResidence,
              ),
              InputNotesWidget(
                notesController: _notesController,
                trueInformation: trueInformation,
                onChangedTrueInformation: (status) {
                  setState(() {
                    trueInformation = status ?? false;
                  });
                },
              ),
            ],
            loadedPages: true,
            disableTopButton: disableTopButton(),
            busyTopButton: busyButton(),
            currentStep: currentStep,
            onPressedGhostButtonDialog: () {
              Modular.to.pop();
            },
            onPressedActionButtonDialog: () {
              Modular.to.pop();
              Modular.to.pop();
            },
            onPressedTopButton: onPressedTopButton,
            labelTopButton: labelTopButton(context),
            disableBottomButton: disableBottomButton(),
            busyBottomButton: busyButton(),
            onPressedBottomButton: onPressedBottomButton,
            labelBottomButton: labelBottomButton(context),
            labelTitleDialog: context.translate.doYouWantToCancelFillingInThisForm,
            labelContentDialog: context.translate.ifYouConfirmYouWillLoseTheInformationEnteredInThisForm,
            labelActionButtonDialog: context.translate.confirm,
            labelGhostButtonDialog: context.translate.close,
            titleScreen: context.translate.editPersonalAddress,
          );
        },
      ),
    );
  }

  bool goNextPage() {
    if (currentStep == 1) {
      return validateInputs();
    }
    if (currentStep == 2) {
      return needAttachment ? _waapiManagementPanelUploaderBloc.state.attachments.isNotEmpty : true;
    }
    return currentStep == 3 && trueInformation;
  }

  bool validateInputs() {
    return _addressZipCodeController.text.trim().length == 9 && _addressPatioController.text.isNotEmpty;
  }

  void onPressedBottomButton() {
    setState(() {
      _pageController.previousPage(
        duration: kTabScrollDuration,
        curve: Curves.easeIn,
      );
      currentStep--;
    });
    return;
  }

  void onPressedTopButton() {
    FocusScope.of(context).unfocus();
    if (currentStep < 3) {
      _pageController.nextPage(
        duration: kTabScrollDuration,
        curve: Curves.easeIn,
      );
      currentStep++;
      setState(() {});
      return;
    }

    _sendUpdatePersonalAddress();
  }

  String labelTopButton(BuildContext context) {
    return currentStep == 3 ? context.translate.saveAndSubmit : context.translate.next;
  }

  String labelBottomButton(BuildContext context) {
    return currentStep > 1 ? context.translate.back : context.translate.optionCancel;
  }

  bool disableTopButton() {
    return !goNextPage() || busyButton();
  }

  bool disableBottomButton() {
    return busyButton();
  }

  bool busyButton() {
    return isLoadingAdmRegion || isLoadingAddress || isLoadingAddressSubmit;
  }

  void _sendUpdatePersonalAddress() {
    final attachments = _waapiManagementPanelUploaderBloc.state.attachments
        .map(
          (attachment) => AttachmentsInputModel(
            id: attachment.id,
            name: attachment.name,
            link: attachment.link,
            personId: attachment.personId,
            operation: 'INSERT',
          ),
        )
        .toList();

    final admRegionEntity =
        _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.state.selectedAdministrativeRegionEntity;

    _editPersonalAddressScreenBloc.updatePersonalAddressBloc.add(
      SendUpdatePersonalAddressEvent(
        editPersonalAddressInputModel: EditPersonalAddressInputModel(
          updateDate: DateTimeHelper.formatToIso8601Date(
            dateTime: DateTime.now(),
          ),
          addresses: [
            EditPersonalAddressDtoInputModel(
              additional: _addressComplementController.text,
              address: _addressPatioController.text,
              addressType: EnumHelper<AddressTypeEnum>().stringToEnum(
                stringToParse: _addressPatioTypeController.text,
                values: AddressTypeEnum.values,
              )!,
              cityId: _editPersonalAddressScreenBloc.searchCityBloc.state.naturalityList.isNotEmpty
                  ? _editPersonalAddressScreenBloc.searchCityBloc.state.naturalityList.first.id!
                  : _editPersonalAddressScreenBloc.searchCityBloc.state.selectedNaturalityEntity!.id!,
              neighborhood: _addressNeighborhoodController.text,
              number: _addressNumberController.text.isNotEmpty ? int.parse(_addressNumberController.text) : null,
              personAddressId: _profileEntity.currentAddress!.id!,
              postalCode: _addressZipCodeController.text.replaceAll('-', '').trim(),
              requestType: 'UPDATE',
              type: 'PERSONAL',
              updateDate: _addressUpdateDate,
              administrativeRegion: _admRegionModel(
                entity: admRegionEntity,
              ),
              administrativeRegionId: admRegionEntity?.id! != null ? admRegionEntity!.id! : null,
            ),
          ],
          attachments: attachments,
        ),
      ),
    );
  }

  AdministrativeRegionModel? _admRegionModel({
    required AdministrativeRegionEntity? entity,
  }) {
    if (entity != null) {
      return AdministrativeRegionModel(
        id: entity.id!,
        name: entity.name,
        city: CityModel(
          id: entity.city!.id!,
          name: entity.city!.name!,
          state: StateModel(
            id: entity.city!.state!.id!,
            name: entity.city!.state!.name,
            abbreviation: entity.city!.state!.abbreviation,
            country: CountryModel(
              id: entity.city!.state!.country!.id,
              name: entity.city!.state!.country!.name,
              abbreviation: entity.city!.state!.country!.abbreviation,
            ),
          ),
        ),
      );
    }

    return null;
  }
}
