import '../../infra/driver/clean_personalization_mobile_driver.dart';

abstract class CleanPersonalizationMobileDriverUsecase {
 Future<void> call();
}

class CleanPersonalizationMobileDriverUsecaseImpl implements CleanPersonalizationMobileDriverUsecase {
  final CleanPersonalizationMobileDriver _cleanPersonalizationMobileDriver;

  const CleanPersonalizationMobileDriverUsecaseImpl({
    required CleanPersonalizationMobileDriver cleanPersonalizationMobileDriver,
  }) : _cleanPersonalizationMobileDriver = cleanPersonalizationMobileDriver;

  @override
   Future<void> call() async {
    return await _cleanPersonalizationMobileDriver.call();
  }
}
