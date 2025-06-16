// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../domain/entities/civil_certificate_entity.dart';
import '../../../blocs/civil_certificate_bloc/civil_certificate_bloc.dart';
import '../../../blocs/civil_certificate_bloc/civil_certificate_state.dart';
import '../../../widgets/list_civil_certificates_widget.dart';
import '../../personal_documents_screen/widgets/empty_message_card_widget.dart';
import '../bloc/edit_personal_documents_screen_bloc.dart';
import '../edit_personal_documents_controllers.dart';
import '../widgets/civil_certificate_bottom_sheet_widget.dart';

class EditPersonalDocumentsCivilCertificatesScreen extends StatefulWidget {
  final List<CivilCertificateEntity> listingCivilCertificates;
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;

  const EditPersonalDocumentsCivilCertificatesScreen({
    Key? key,
    required this.listingCivilCertificates,
    required this.editPersonalDocumentsControllers,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsCivilCertificatesScreen> createState() {
    return _EditPersonalDocumentsCivilCertificateScreenState();
  }
}

class _EditPersonalDocumentsCivilCertificateScreenState extends State<EditPersonalDocumentsCivilCertificatesScreen> {
  late final EditPersonalDocumentsScreenBloc _editPersonalDocumentsScreenBloc;
  CivilCertificateEntity certificateEntity = const CivilCertificateEntity();

  @override
  void initState() {
    super.initState();
    _editPersonalDocumentsScreenBloc = Modular.get<EditPersonalDocumentsScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CivilCertificateBloc, CivilCertificateState>(
      bloc: _editPersonalDocumentsScreenBloc.getCivilCertificateBloc,
      listener: (context, state) {
        if (state is LoadedSelectCivilCertificateState && state.selectedCivilCertificate != null) {
          certificateEntity = state.selectedCivilCertificate!;
          widget.listingCivilCertificates.add(certificateEntity);
          setState(() {});
        }

        if (state is UnselectCivilCertificateState && state.selectedCivilCertificate != null) {
          certificateEntity = state.selectedCivilCertificate!;
          widget.listingCivilCertificates.remove(certificateEntity);
          setState(() {});
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SeniorText.h4(
                context.translate.civilCertificates,
              ),
              (widget.listingCivilCertificates.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                      ),
                      child: EmptyMessageCardWidget(
                        text: context.translate.thereAreNoCivilCertificateRegisteredYet,
                      ),
                    )
                  : ListCivilCertificatesWidget(
                      civilCertificates: widget.listingCivilCertificates,
                    ),
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  label: context.translate.addCertificate,
                  onPressed: () {
                    _addCivilCertificate(context);
                  },
                  fullWidth: true,
                  outlined: true,
                  style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addCivilCertificate(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.defineCivilCertificate,
      context: context,
      height: context.bottomSheetSize,
      content: [
        const CivilCertificateBottomSheetWidget(),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
