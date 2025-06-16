import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/active_tenant_modules_datasource_impl.dart';
import '../external/datasources/feature_control_authorizations_datasource_impl.dart';
import '../external/datasources/legacy_authorizations_datasource_impl.dart';
import '../external/datasources/platform_authorizations_datasource_impl.dart';
import '../external/drivers/get_allow_time_management_driver_impl.dart';
import '../external/drivers/get_waapi_lite_driver_impl.dart';
import '../external/drivers/save_allow_time_management_driver_impl.dart';
import '../external/drivers/save_waapi_lite_driver_impl.dart';
import '../external/mappers/active_tenant_modules_model_mapper.dart';
import '../external/mappers/feature_control_authorizations_model_mapper.dart';
import '../external/mappers/legacy_authorization_model_mapper.dart';
import '../external/mappers/platform_authorizations_aggregator_model_mapper.dart';
import '../helper/authorization_helper.dart';
import '../infra/datasources/active_tenant_modules_datasource.dart';
import '../infra/datasources/feature_control_authorizations_datasource.dart';
import '../infra/datasources/legacy_authorizations_datasource.dart';
import '../infra/datasources/platform_authorizations_datasource.dart';
import '../infra/drivers/get_allow_time_management_driver.dart';
import '../infra/drivers/get_waapi_lite_driver.dart';
import '../infra/drivers/save_allow_time_management_driver.dart';
import '../infra/drivers/save_waapi_lite_driver.dart';

class AuthorizationExternalBinds {
  static List<Bind<Object>> binds = [
    // Mappers
    Bind.lazySingleton(
      (i) {
        return LegacyAuthorizationModelMapper();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return PlatformAuthorizationsAggregatorModelMapper();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return FeatureControlAuthorizationsModelMapper();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return ActiveTenantModulesModelMapper();
      },
      export: true,
    ),

    // Datasources
    Bind.lazySingleton<LegacyAuthorizationsDatasource>(
      (i) {
        return LegacyAuthorizationsDatasourceImpl(
          restService: i.get(),
          legacyAuthorizationModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<PlatformAuthorizationsDatasource>(
      (i) {
        return PlatformAuthorizationsDatasourceImpl(
          restService: i.get(),
          platformAuthorizationsAggregatorModelMapper: i.get(),
          platformPermissions: AuthorizationHelper.getPlataformPermissions(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<FeatureControlAuthorizationsDatasource>(
      (i) {
        return FeatureControlAuthorizationsDatasourceImpl(
          restService: i.get(),
          featureControlAuthorizationsModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<ActiveTenantModulesDatasource>(
      (i) {
        return ActiveTenantModulesDatasourceImpl(
          restService: i.get(),
          activeTenantModulesModelMapper: i.get(),
        );
      },
      export: true,
    ),

    //Drivers
    Bind.lazySingleton<GetWaapiLiteDriver>(
      (i) {
        return GetWaapiLiteDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveWaapiLiteDriver>(
      (i) {
        return SaveWaapiLiteDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetAllowTimeManagementDriver>(
      (i) {
        return GetAllowTimeManagementDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveAllowTimeManagementDriver>(
      (i) {
        return SaveAllowTimeManagementDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
