import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/ia_assist_datasource.dart';

class IAAssistDatasourceImpl implements IAAssistDatasource {
  final RestService _restService;

  IAAssistDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call({
    required String prompt,
    required double temperature,
  }) async {
    const chatgptModel = 'text-davinci-003';
    /*
    O parâmetro temperature no modelo text-davinci-003 do ChatGPT controla o nível de aleatoriedade nas respostas geradas pela IA. Ele define o grau de criatividade ou imprevisibilidade do modelo ao gerar texto.

    Valores baixos (ex.: 0.1, 0.2):
    O modelo será mais determinístico e focado, escolhendo palavras com maior probabilidade. Isso é útil para tarefas que exigem respostas precisas e consistentes, como cálculos ou respostas factuais.

    Valores altos (ex.: 0.7, 0.8):
    O modelo será mais criativo e imprevisível, escolhendo palavras menos prováveis. Isso é útil para tarefas criativas, como escrever histórias ou gerar ideias.

    Valor típico:
    Um valor comum é 0.7, que equilibra criatividade e consistência.

    Em resumo, o temperature ajusta o comportamento do modelo entre previsibilidade e criatividade, dependendo do caso de uso.
    */

    final response = await _restService.analytics().post(
      '/actions/sendMessageToIAssist',
      body: {
        'model': chatgptModel,
        'messages': [
          {'content': prompt},
        ],
        'temperature': temperature,
      },
    );

    final text = jsonDecode(response.data!);

    return text['content'];
  }
}
