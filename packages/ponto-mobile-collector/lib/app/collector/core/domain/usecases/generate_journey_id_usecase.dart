import 'package:uuid/uuid.dart';

abstract class IGenerateJourneyIdUsecase {
  String call();
}

class GenerateJourneyIdUsecase implements IGenerateJourneyIdUsecase {
  @override
  String call() {
    final uuid = const Uuid().v4();

    return uuid;
  }
}
