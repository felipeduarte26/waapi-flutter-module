import 'package:equatable/equatable.dart';
import '../enums/reminder_type.dart';

class Reminder extends Equatable {
  final String? id;
  final DateTime period;
  final bool enabled;
  final ReminderType type;

  const Reminder({
    required this.id,
    required this.period,
    required this.enabled,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        period,
        enabled,
        type,
      ];
}
