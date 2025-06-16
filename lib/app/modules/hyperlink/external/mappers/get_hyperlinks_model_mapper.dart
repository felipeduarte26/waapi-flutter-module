// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/helper/enum_helper.dart';
import '../../../attachment/external/mappers/attachment_model_mapper.dart';
import '../../enums/hyperlink_type_enum.dart';
import '../../infra/models/hyperlink_model.dart';

class GetHyperlinksModelMapper {
  final AttachmentModelMapper _attachmentModelMapper;

  GetHyperlinksModelMapper({
    required AttachmentModelMapper attachmentModelMapper,
  }) : _attachmentModelMapper = attachmentModelMapper;

  HyperlinkModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return HyperlinkModel(
      id: map['id'],
      label: map['label'],
      url: map['url'],
      iconUrl: map['iconURL'],
      type: EnumHelper<HyperlinkTypeEnum>().stringToEnum(
            stringToParse: map['hyperlinkType'],
            values: HyperlinkTypeEnum.values,
          ) ??
          HyperlinkTypeEnum.otherLinks,
      showInputScreen: map['showInputScreen'] is bool ? map['showInputScreen'] : false,
      attachment: map['attachment'] != null
          ? _attachmentModelMapper.fromMap(
              map: map['attachment'],
            )
          : null,
    );
  }

  List<HyperlinkModel> fromJsonList({
    required String json,
  }) {
    if (json.isEmpty) {
      return [];
    }

    final hyperlinksDecoded = jsonDecode(json);

    final List decodedList = [];
    decodedList.addAll((hyperlinksDecoded['hyperlinks'] ?? []) as List);
    decodedList.addAll((hyperlinksDecoded['reports'] ?? []) as List);

    final hyperlinks = decodedList.map(
      (hyperlinkMap) {
        if (hyperlinkMap['id'] == null) {}
        return fromMap(
          map: hyperlinkMap,
        );
      },
    ).toList();

    hyperlinks.sort((a, b) => (a.label == null || b.label == null) ? 1 : a.label!.compareTo(b.label!));

    return hyperlinks;
  }
}
