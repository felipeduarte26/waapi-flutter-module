import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../domain/entities/civil_certificate_entity.dart';
import 'show_civil_certificate_widget.dart';

class ListCivilCertificatesWidget extends StatefulWidget {
  final List<CivilCertificateEntity> civilCertificates;

  const ListCivilCertificatesWidget({
    Key? key,
    required this.civilCertificates,
  }) : super(key: key);

  @override
  State<ListCivilCertificatesWidget> createState() {
    return _ListCivilCertificatesWidgetState();
  }
}

class _ListCivilCertificatesWidgetState extends State<ListCivilCertificatesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ShowCivilCertificateWidget(
          civilCertificate: widget.civilCertificates[index],
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: SeniorSpacing.small,
      ),
      itemCount: widget.civilCertificates.length,
    );
  }
}
