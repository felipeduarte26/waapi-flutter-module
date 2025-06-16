import '../../infra/utils/enum/type_journey_time_enum.dart';

class JourneyTimeDetailsDto {
  final DateTime time;
  final TypeJourneyTimeEnum use;
  JourneyTimeDetailsDto({
    required this.time,
    required this.use,
  });
}
