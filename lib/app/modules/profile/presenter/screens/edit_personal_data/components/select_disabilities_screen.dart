import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../domain/entities/disability_entity.dart';
import '../../../blocs/disability_bloc/disability_bloc.dart';
import '../../../blocs/disability_bloc/disability_event.dart';
import '../../../blocs/disability_bloc/disability_state.dart';
import '../../../widgets/list_disabilities_widget.dart';
import '../bloc/edit_personal_data_screen_bloc.dart';

class SelectDisabilitiesScreen extends StatefulWidget {
  final ValueChanged<bool?> onRehabilitedChanged;
  final bool rehabilited;
  final List<DisabilityEntity> currentDisabilities;
  final ValueChanged<DisabilityEntity> onAddDisability;
  final ValueChanged<DisabilityEntity> onRemoveDisability;

  const SelectDisabilitiesScreen({
    Key? key,
    required this.currentDisabilities,
    required this.onRehabilitedChanged,
    required this.rehabilited,
    required this.onAddDisability,
    required this.onRemoveDisability,
  }) : super(key: key);

  @override
  State<SelectDisabilitiesScreen> createState() {
    return _SelectDisabilitiesScreenState();
  }
}

class _SelectDisabilitiesScreenState extends State<SelectDisabilitiesScreen> {
  late final EditPersonalDataScreenBloc _editPersonalDataScreenBloc;
  List<SeniorDropdownButtonItem> disabilitiesItems = [];
  List<SeniorDropdownButtonItem> selectedDisabilitiesItems = [];
  String? selectedDisability;

  @override
  void initState() {
    super.initState();
    _editPersonalDataScreenBloc = Modular.get<EditPersonalDataScreenBloc>();

    if (_editPersonalDataScreenBloc.getDisabilityBloc.state.disabilityList.isNotEmpty) {
      for (var disability in _editPersonalDataScreenBloc.getDisabilityBloc.state.disabilityList) {
        bool addDisability = false;
        for (var element in widget.currentDisabilities) {
          if (element.id == disability.id) {
            addDisability = true;
            break;
          }
        }
        if (!addDisability) {
          disabilitiesItems.add(
            SeniorDropdownButtonItem(
              value: disability.id,
              title: disability.name!,
            ),
          );
        }
      }
    }

    if (widget.currentDisabilities.isNotEmpty) {
      for (var disability in widget.currentDisabilities) {
        selectedDisabilitiesItems.add(
          SeniorDropdownButtonItem(
            value: disability.id,
            title: disability.name!,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DisabilityBloc, DisabilityState>(
      bloc: _editPersonalDataScreenBloc.getDisabilityBloc,
      listener: (context, state) {
        if (state is LoadedSelectDisabilityState) {
          selectedDisabilitiesItems.add(
            SeniorDropdownButtonItem(
              value: state.selectedDisabilityEntity!.id!,
              title: state.selectedDisabilityEntity!.name!,
            ),
          );

          disabilitiesItems.retainWhere((e) => e.value != state.selectedDisabilityEntity!.id!);

          widget.onAddDisability(state.selectedDisabilityEntity!);
        }

        if (state is UnselectDisabilityState) {
          disabilitiesItems.add(
            SeniorDropdownButtonItem(
              value: state.selectedDisabilityEntity!.id!,
              title: state.selectedDisabilityEntity!.name!,
            ),
          );

          selectedDisabilitiesItems.retainWhere((e) => e.value != state.selectedDisabilityEntity!.id!);

          widget.onRemoveDisability(state.selectedDisabilityEntity!);
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
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.xmedium,
                ),
                child: SeniorText.h4(
                  context.translate.disabilities,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.xmedium,
                ),
                child: SeniorSwitch(
                  title: context.translate.rehabilitatedReadapted,
                  onChanged: widget.onRehabilitedChanged,
                  value: widget.rehabilited,
                ),
              ),
              ListDisabilitiesWidget(
                disabilities: widget.currentDisabilities,
                selectedDisabilitiesItems: selectedDisabilitiesItems,
                disabilitiesItems: disabilitiesItems,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.xmedium,
                  bottom: SeniorSpacing.xmedium,
                ),
                child: SeniorButton(
                  disabled: disabilitiesItems.isEmpty,
                  label: context.translate.addDisability,
                  onPressed: () {
                    _selectDisability(context);
                  },
                  fullWidth: true,
                  style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                  outlined: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDisability(BuildContext context) {
    String disabilitySelected = '';
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.defineDisability,
      context: context,
      height: context.bottomSheetSize,
      content: [
        SeniorDropdownButton(
          value: selectedDisability,
          disabled: false,
          items: disabilitiesItems,
          onSelected: (selected) {
            disabilitySelected = selected;
          },
          label: context.translate.disability,
          style: SeniorDropdownButtonStyle(
            itemListTextColor: Provider.of<ThemeRepository>(context, listen: false).isDarkTheme()
                ? SeniorColors.pureWhite
                : SeniorColors.neutralColor900,
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.normal,
          ),
          child: SeniorButton(
            disabled: false,
            busy: false,
            fullWidth: true,
            label: context.translate.save,
            onPressed: () {
              final id = disabilitiesItems.where((e) => e.value == disabilitySelected).first.value;
              final name = disabilitiesItems.where((e) => e.value == disabilitySelected).first.title;

              _editPersonalDataScreenBloc.getDisabilityBloc.add(
                SelectDisabilityFromEntityToProfileEvent(
                  disabilityEntity: DisabilityEntity(
                    id: id,
                    name: name,
                  ),
                ),
              );

              Modular.to.pop();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.normal,
          ),
          child: SeniorButton.ghost(
            disabled: false,
            fullWidth: true,
            label: context.translate.optionCancel,
            onPressed: () {
              Modular.to.pop();
            },
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
