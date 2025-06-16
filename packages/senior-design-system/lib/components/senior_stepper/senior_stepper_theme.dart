import './senior_stepper_style.dart';

class SeniorStepperThemeData {
  /// Definições de tema para o componente SeniorStepper.
  const SeniorStepperThemeData({
    this.style,
  });

  /// As definições de estilo do componente.
  ///
  /// Permite configurar:
  /// [SeniorStepperStyle.completedStepColor] the color for the completed steps.
  /// [SeniorStepperStyle.currentStepColor] the color of the current step.
  /// [SeniorStepperStyle.uncompletedStepColor] the color for uncompleted steps.
  final SeniorStepperStyle? style;

  SeniorStepperThemeData copyWith({
    SeniorStepperStyle? style,
  }) {
    return SeniorStepperThemeData(
      style: style ?? this.style,
    );
  }
}
