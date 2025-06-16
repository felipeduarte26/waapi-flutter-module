import 'package:flutter/cupertino.dart';

class HubMenuEntity {
  Function() onTap;
  String title;
  IconData iconData;

  HubMenuEntity({
    required this.onTap,
    required this.title,
    required this.iconData,
  });
}
