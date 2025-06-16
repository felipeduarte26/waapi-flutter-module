import '../components/senior_forms_enum.dart';

abstract class EventCalendarInterface {
  DateTime getDate();
  List<SeniorFormsEnum>? getListFormsEnum();
}

class Event implements EventCalendarInterface {
  final DateTime date;
  final List<SeniorFormsEnum>? formsDefault;

  Event({
    this.formsDefault,
    required this.date,
  });

  @override
  DateTime getDate() {
    return date;
  }

  @override
  List<SeniorFormsEnum>? getListFormsEnum() {
    return formsDefault;
  }
}
