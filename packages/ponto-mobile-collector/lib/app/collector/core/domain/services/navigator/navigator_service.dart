import 'package:flutter/material.dart';

abstract class NavigatorService {
  void navigate({
    required String route,
    Object? arguments,
  });

  dynamic pop({dynamic value});

  Future<dynamic> pushNamed({
    required String route,
    Object? arguments,
  });

  Future<dynamic> popAndPushNamed({required String route, Object? arguments});

  Future<dynamic> pushNamedAndRemoveUntil(
    String newRouteName,
    bool Function(Route<dynamic>) predicate,
  );

  Future<dynamic> push({required MaterialPageRoute pageRoute});

  Future<void> closeApplication();

  Future<dynamic> pushReplacementNamed({
    required String route,
    Object? arguments,
  });
}
