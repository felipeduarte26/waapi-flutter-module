import '../../../../types/either.dart';

import '../../domain/failures/has_clocking_failure.dart';
import '../../domain/repositories/get_has_clocking_repository.dart';
import '../../domain/types/has_clocking_domain_types.dart';
import '../drivers/get_has_clocking_driver.dart';

class GetHasClockingRepositoryImpl implements GetHasClockingRepository {
  final GetHasClockingDriver _getHasClockingDriver;

  const GetHasClockingRepositoryImpl({
    required GetHasClockingDriver getHasClockingDriver,
  }) : _getHasClockingDriver = getHasClockingDriver;

  @override
  GetHasClockingCallback call() async {
    try {
      final hasClocking = _getHasClockingDriver.call() ?? false;
      return right(hasClocking);
    } catch (error) {
      return left(const HasClockingDriverFailure());
    }
  }
}
