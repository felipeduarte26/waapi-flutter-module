import '../../../../core/types/either.dart';
import '../failures/settings_failure.dart';

typedef GetCurrentVersionUsecaseCallback = Future<Either<SettingsFailure, String>>;
