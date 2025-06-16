import 'package:flutter/material.dart';
import '../../../../core/domain/services/lifecycle/ilifecycle_service.dart';

abstract class IGetLifecycleStreamUsecase {
  Stream<AppLifecycleState> call();
}

class GetLifecycleStreamUsecase implements IGetLifecycleStreamUsecase {
  final ILifecycleService _lifecycleService;

  const GetLifecycleStreamUsecase({
    required ILifecycleService lifecycleService,
  }) : _lifecycleService = lifecycleService;

  @override
  Stream<AppLifecycleState> call() {
    return _lifecycleService.getStream();
  }
}
