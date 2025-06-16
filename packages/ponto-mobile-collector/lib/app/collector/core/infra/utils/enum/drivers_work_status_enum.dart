import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum DriversWorkStatusEnum {
  notStarted(
    FontAwesomeIcons.solidClock,
  ),

  working(
    FontAwesomeIcons.businessTime,
  ),

  driving(
    FontAwesomeIcons.truck,
  ),

  mandatoryBreak(
    FontAwesomeIcons.solidCirclePause,
  ),

  foodTime(
    FontAwesomeIcons.utensils,
  ),

  paidBreak(
    FontAwesomeIcons.mugSaucer,
  ),

  waiting(
    FontAwesomeIcons.solidHand,
  );

  final IconData icon;

  const DriversWorkStatusEnum(
    this.icon,
  );
}
