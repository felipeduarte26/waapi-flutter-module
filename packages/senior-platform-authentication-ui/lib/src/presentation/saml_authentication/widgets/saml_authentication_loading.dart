import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

class SAMLAuthenticationLoading extends StatelessWidget {
  const SAMLAuthenticationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SeniorLoading(),
    );
  }
}
