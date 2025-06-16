import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/address_entity.dart';
import '../../../string_formatters/enum_address_string_formatter.dart';

class WaapiPersonalAddressCardWidget extends StatefulWidget {
  final AddressEntity addressEntity;

  const WaapiPersonalAddressCardWidget({
    Key? key,
    required this.addressEntity,
  }) : super(key: key);

  @override
  State<WaapiPersonalAddressCardWidget> createState() {
    return _WaapiPersonalAddressCardWidgetState();
  }
}

class _WaapiPersonalAddressCardWidgetState extends State<WaapiPersonalAddressCardWidget> {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    top: SeniorSpacing.normal,
  );
  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    top: SeniorSpacing.normal,
  );
  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      showActionIcon: false,
      margin: const EdgeInsets.all(
        SeniorSpacing.normal,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SeniorIcon(
                icon: FontAwesomeIcons.solidHouse,
                size: SeniorSpacing.medium,
              ),
              const SizedBox(
                width: SeniorSpacing.small,
              ),
              SeniorText.body(
                context.translate.address,
                color: SeniorColors.neutralColor800,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (widget.addressEntity.addressType == null && widget.addressEntity.address == null)
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: widget.addressEntity.addressType != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.addressEntity.addressType != null
                            ? DocumentItemWidget(
                                padding: _paddingDocumentItemLeft,
                                title: context.translate.addressPatioType,
                                items: [
                                  EnumAddressStringFormatter().getEnumAddressString(
                                    addressTypeEnum: widget.addressEntity.addressType!,
                                    appLocalizations: context.translate,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.addressEntity.address != null
                            ? DocumentItemWidget(
                                padding: widget.addressEntity.address != null
                                    ? _paddingDocumentItemRight
                                    : _paddingDocumentItemLeft,
                                crossAxisAlignment: widget.addressEntity.address != null
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                title: context.translate.address,
                                items: [
                                  widget.addressEntity.address!,
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
              ((widget.addressEntity.number == null || widget.addressEntity.number!.isEmpty) &&
                      (widget.addressEntity.additional == null || widget.addressEntity.additional!.isEmpty))
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: widget.addressEntity.number != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.addressEntity.number != null
                            ? DocumentItemWidget(
                                padding: _paddingDocumentItemLeft,
                                title: context.translate.number,
                                items: [
                                  widget.addressEntity.number!,
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.addressEntity.additional != null
                            ? DocumentItemWidget(
                                padding: widget.addressEntity.additional != null
                                    ? _paddingDocumentItemRight
                                    : _paddingDocumentItemLeft,
                                crossAxisAlignment: widget.addressEntity.additional != null
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                title: context.translate.addressComplement,
                                items: [
                                  widget.addressEntity.additional!,
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
              (widget.addressEntity.neighborhood == null && widget.addressEntity.city == null)
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: widget.addressEntity.neighborhood != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.addressEntity.neighborhood != null
                            ? DocumentItemWidget(
                                padding: _paddingDocumentItemLeft,
                                title: context.translate.addressNeighborhood,
                                items: [
                                  widget.addressEntity.neighborhood!,
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.addressEntity.city != null
                            ? DocumentItemWidget(
                                padding: widget.addressEntity.city != null
                                    ? _paddingDocumentItemRight
                                    : _paddingDocumentItemLeft,
                                crossAxisAlignment: widget.addressEntity.city != null
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                title: context.translate.addressCity,
                                items: [
                                  widget.addressEntity.city!.name!,
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
              widget.addressEntity.city?.state == null
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: widget.addressEntity.city?.state != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.addressEntity.city != null
                            ? DocumentItemWidget(
                                padding: _paddingDocumentItemLeft,
                                title: context.translate.addressState,
                                items: [
                                  widget.addressEntity.city!.state!.name!,
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.addressEntity.city?.state?.country != null
                            ? DocumentItemWidget(
                                padding: widget.addressEntity.city?.state?.country != null
                                    ? _paddingDocumentItemRight
                                    : _paddingDocumentItemLeft,
                                crossAxisAlignment: widget.addressEntity.city?.state?.country != null
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                title: context.translate.addressCountry,
                                items: [
                                  widget.addressEntity.city!.state!.country!.name!,
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
              widget.addressEntity.postalCode != null
                  ? Row(
                      mainAxisAlignment: widget.addressEntity.postalCode != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.addressEntity.city != null
                            ? DocumentItemWidget(
                                padding: _paddingDocumentItemLeft,
                                title: context.translate.addressZipCode,
                                items: [
                                  '${widget.addressEntity.postalCode!.substring(0, 5)}-${widget.addressEntity.postalCode!.substring(5, widget.addressEntity.postalCode!.length)}',
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
