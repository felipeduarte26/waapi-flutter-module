import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../domain/entities/contact_entity.dart';
import '../../domain/entities/social_network_entity.dart';
import 'show_social_network_widget.dart';

class ListSocialNetworksWidget extends StatefulWidget {
  final List<ContactEntity<SocialNetworkEntity>> socialNetworksContacts;
  final Function(
    ContactEntity<SocialNetworkEntity> newValue,
    ContactEntity<SocialNetworkEntity> oldValue,
  ) onEditSocialNetwork;
  final ValueChanged<ContactEntity<SocialNetworkEntity>> onDeleteSocialNetwork;

  const ListSocialNetworksWidget({
    Key? key,
    required this.socialNetworksContacts,
    required this.onEditSocialNetwork,
    required this.onDeleteSocialNetwork,
  }) : super(key: key);

  @override
  State<ListSocialNetworksWidget> createState() {
    return _ListSocialNetworksWidgetState();
  }
}

class _ListSocialNetworksWidgetState extends State<ListSocialNetworksWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ShowSocialNetworkWidget(
          socialNetworkContact: widget.socialNetworksContacts[index],
          onEditSocialNetwork: widget.onEditSocialNetwork,
          onDeleteSocialNetwork: widget.onDeleteSocialNetwork,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: SeniorSpacing.normal,
      ),
      itemCount: widget.socialNetworksContacts.length,
    );
  }
}
