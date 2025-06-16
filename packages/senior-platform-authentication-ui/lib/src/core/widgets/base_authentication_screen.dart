import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../senior_platform_authentication_ui.dart';
import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';

class BaseAuthenticationScreen extends StatefulWidget {
  final Widget child;
  final ThemeOption themeOption;

  /// Ensures that the content inside the SeniorDesignSystem widget follows the theme.
  /// You must pass the initial [ThemeOption] as a parameter. If no themeOption is provided,
  /// [ThemeOption.system] is the default value.
  const BaseAuthenticationScreen({
    super.key,
    required this.child,
    this.themeOption = ThemeOption.system,
  });

  @override
  State<BaseAuthenticationScreen> createState() =>
      _BaseAuthenticationScreenState();
}

class _BaseAuthenticationScreenState extends State<BaseAuthenticationScreen> {
  late ThemeRepository _themeRepository;

  @override
  void initState() {
    super.initState();

    _themeRepository = context.read<ThemeRepository>();
    _setThemeRepository(widget.themeOption);

    if (widget.themeOption == ThemeOption.system) {
      _setPlatformBrightnessChangeListenner();
    }
  }

  _setThemeRepository(ThemeOption themeOption) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    var theme = themeOption == ThemeOption.dark ? darkTheme : lightTheme;

    if (themeOption == ThemeOption.system) {
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      theme = brightness == Brightness.dark ? darkTheme : lightTheme;
      _setPlatformBrightnessChangeListenner();
      _configStatusBar(brightness, theme.themeData?.scaffoldBackgroundColor);
    }

    Future.microtask(
      () {
        _themeRepository.theme = theme;
      },
    );
  }

  void _setPlatformBrightnessChangeListenner() async {
    var dispatcher = SchedulerBinding.instance.platformDispatcher;
    // Overrides device brightness changed behavior.
    dispatcher.onPlatformBrightnessChanged = () async {
      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      _setThemeRepository(widget.themeOption);
    };
  }

  // Only works on screens that don't have an AppBar.
  void _configStatusBar(Brightness brightness, Color? scaffoldBackgroundColor) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: scaffoldBackgroundColor,
      systemNavigationBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      statusBarBrightness: brightness,
      statusBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
    ));
  }

  final _navigatorKeyAuthentication = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeRepository>(
      builder: (context, repository, child) {
        return MaterialApp(
          navigatorKey: _navigatorKeyAuthentication,
          theme: repository.theme.themeData,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SafeArea(
              top: false,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
