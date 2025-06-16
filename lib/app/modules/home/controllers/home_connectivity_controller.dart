import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/services/has_clocking/presenter/bloc/has_clocking_event.dart';
import '../../authorization/presenter/blocs/authorization_bloc/authorization_event.dart';
import '../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../personalization/presenter/bloc/personalization_bloc/personalization_bloc.dart';
import '../presenter/bloc/connectivity_bloc/connectivity_event.dart';
import '../presenter/bloc/connectivity_bloc/connectivity_state.dart';
import '../presenter/bloc/home_screen_bloc/home_screen_bloc.dart';

class HomeConnectivityController {
  late final HomeScreenBloc homeScreenBloc;
  late final Connectivity connectivity;
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late final bool _mounted;
  final BuildContext Function() getContext;

  HomeConnectivityController({
    required this.homeScreenBloc,
    required this.getContext,
  }) {
    connectivity = Connectivity();
    _mounted = getContext().mounted;
    initConnectivity();
    _connectivitySubscription = connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (_) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!_mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      homeScreenBloc.connectivityBloc.add(
        SetOfflineConnectivityEvent(),
      );
    } else {
      homeScreenBloc.connectivityBloc.add(
        SetOnlineConnectivityEvent(),
      );
    }
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }

  void handleConnectivityState({required ConnectivityState homeConnectivityState}) {
    if (homeConnectivityState is OnlineConnectivityState &&
        homeScreenBloc.authorizationBloc.state is! LoadedAuthorizationState) {
      homeScreenBloc.authorizationBloc.add(
        GetAuthorizationsEvent(),
      );
      homeScreenBloc.personalizationBloc.add(
        GetPersonalizationEvent(),
      );
    }

    if (homeConnectivityState is OfflineConnectivityState &&
        homeScreenBloc.authorizationBloc.state is! LoadedAuthorizationState) {
      homeScreenBloc.hasClockingBloc.add(
        GetHasClockingEvent(),
      );
    }
  }
}
