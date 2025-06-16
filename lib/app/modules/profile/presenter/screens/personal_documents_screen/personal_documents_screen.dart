import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../core/widgets/warning_widget.dart';
import '../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/civil_certificate_entity.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../enums/document_type_enum.dart';
import '../../../enums/personal_request_update_status_enum.dart';
import '../../blocs/profile_bloc/profile_bloc.dart';
import '../../blocs/profile_bloc/profile_state.dart';
import '../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';
import 'widgets/civil_certificate_card_widget.dart';
import 'widgets/cnh_card_widget.dart';
import 'widgets/cns_card_widget.dart';
import 'widgets/cpf_card_widget.dart';
import 'widgets/ctps_card_widget.dart';
import 'widgets/empty_message_card_widget.dart';
import 'widgets/nis_card_widget.dart';
import 'widgets/passport_card_widget.dart';
import 'widgets/personal_documents_bottom_sheet_widget.dart';
import 'widgets/reservist_certificate_card_widget.dart';
import 'widgets/rg_card_widget.dart';
import 'widgets/ric_card_widget.dart';
import 'widgets/rne_card_widget.dart';
import 'widgets/visa_card_widget.dart';
import 'widgets/voter_registration_card_widget.dart';

class PersonalDocumentsScreen extends StatefulWidget {
  const PersonalDocumentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalDocumentsScreen> createState() {
    return _PersonalDocumentsScreenState();
  }
}

class _PersonalDocumentsScreenState extends State<PersonalDocumentsScreen> {
  late ProfileMenuScreenBloc _profileMenuScreenBloc;
  late AuthorizationEntity authorizationEntity;
  late ProfileEntity profileEntity;
  final Map<DocumentTypeEnum, bool> documents = {};

  @override
  void initState() {
    super.initState();
    _profileMenuScreenBloc = Modular.get<ProfileMenuScreenBloc>();
    AuthorizationState authorizationState = _profileMenuScreenBloc.authorizationBloc.state;

    if (authorizationState is LoadedAuthorizationState) {
      authorizationEntity = authorizationState.authorizationEntity;
    }

    ProfileState profileState = _profileMenuScreenBloc.profileBloc.state;
    profileEntity = profileState.profileEntity!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.personalDocuments,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileMenuScreenBloc.profileBloc,
          builder: (_, state) {
            final passportEntity = state.profileEntity?.passport;
            final rgEntity = state.profileEntity?.rg;
            final voterRegistrationEntity = state.profileEntity?.voterRegistration;
            final ctpsEntity = state.profileEntity?.ctps;
            final cnhEntity = state.profileEntity?.cnh;
            final visaEntity = state.profileEntity?.visa;
            final rneEntity = state.profileEntity?.rne;
            final ricEntity = state.profileEntity?.ric;
            final nisEntity = state.profileEntity?.nis;
            final reservistCertificateEntity = state.profileEntity?.reservistCertificate;
            final nationalHealthCard = state.profileEntity?.nationalHealthCard;
            final civilCertificates =
                state.profileEntity?.civilCertificates?.where((e) => e.certificateType != null).toList();

            if (state is LoadedProfileState) {
              return state.profileEntity != null
                  ? Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (state.profileEntity!.documentRequestUpdate != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: SeniorSpacing.normal,
                                      left: SeniorSpacing.small,
                                      right: SeniorSpacing.small,
                                    ),
                                    child: WarningWidget(
                                      message: documentRequestUpdateMessage(),
                                      icon: FontAwesomeIcons.solidTriangleExclamation,
                                      iconColor: SeniorColors.manchesterColorOrange400,
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: SeniorSpacing.normal,
                                    left: SeniorSpacing.normal,
                                    right: SeniorSpacing.normal,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: SeniorText.labelBold(
                                      context.translate.document,
                                      color: SeniorColors.secondaryColor900,
                                    ),
                                  ),
                                ),
                                documentsEmpty(
                                  state: state,
                                )
                                    ? EmptyMessageCardWidget(
                                        text: context.translate.thereAreNoDocumentRegisteredYet,
                                      )
                                    : Column(
                                        children: [
                                          if (state.profileEntity != null && state.profileEntity?.cpf != null)
                                            CpfCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_cpf',
                                              ),
                                              cpfNumber: state.profileEntity!.cpf!,
                                            ),
                                          if (rgEntity != null)
                                            RgCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_rg',
                                              ),
                                              rgEntity: rgEntity,
                                            ),
                                          if (voterRegistrationEntity != null)
                                            VoterRegistrationCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_voter_registration',
                                              ),
                                              voterRegistrationEntity: voterRegistrationEntity,
                                            ),
                                          if (ctpsEntity != null)
                                            CtpsCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-ctps',
                                              ),
                                              ctpsEntity: ctpsEntity,
                                            ),
                                          if (cnhEntity != null)
                                            CnhCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-cnh',
                                              ),
                                              cnhEntity: cnhEntity,
                                            ),
                                          if (passportEntity != null)
                                            PassportCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_passport',
                                              ),
                                              passportEntity: passportEntity,
                                            ),
                                          if (visaEntity != null)
                                            VisaCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_visa',
                                              ),
                                              visaEntity: visaEntity,
                                            ),
                                          if (rneEntity != null)
                                            RneCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_rne',
                                              ),
                                              rneEntity: rneEntity,
                                            ),
                                          if (ricEntity?.number != null &&
                                              ricEntity!.number!.isNotEmpty &&
                                              ricEntity.number! != '0')
                                            RicCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_ric',
                                              ),
                                              ricEntity: ricEntity,
                                            ),
                                          if (nisEntity != null)
                                            NisCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_nis',
                                              ),
                                              nisEntity: nisEntity,
                                            ),
                                          if (reservistCertificateEntity != null)
                                            ReservistCertificateCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card-reservist_certificate',
                                              ),
                                              reservistCertificateEntity: reservistCertificateEntity,
                                            ),
                                          if (nationalHealthCard != null)
                                            CnsCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card-national_health_card',
                                              ),
                                              nationalHealthCard: nationalHealthCard,
                                            ),
                                        ],
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                    SeniorSpacing.normal,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: SeniorText.labelBold(
                                      context.translate.civilCertificate,
                                      color: SeniorColors.secondaryColor900,
                                    ),
                                  ),
                                ),
                                civilCertificatesEmpty(
                                  civilCertificates: civilCertificates,
                                )
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: SeniorSpacing.small,
                                        ),
                                        child: EmptyMessageCardWidget(
                                          text: context.translate.thereAreNoCivilCertificateRegisteredYet,
                                        ),
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: civilCertificates!.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: SeniorSpacing.normal,
                                            ),
                                            child: CivilCertificateCardWidget(
                                              key: const Key(
                                                'profile-personal_documents_screen-senior_card_civil_certificate',
                                              ),
                                              civilCertificateEntity: civilCertificates[index],
                                            ),
                                          );
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                        authorizationEntity.allowToUpdatePersonalDocuments
                            ? EmployeeBottomSheetWidget(
                                horizontalPadding: true,
                                seniorButtons: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: SeniorSpacing.normal,
                                    ),
                                    child: SeniorButton(
                                      disabled: (state.profileEntity!.documentRequestUpdate != null),
                                      busy: false,
                                      fullWidth: true,
                                      label: context.translate.changeDocuments,
                                      onPressed: () async {
                                        documentCheckboxes(context);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    )
                  : Column(
                      children: [
                        if (profileEntity.documentRequestUpdate != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: SeniorSpacing.normal,
                            ),
                            child: WarningWidget(
                              message: documentRequestUpdateMessage(),
                              icon: FontAwesomeIcons.solidTriangleExclamation,
                              iconColor: SeniorColors.manchesterColorOrange400,
                            ),
                          ),
                        Expanded(
                          child: EmptyStateWidget(
                            title: context.translate.thereAreNoDocumentYet,
                            imagePath: AssetsPath.generalEmptyState,
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: SeniorSpacing.normal,
                                ),
                                child: SeniorButton(
                                  disabled: state.profileEntity!.documentRequestUpdate != null,
                                  busy: false,
                                  fullWidth: true,
                                  label: context.translate.addDocuments,
                                  onPressed: () async {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }
            return const Center(
              child: WaapiLoadingWidget(
                waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
              ),
            );
          },
        ),
      ),
      backgroundColor: SeniorColors.neutralColor100,
    );
  }

  String documentRequestUpdateMessage() {
    if (profileEntity.documentRequestUpdate?.status == PersonalRequestUpdateStatusEnum.awaitingReview) {
      return context.translate.theInformationPresentedIsUnderAnalysis;
    }
    return context.translate.theInformationPresentedIsUnderProcessing;
  }

  bool documentsEmpty({required ProfileState state}) {
    return state.profileEntity?.passport == null &&
        state.profileEntity?.rg == null &&
        state.profileEntity?.voterRegistration == null &&
        state.profileEntity?.ctps == null &&
        state.profileEntity?.cnh == null &&
        state.profileEntity?.visa == null &&
        state.profileEntity?.rne == null &&
        state.profileEntity?.ric == null &&
        state.profileEntity?.nis == null &&
        state.profileEntity?.reservistCertificate == null &&
        state.profileEntity?.nationalHealthCard == null;
  }

  bool civilCertificatesEmpty({required List<CivilCertificateEntity>? civilCertificates}) {
    if (civilCertificates == null) return true;

    return !civilCertificates.any((e) => e.certificateType != null);
  }

  void documentCheckboxes(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.whichDocuments,
      context: context,
      height: context.bottomSheetSize,
      content: [
        PersonalDocumentsBottomSheetWidget(
          documents: documents,
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
