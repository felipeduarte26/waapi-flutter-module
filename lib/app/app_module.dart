import 'dart:io';

import 'package:dio/io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waapi_module/app/core/services/analytics/analytics_service.dart';
import 'package:waapi_module/app/core/services/error_logging/crashlytics/crashlytics_service.dart';
import 'package:waapi_module/app/core/services/error_logging/error_logging_service.dart';
import 'package:waapi_module/app/core/services/rating/rating_service.dart';

import 'core/environment/environment_variables.dart';
import 'core/screens/generic_web_view_screen.dart';
import 'core/screens/success_animation_screen.dart';
import 'core/services/analytics/analytics/firebase_analytics_service.dart';
import 'core/services/file/file_service/file_service.dart';
import 'core/services/file/file_service/file_service_impl.dart';
import 'core/services/has_clocking_configuration/external/drivers/save_clocking_configuration_driver_impl.dart';
import 'core/services/integration_user/infra/repositories/integration_user_repository_impl.dart';
import 'core/services/internal_storage/internal_storage_service.dart';
import 'core/services/internal_storage/shared_preference/shared_preferences_storage_service.dart';
import 'core/services/native_settings/native_settings_service.dart';
import 'core/services/native_settings/permission_handler/permission_handler_service.dart';
import 'core/services/open_external_url/open_external_url_service.dart';
import 'core/services/open_external_url/url_launcher/url_launcher_service.dart';
import 'core/services/rating/in_app_review/in_app_review_service.dart';
import 'core/services/rest_client/dio/dio_instance.dart';
import 'core/services/rest_client/dio/dio_rest_service.dart';
import 'core/services/rest_client/rest_service.dart';
import 'core/widgets/under_development_widget.dart';
import 'modules/attachment/attachment_module.dart';
import 'modules/authentication/authentication_module.dart';
import 'modules/feedback/feedback_module.dart';
import 'modules/financial_data/financial_data_module.dart';
import 'modules/happiness_index/happiness_index_module.dart';
import 'modules/help/help_module.dart';
import 'modules/home/home_guard.dart';
import 'modules/home/home_module.dart';
import 'modules/hyperlink/hyperlink_module.dart';
import 'modules/management_panel/management_panel_guard.dart';
import 'modules/management_panel/management_panel_module.dart';
import 'modules/moods/moods_module.dart';
import 'modules/onboarding/onboarding_guard.dart';
import 'modules/onboarding/onboarding_module.dart';
import 'modules/personalization/personalization_module.dart';
import 'modules/privacy_policy/privacy_policy_module.dart';
import 'modules/profile/profile_module.dart';
import 'modules/search_person/search_person_module.dart';
import 'modules/settings/settings_module.dart';
import 'modules/social/presenter/widget/waapi_show_carousel_image_screen.dart';
import 'modules/social/social_module.dart';
import 'modules/vacations/vacations_module.dart';
import 'routes/attachment_routes.dart';
import 'routes/happiness_index_routes.dart';
import 'routes/hyperlink_routes.dart';
import 'routes/moods_routes.dart';
import 'routes/routes.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds {
    return [
      Bind.singleton((i) {
        return FirebaseCrashlytics.instance;
      }),
      Bind.singleton((i) {
        return FirebaseAnalytics.instance;
      }),
      Bind.singleton((i) {
        return InAppReview.instance;
      }),

      Bind.singleton<ErrorLoggingService>((i) {
        return CrashlyticsService(
          instance: i.get<FirebaseCrashlytics>(),
        );
      }),

      Bind.singleton<AnalyticsService>((i) {
        return FirebaseAnalyticsService(
          instance: i.get<FirebaseAnalytics>(),
          errorLoggingService: i.get<ErrorLoggingService>(),
        );
      }),

      Bind.singleton<RatingService>((i) {
        return InAppReviewService(
          instance: i.get(),
          errorLoggingService: i.get(),
        );
      }),
      AsyncBind<RestService>((i) async {
        return DioRestService(
          dio: await DioInstance().getDioInstance(),
          hcmApiUrlBase: EnvironmentVariables.hcmApiUrlBase,
          platformUrlBase: EnvironmentVariables.platformUrlBase,
          
          httpClientAdapter: IOHttpClientAdapter(
            createHttpClient: () {
              final HttpClient client = HttpClient(
                context: SecurityContext(
                  withTrustedRoots: false,
                ),
              );

              client.badCertificateCallback = (cert, host, port) => true;
              return client;
            },
          ),
        );
      }),

      Bind.singleton<NativeSettingsService>((i) {
        return PermissionHandlerService();
      }),

      Bind.lazySingleton<FilePicker>((i) => FilePicker.platform),

      Bind.lazySingleton<FileService>((i) => FileServiceImpl(filePicker: i.get<FilePicker>())),

      // Blocs
      Bind.singleton(
        (i) {
          return AuthenticationBloc();
        },
      ),

      AsyncBind<InternalStorageService>((i) async {
        return SharedPreferencesStorageService(
          sharedPreferences: await SharedPreferences.getInstance(),
        );
      }),

      AsyncBind<IntegrationUserRepositoryImpl>((i) async {
        return IntegrationUserRepositoryImpl(
          internalStorageService: i.get<InternalStorageService>(),
        );
      }),

      AsyncBind<SaveClockingConfigurationDriverImpl>((i) async {
        return SaveClockingConfigurationDriverImpl(
          internalStorageService: i.get<InternalStorageService>(),
        );
      }),

      Bind.singleton<OpenExternalUrlService>((i) {
        return UrlLauncherService();
      }),
    ];
  }

  @override
  List<Module> get imports {
    return [
      OnboardingModule(),
      AuthenticationModule(),
      PersonalizationModule(),

      // PONTO
      PontoMobileCollectorBinds(),
      ClockingEventBinds(),
      TimeAdjustmentBinds(),
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ModuleRoute(
        HomeRoutes.homeModuleRoute,
        module: HomeModule(),
        transition: TransitionType.noTransition,
        guards: [
          HomeGuard(),
        ],
      ),
      ModuleRoute(
        ManagementPanelRoutes.managementPanelModuleRoute,
        module: ManagementPanelModule(),
        transition: TransitionType.noTransition,
        guards: [
          ManagementPanelGuard(),
        ],
      ),
      ModuleRoute(
        FeedbackRoutes.feedbackModuleRoute,
        module: FeedbackModule(),
      ),
      ModuleRoute(
        AuthenticationRoutes.authenticationModuleRoute,
        module: AuthenticationModule(),
        transition: TransitionType.noTransition,
        duration: const Duration(
          milliseconds: 500,
        ),
      ),
      ModuleRoute(
        SettingsRoutes.settingsModuleRoute,
        module: SettingsModule(),
      ),
      ModuleRoute(
        HelpRoutes.helpModuleRoute,
        module: HelpModule(),
      ),
      ModuleRoute(
        ProfileRoutes.profileModuleRoute,
        module: ProfileModule(),
      ),
      ModuleRoute(
        VacationsRoutes.vacationsModuleRoute,
        module: VacationsModule(),
      ),
      ModuleRoute(
        AttachmentRoutes.attachmentModuleRoute,
        module: AttachmentModule(),
      ),
      ModuleRoute(
        SearchPersonRoutes.searchPersonModuleRoute,
        module: SearchPersonModule(),
      ),
      ModuleRoute(
        PrivacyPolicyRoutes.privacyPolicyModuleRoute,
        module: PrivacyPolicyModule(),
      ),
      ModuleRoute(
        FinancialDataRoutes.financialDataModuleRoute,
        module: FinancialDataModule(),
      ),
      ModuleRoute(
        OnboardingRoutes.onboardingModuleRoute,
        module: OnboardingModule(),
        transition: TransitionType.noTransition,
        guards: [
          OnboardingGuard(),
        ],
      ),
      ModuleRoute(
        OnboardingRoutes.onboardingModuleRoute,
        module: OnboardingModule(),
        transition: TransitionType.noTransition,
        guards: [
          OnboardingGuard(),
        ],
      ),
      ChildRoute(
        ManagementPanelRoutes.underDevelopmentScreenRoute,
        child: (_, __) {
          return const UnderDevelopmentWidget();
        },
      ),
      ChildRoute(
        AppRoutes.webViewRoute,
        child: (_, args) {
          return GenericWebViewScreen(
            label: args.data['label'],
            url: args.data['url'],
          );
        },
      ),
      ChildRoute(
        AppRoutes.genericShowScreenRoute,
        child: (_, args) {
          return WaapiShowCarouselImageScreen(
            imageUserName: args.data['imageUserName'],
            imageUrls: args.data['imageUrls'],
          );
        },
      ),
      ChildRoute(
        AppRoutes.successAnimationScreen,
        child: (_, args) {
          return SuccessAnimationScreen(
            title: args.data['title'],
            subTitle: args.data['subTitle'],
          );
        },
        transition: TransitionType.downToUp,
        duration: const Duration(
          milliseconds: 800,
        ),
      ),
      ModuleRoute(
        HappinessIndexRoutes.happinessIndexModuleRoute,
        module: HappinessIndexModule(),
        transition: TransitionType.fadeIn,
      ),
      ChildRoute(
        AppRoutes.clockingCameraRoute,
        child: (context, args) => CameraWidget(
          sessionService: Modular.get<ISessionService>(),
          utils: Modular.get<IUtils>(),
          cameraCubit: Modular.get<CollectorCameraCubit>(),
          navigatorService: Modular.get<NavigatorService>(),
          test: false,
        ),
      ),
      ModuleRoute(
        AppRoutes.clockingCollectortRoute,
        module: PontoMobileCollectorModule(),
      ),
      ModuleRoute(
        HyperlinkRoutes.hyperlinkModuleRoute,
        module: HyperlinkModule(),
      ),
      ModuleRoute(
        SocialRouters.socialModuleRoute,
        module: SocialModule(),
      ),
      ModuleRoute(
        MoodsRoutes.moodsModuleRoute,
        module: MoodsModule(),
      ),
    ];
  }
}
