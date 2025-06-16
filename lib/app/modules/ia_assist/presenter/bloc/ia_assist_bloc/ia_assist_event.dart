import 'package:equatable/equatable.dart';

abstract class IAAssistEvent extends Equatable {
  const IAAssistEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialIAAssistEvent extends IAAssistEvent {
  const InitialIAAssistEvent();
}

class GenerateTextIAAssistEvent extends IAAssistEvent {
  final String prompt;
  final double temperature;

  const GenerateTextIAAssistEvent({
    required this.prompt,
    required this.temperature,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      prompt,
      temperature,
    ];
  }
}
