import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

class ResetPasswordLoading extends StatelessWidget {
  const ResetPasswordLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SeniorLoading(),
    );
  }
}
