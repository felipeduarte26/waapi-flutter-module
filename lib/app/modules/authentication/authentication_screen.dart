import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../core/constants/assets_path.dart';
import '../../core/extension/media_query_extension.dart';
import '../../core/extension/translate_extension.dart';
import '../../core/theme/custom_theme/waapi_custom_theme.dart';
import '../../core/widgets/empty_state_widget.dart';
import '../../core/widgets/waapi_colorful_header.dart';
import '../../routes/routes.dart';
import '../personalization/presenter/bloc/personalization_mobile_bloc/personalization_mobile_bloc.dart';
import '../personalization/presenter/bloc/personalization_mobile_bloc/personalization_mobile_event.dart';
import '../personalization/presenter/bloc/personalization_mobile_bloc/personalization_mobile_state.dart';
import 'presenter/blocs/authentication_analytics_bloc/authentication_analytics_bloc.dart';
import 'presenter/blocs/authentication_analytics_bloc/authentication_analytics_event.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({
    super.key,
  });

  @override
  State<AuthenticationScreen> createState() {
    return _AuthenticationScreenState();
  }
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final AuthenticationAnalyticsBloc _authenticationAnalyticsBloc;
  late final AuthenticationBloc _authenticationBloc;
  late final PersonalizationMobileBloc _personalizationMobileBloc;

  @override
  void initState() {
    super.initState();
    _authenticationAnalyticsBloc = Modular.get<AuthenticationAnalyticsBloc>();
    _authenticationBloc = Modular.get<AuthenticationBloc>();
    _personalizationMobileBloc = Modular.get<PersonalizationMobileBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var locale = Localizations.localeOf(context);
    var theme = Provider.of<ThemeRepository>(context, listen: false);
    _authenticationAnalyticsBloc.add(
      InitAuthenticationScreenEvent(
        userLocale: locale,
        theme: theme.isDarkTheme() ? 'dark' : 'light',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return BlocListener<PersonalizationMobileBloc, PersonalizationMobileState>(
      bloc: _personalizationMobileBloc,
      listener: (context, state) => _listenPersonalizationMobileBlocState(context, state, themeRepository),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: _authenticationBloc,
        builder: (_, state) {
          switch (state.status) {
            case AuthenticationStatus.unauthenticated:
              return const UserNameAuthenticationScreen();
            case AuthenticationStatus.unknown:
              break;
            case AuthenticationStatus.authenticated:
              _personalizationMobileBloc.add(GetPersonalizationMobileEvent());
              _authenticationAnalyticsBloc.add(
                const StatusChangedAuthenticationScreenEvent(
                  authenticationStatus: AuthenticationStatus.authenticated,
                ),
              );
              break;
            case AuthenticationStatus.offline:
              _authenticationAnalyticsBloc.add(
                const StatusChangedAuthenticationScreenEvent(
                  authenticationStatus: AuthenticationStatus.offline,
                ),
              );
              return _OfflineWidget(authenticationBloc: _authenticationBloc);
          }

          return _LoadingWidget(themeRepository: themeRepository);
        },
      ),
    );
  }

  void _listenPersonalizationMobileBlocState(
    BuildContext context,
    PersonalizationMobileState state,
    ThemeRepository themeRepository,
  ) {
    if (state is LoadedPersonalizationMobileState) {
      _setPersonalization(state, themeRepository);
    }
    if ((state is ErrorPersonalizationMobileState || state is LoadedPersonalizationMobileState) &&
        _authenticationBloc.state.status == AuthenticationStatus.authenticated) {
      Modular.to.navigate(OnboardingRoutes.tourScreenInitialRoute);
    }
  }

  void _setPersonalization(LoadedPersonalizationMobileState state, ThemeRepository themeRepository) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final personalizationMobile = state.personalizationMobileEntity;
      if (personalizationMobile.usePersonalizationMobile == true && personalizationMobile.primaryColor != null) {
        themeRepository.theme = createCustomSeniorTheme(
          usePersenalization: true,
          primaryColor: SeniorServiceColor.parseColor(personalizationMobile.primaryColor!),
          secondaryColor: SeniorServiceColor.parseColor(
            personalizationMobile.secondaryColor ?? personalizationMobile.primaryColor!,
          ),
        );
      }
    });
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({
    required this.themeRepository,
  });

  final ThemeRepository themeRepository;

  @override
  Widget build(BuildContext context) {
    return WaapiColorfulHeader(
      style: SeniorColorfulHeaderStructureStyle(
        bodyColor: themeRepository.isLightTheme()
            ? SeniorColors.pureWhite
            : Provider.of<ThemeRepository>(context).theme.cardTheme!.style!.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsPath.horizontalLogo,
              height: context.heightSize / 10,
            ),
            const SizedBox(
              height: SeniorSpacing.xmedium,
            ),
            const SeniorLoading(),
          ],
        ),
      ),
      hideLeading: true,
      titleLabel: context.translate.appTitle,
    );
  }
}

class _OfflineWidget extends StatelessWidget {
  const _OfflineWidget({
    required AuthenticationBloc authenticationBloc,
  }) : _authenticationBloc = authenticationBloc;

  final AuthenticationBloc _authenticationBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.appTitle,
        hideLeading: true,
        body: Center(
          child: EmptyStateWidget(
            title: context.translate.errorNetwork,
            subTitle: context.translate.errorNetworkDescription,
            imagePath: AssetsPath.generalErrorState,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: SeniorSpacing.normal,
                  left: SeniorSpacing.normal,
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  fullWidth: true,
                  label: context.translate.tryAgain,
                  onPressed: () {
                    _authenticationBloc.add(
                      CheckAuthenticationRequested(
                        username: _authenticationBloc.state.username,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
