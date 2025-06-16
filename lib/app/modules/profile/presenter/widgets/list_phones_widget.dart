import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../domain/entities/contact_entity.dart';
import '../../domain/entities/phone_contact_entity.dart';
import 'show_phone_widget.dart';

class ListPhonesWidget extends StatefulWidget {
  final List<ContactEntity<PhoneContactEntity>> phones;
  final Function(
    ContactEntity<PhoneContactEntity> newValue,
    ContactEntity<PhoneContactEntity> oldValue,
  ) onEditPhone;
  final ValueChanged<ContactEntity<PhoneContactEntity>> onDeletePhone;

  const ListPhonesWidget({
    Key? key,
    required this.phones,
    required this.onEditPhone,
    required this.onDeletePhone,
  }) : super(key: key);

  @override
  State<ListPhonesWidget> createState() {
    return _ListPhonesWidgetState();
  }
}

class _ListPhonesWidgetState extends State<ListPhonesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final phoneContactEntity = widget.phones[index];

        return ShowPhoneWidget(
          onDeletePhone: widget.onDeletePhone,
          onEditPhone: widget.onEditPhone,
          phone: phoneContactEntity,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: SeniorSpacing.normal,
      ),
      itemCount: widget.phones.length,
    );
  }
}
