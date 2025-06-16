import 'package:flutter/material.dart';

abstract class ILifecycleService {
  AppLifecycleState getState();
  Stream<AppLifecycleState> getStream();
  Future<void> dispose();
}
