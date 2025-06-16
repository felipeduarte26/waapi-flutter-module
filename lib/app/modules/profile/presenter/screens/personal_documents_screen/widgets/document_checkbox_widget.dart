import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/profile_entity.dart';
import '../../../../enums/document_type_enum.dart';
import '../../../../enums/gender_type_enum.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../string_formatters/enum_document_type_string_formatter.dart';
import '../../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';

class DocumentCheckboxWidget extends StatefulWidget {
  final Map<DocumentTypeEnum, bool> documents;
  final Function({required bool isSelected}) thereAreDocumentsSelected;

  const DocumentCheckboxWidget({
    Key? key,
    required this.documents,
    required this.thereAreDocumentsSelected,
  }) : super(key: key);

  @override
  State<DocumentCheckboxWidget> createState() {
    return _DocumentCheckboxWidgetState();
  }
}

class _DocumentCheckboxWidgetState extends State<DocumentCheckboxWidget> {
  final List<DocumentTypeEnum> documentsList = [];
  late ProfileMenuScreenBloc _profileMenuScreenBloc;
  late ProfileEntity profileEntity;
  late final AuthorizationBloc _authorizationBloc;
  late final AuthorizationEntity? _authEntity;

  @override
  void initState() {
    super.initState();
    _profileMenuScreenBloc = Modular.get<ProfileMenuScreenBloc>();
    ProfileState profileState = _profileMenuScreenBloc.profileBloc.state;
    profileEntity = profileState.profileEntity!;
    _authorizationBloc = Modular.get<AuthorizationBloc>();
    _authEntity = (_authorizationBloc.state is LoadedAuthorizationState)
        ? (_authorizationBloc.state as LoadedAuthorizationState).authorizationEntity
        : null;

    List<DocumentTypeEnum> permittedDocumentTypes = [];
    permittedDocumentTypes.addAll(DocumentTypeEnum.values);
    permittedDocumentTypes.removeWhere((item) => item == DocumentTypeEnum.rne);
    permittedDocumentTypes.removeWhere((item) => item == DocumentTypeEnum.visa);
    if (_authEntity != null && !_authEntity.allowToUpdateDocumentCertificate) {
      permittedDocumentTypes.removeWhere((item) => item == DocumentTypeEnum.civilCertificate);
    }

    for (var doc in permittedDocumentTypes) {
      if (!(doc == DocumentTypeEnum.cdi && profileEntity.gender == GenderTypeEnum.female)) {
        widget.documents.addAll({doc: false});
      }
    }

    widget.documents.forEach((key, value) => documentsList.add(key));
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.xmedium,
            ),
            child: SeniorCheckbox(
              title: EnumDocumentTypeStringFormatter.getEnumDocumentTypeString(
                documentTypeEnum: documentsList[index],
                appLocalizations: context.translate,
              ),
              actionOnTitle: true,
              value: widget.documents[documentsList[index]]!,
              onChanged: (value) {
                if (value != null) {
                  widget.documents[documentsList[index]] = value;
                  widget.thereAreDocumentsSelected(
                    isSelected: widget.documents.containsValue(true),
                  );
                  setState(() {});
                }
              },
              style: themeRepository.isCustomTheme()
                  ? null
                  : SeniorCheckboxStyle(
                      titleColor: themeRepository.theme.textTheme!.labelStyle!.color!,
                      checkColor: SeniorColors.primaryColor500,
                      activeColor: SeniorColors.primaryColor500,
                      checkedBorderColor: SeniorColors.primaryColor500,
                    ),
            ),
          );
        },
        childCount: documentsList.length,
      ),
    );
  }
}
