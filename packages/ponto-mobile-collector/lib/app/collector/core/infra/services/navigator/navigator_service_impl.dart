import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/services/navigator/navigator_service.dart';

class NavigatorServiceImpl implements NavigatorService {
  final IModularNavigator _modularNavigator;

  const NavigatorServiceImpl({required IModularNavigator modularNavigator})
      : _modularNavigator = modularNavigator;

  @override
  void navigate({
    required String route,
    Object? arguments,
  }) {
    _modularNavigator.navigate(
      route,
      arguments: arguments,
    );
  }

  @override
  dynamic pop({dynamic value}) {
    return _modularNavigator.pop(value);
  }

  @override
  Future<dynamic> pushNamed({
    required String route,
    Object? arguments,
  }) {
    return _modularNavigator.pushNamed(
      route,
      arguments: arguments,
    );
  }

  @override
  Future<dynamic> popAndPushNamed({required String route, Object? arguments}) {
    return _modularNavigator.popAndPushNamed(route, arguments: arguments);
  }

  @override
  Future<dynamic> pushNamedAndRemoveUntil(
    String newRouteName,
    bool Function(Route<dynamic>) predicate,
  ) {
    return _modularNavigator.pushNamedAndRemoveUntil(newRouteName, predicate);
  }

  @override
  Future<dynamic> push({required MaterialPageRoute pageRoute}) async {
    return _modularNavigator.push(pageRoute);
  }

  @override
  Future<void> closeApplication() async {
    return SystemNavigator.pop();
  }

  @override
  Future<dynamic> pushReplacementNamed({
    required String route,
    Object? arguments,
  }) async {
    return _modularNavigator.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }
}
