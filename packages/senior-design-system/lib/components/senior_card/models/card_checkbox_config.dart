import './card_checkbox_position.dart';

class CardCheckboxConfig {
  const CardCheckboxConfig({
    required this.onChange,
    required this.position,
    required this.value,
  });

  final dynamic Function(bool?) onChange;
  final CardCheckboxPosition position;
  final bool value;
}
