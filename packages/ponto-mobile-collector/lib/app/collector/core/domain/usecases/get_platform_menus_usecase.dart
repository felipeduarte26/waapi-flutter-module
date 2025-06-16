import 'package:flutter/material.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../entities/hub_menu_entity.dart';
import '../entities/platform_menu_entity.dart';
import '../enums/token_type.dart';
import '../repositories/get_platform_menu_app_repository.dart';
import '../services/firebase/log_service.dart';
import 'get_token_usecase.dart';

abstract class GetPlatformMenusUsecase {
  Future<List<HubMenuEntity>?> call();
}

class GetPlatformMenusUsecaseImpl implements GetPlatformMenusUsecase {
  GetPlatformMenuAppRepository getPlatformMenuAppRepository;
  GetTokenUsecase getTokenUsecase;
  final LogService _logService;

  GetPlatformMenusUsecaseImpl(
    this.getPlatformMenuAppRepository,
    this.getTokenUsecase,
    this._logService,
  );

  @override
  Future<List<HubMenuEntity>?> call() async {
    List<PlatformMenuEntity>? list = await getPlatformMenuAppRepository.call();

    Token? accessToken =
        (await getTokenUsecase.call(tokenType: TokenType.user));
    if (accessToken != null) {
      Iterable<HubMenuEntity>? map =
          list?.map((e) => convertToHubMenuEntity(e, accessToken));
      if (map != null) {
        return Future.value(map.toList());
      }
    }
    
    return Future(() => null);
  }

  HubMenuEntity convertToHubMenuEntity(PlatformMenuEntity entity, Token token) {
    var url = createUrl(entity.url, entity.backendUrl, token);
    Future<bool> onTap() async {
      _logService.saveLocalLog(exception: 'TraceRouteLog', stackTrace: 'Access view ${entity.url}', dateTimeOnDevice: DateTime.now());
      return await launchUrl(Uri.parse(url));
    }

    var iconData =
        IconData(int.parse(entity.flutterIcon), fontFamily: 'MaterialIcons');

    return HubMenuEntity(
      iconData: iconData,
      onTap: onTap,
      title: entity.name,
    );
  }

  String createUrl(String rawUrl, String backendUrl, Token token) {
    return '${parseUrl(rawUrl)}?token=${token.accessToken}?expiresIn=${token.expiresIn}?backendUrl=${backendUrl}loginIos';
  }

  String parseUrl(String url) {
    return '$url${url.contains('?') ? '&' : '?'}timestamp=${DateTime.timestamp()}';
  }
}
