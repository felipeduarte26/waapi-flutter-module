import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../senior_design_system.dart';

class SeniorDesignSystem extends StatelessWidget {
  const SeniorDesignSystem({
    Key? key,
    required this.child,
    this.theme,
  }) : super(key: key);

  final Widget child;
  final SeniorThemeData? theme;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeRepository(theme ?? SENIOR_LIGHT_THEME),
      child: child,
    );
  }
}
