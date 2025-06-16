import '../model/time_info_model.dart';

abstract class PopulateListEventsService {
  List<List<TimeInfoModel>> groupEventsByType({
    required List<TimeInfoModel> clockingEvents,
  });
}
