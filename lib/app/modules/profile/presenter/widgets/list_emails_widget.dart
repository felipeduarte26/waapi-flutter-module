import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../domain/entities/contact_entity.dart';
import '../../domain/entities/email_entity.dart';
import 'show_email_widget.dart';

class ListEmailsWidget extends StatefulWidget {
  final List<ContactEntity<EmailEntity>> emails;
  final Function(
    ContactEntity<EmailEntity> newValue,
    ContactEntity<EmailEntity> oldValue,
  ) onEditEmail;
  final ValueChanged<ContactEntity<EmailEntity>> onDeleteEmail;
  final bool allowToUpdateContactEmployeeEmail;

  const ListEmailsWidget({
    Key? key,
    required this.emails,
    required this.onEditEmail,
    required this.onDeleteEmail,
    required this.allowToUpdateContactEmployeeEmail,
  }) : super(key: key);

  @override
  State<ListEmailsWidget> createState() {
    return _ListEmailsWidgetState();
  }
}

class _ListEmailsWidgetState extends State<ListEmailsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ShowEmailWidget(
          emailContact: widget.emails[index],
          onEditEmail: widget.onEditEmail,
          onDeleteEmail: widget.onDeleteEmail,
          allowToUpdateContactEmployeeEmail: widget.allowToUpdateContactEmployeeEmail,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: SeniorSpacing.normal,
      ),
      itemCount: widget.emails.length,
    );
  }
}
