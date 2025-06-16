import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_card_widget.dart';
import '../../domain/entities/civil_certificate_entity.dart';
import '../../enums/civil_certificate_type_enum.dart';
import '../blocs/civil_certificate_bloc/civil_certificate_event.dart';
import '../screens/edit_personal_documents_screen/bloc/edit_personal_documents_screen_bloc.dart';
import '../screens/edit_personal_documents_screen/widgets/civil_certificate_bottom_sheet_widget.dart';
import '../string_formatters/enum_civil_certificate_type_string_formatter.dart';

class ShowCivilCertificateWidget extends StatefulWidget {
  final CivilCertificateEntity civilCertificate;

  const ShowCivilCertificateWidget({
    super.key,
    required this.civilCertificate,
  });

  @override
  State<ShowCivilCertificateWidget> createState() {
    return _ShowCivilCertificateWidgetState();
  }
}

class _ShowCivilCertificateWidgetState extends State<ShowCivilCertificateWidget> {
  late final EditPersonalDocumentsScreenBloc _editPersonalDocumentsScreenBloc;

  @override
  void initState() {
    super.initState();
    _editPersonalDocumentsScreenBloc = Modular.get<EditPersonalDocumentsScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final civilCertificateType = EnumCivilCertificateTypeStringFormatter.getEnumCivilCertificateTypeString(
      civilCertificateTypeEnum: widget.civilCertificate.certificateType != null
          ? widget.civilCertificate.certificateType!
          : CivilCertificateTypeEnum.others,
      appLocalizations: context.translate,
    );

    return WaapiCardWidget(
      showActionIcon: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              SeniorIcon(
                icon: civilCertificateIcon(widget.civilCertificate),
                size: SeniorSpacing.medium,
              ),
              const SizedBox(
                width: SeniorSpacing.small,
              ),
              Expanded(
                child: SeniorText.label(
                  context.translate.certificateOf(civilCertificateType),
                  color: SeniorColors.neutralColor800,
                ),
              ),
              SeniorIconButton(
                icon: FontAwesomeIcons.solidPen,
                size: SeniorIconButtonSize.small,
                style: SeniorIconButtonStyle(
                  iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                      ? SeniorColors.pureWhite
                      : SeniorColors.secondaryColor600,
                  borderColor: Colors.transparent,
                  disabledBorderColor: Colors.transparent,
                  buttonColor: Colors.transparent,
                ),
                onTap: () => _editCivilCertificate(context),
                type: SeniorIconButtonType.ghost,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.normal,
                ),
                child: SeniorIconButton(
                  icon: FontAwesomeIcons.solidTrash,
                  size: SeniorIconButtonSize.small,
                  style: SeniorIconButtonStyle(
                    iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                        ? SeniorColors.pureWhite
                        : SeniorColors.secondaryColor600,
                    borderColor: Colors.transparent,
                  ),
                  onTap: () => _deleteCivilCertificate(context),
                  type: SeniorIconButtonType.ghost,
                ),
              ),
            ],
          ),
          if (widget.civilCertificate.enrollment != null)
            if (widget.civilCertificate.enrollment!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.big,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SeniorText.body(
                            context.translate.registrationNumber,
                            color: SeniorColors.neutralColor500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SeniorText.body(
                            widget.civilCertificate.enrollment!,
                            color: SeniorColors.neutralColor800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  void _deleteCivilCertificate(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.removeCertificate,
          content: context.translate.removeRegister,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () => Modular.to.pop(),
          ),
          otherAction: SeniorModalAction(
            label: context.translate.delete,
            action: () {
              _editPersonalDocumentsScreenBloc.getCivilCertificateBloc.add(
                UnselectCivilCertificateFromEntityToProfileEvent(
                  civilCertificateEntity: widget.civilCertificate,
                ),
              );
              Modular.to.pop();
            },
            danger: true,
          ),
        );
      },
    );
  }

  void _editCivilCertificate(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.defineCivilCertificate,
      context: context,
      height: context.bottomSheetSize,
      content: [
        CivilCertificateBottomSheetWidget(
          civilCertificate: widget.civilCertificate,
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }

  IconData civilCertificateIcon(CivilCertificateEntity certificateEntity) {
    switch (certificateEntity.certificateType) {
      case CivilCertificateTypeEnum.birth:
        return FontAwesomeIcons.solidCakeCandles;
      case CivilCertificateTypeEnum.marriage:
      case CivilCertificateTypeEnum.religiousMarriage:
        return FontAwesomeIcons.solidUserGroup;
      default:
        return FontAwesomeIcons.solidFileLines;
    }
  }
}
