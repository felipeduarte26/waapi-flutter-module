import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/environment/ienvironment_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/platform_menu_app_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/platform_menu_app_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

void main() {
  late IHttpClient httpClient;
  late IEnvironmentService environmentService;
  late PlatformMenuAppDatasource platformMenuAppDatasource;

  setUp(() {
    httpClient = MockHttpClient();
    environmentService = MockEnvironmentService();

    platformMenuAppDatasource = PlatformMenuAppDatasourceImpl(
      httpClient: httpClient,
      environmentService: environmentService,
    );

    when(
      () => environmentService.environment(),
    ).thenReturn(EnvironmentEnum.test);
    var httpResponse = HttpResponse(
      body: getBody(),
      statusCode: 200,
    );
    when(
      () => httpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => httpResponse);
  });

  group('PlatformMenuAppDatasource', () {
    test('PlatformMenuAppDatasource call', () async {
      var call = await platformMenuAppDatasource.call();

      expect(call?.length, 3);
    });
  });
}

String getBody() {
  return ' {"menuPlatformIntegrations": [  {  "id": "2c95dede-2eb1-4cf9-87f6-4925d54fd61e",  "name": "Acerto de ponto",  "resource": "res://senior.com.br/rh/ponto/gestaoponto/colaborador",  "permission": "Visualizar",  "description": "Acerto de ponto do colaborador",  "url": "https://www.google.com.br/user/redirect?activeview=employee&portal=g7&showMenu=N",  "backendUrl": "https://www.google.com.br/gestaoponto-backend/api/",  "active": true, "flutterIcon": "0xe19d"  },  {  "id": "d3ecffd8-981b-4890-a58f-69b5c9ea13d7",  "name": "Jornada de hoje",  "resource": "res://senior.com.br/rh/ponto/gestaoponto/sempreemponto",  "permission": "Visualizar",  "description": "Jornada de hoje",  "url": "https://www.google.com.br/user/register/today-working?portal=g7&showMenu=N",  "backendUrl": "https://www.google.com.br/gestaoponto-backend/api/",  "active": true, "flutterIcon": "0xe19d"  },  {  "id": "83242df0-1856-46f7-b70e-d7457070c80b",  "name": "Acertos da minha equipe",  "resource": "res://senior.com.br/rh/ponto/gestaoponto/gestor",  "permission": "Visualizar",  "description": "Acertos da minha equipe",  "url": "https://www.google.com.br/issues/redirect?activeview=manager&portal=g7&showMenu=N",  "backendUrl": "https://www.google.com.br/gestaoponto-backend/api/",  "active": true, "flutterIcon": "0xe19d"  }  ]}';
}
