# {version}
[{date}]

### Quebras de compatibilidade
* N/A.

### Novas funcionalidades
* N/A.

### Melhorias
* N/A.

### Correções
* N/A.

### Alterações na base de dados
* N/A.

### Alteração de dependências
* N/A.

# 11.1.2
[26/03/2025]

### Correções
* [#MNTGEP-37014] - Atualização de dependencia com ajustes para que o User receba a informação do Integration da chamada do getUser

### Alteração de dependências
* `senior_platform_authentication` ^8.1.0 -> ^8.1.1

# 11.1.1
[17/03/2025]

### Melhorias
* [#GPOAPP-250] - Adição de opção para habilitar o botão de voltar na tela de login.

# 11.1.0
[17/03/2025]

### Melhorias
[#ARQMOB-12] - tratamento do metodo getUser para captura de timeout

# 11.0.3
[14/03/2025]

### Melhorias
* [#GPOAPP-250] - Adição de opção para habilitar o botão de voltar na tela de login.

# 11.0.2
[21/02/2025]

### Melhorias
* [#HCMAPP-1428] - Atualização de dependências e ajustes recomendados

### Alteração de dependências
* `flutter` 3.24.5 -> 3.27.4
* `senior_design_system` ^9.0.1 -> ^10.0.1
* `local_auth` ^2.1.8 -> ^2.3.0

# 11.0.1
[17/02/2025]

### Correções
[#HCMAPP-1461] - Adicionado o parâmetro checkOnline ao use case, permitindo que a verificação de conectividade com a internet seja opcional durante a execução.

# 11.0.0
[29/11/2024]

### Novas funcionalidades
* [#ERPINOV-674](https://jira.senior.com.br/browse/ERPINOV-674) - Atualização de dependências e versão do SDK do example.

### Alteração de dependências
* `intl`: ^0.18.1 -> ^0.19.0
* `flutter_lints`: ^3.0.1 -> ^5.0.0

# 10.0.2
[28/11/2024]

### Melhorias
* [#HCMAPP-1357] - Evento CheckBiometricAuthenticationRequested ajustado no AuthenticationBloc para contemplar cenários em que o usuário não ativou a biometria ou quando o projeto que utiliza a biblioteca de login escolhe não implementar essa funcionalidade.
* [#HCMAPP-1336] - A criptografia do SharedPreferences foi desabilitada devido a problemas de lentidão na leitura e gravação. O SharedPreferences NÃO deve ser utilizado para salvar dados sensíveis.

# 10.0.1
[14/11/2024]

### Correções
 * [#HCMAPP-1328] - Atualizando a `senior_platform_authentication` para que as customizações personalizadas de e-mail sejam respeitadas ao realizar a solicitação da alteração de senha.

### Alteração de dependências
* `senior_platform_authentication`: ^7.0.0 -> ^7.0.3

# 10.0.0
[06/11/2024]

### Melhorias
* [#HCMAPP-1336] - Encriptando os dados sensíveis para que não seja possível visualizar através de scripts maliciosos que coletam dados da Keystore. Essa ação mitiga a vulnerabilidade apontada no teste de intrusão referente a visualização de dados sensíveis. 

# 9.1.3
[31/10/2024]

### Melhorias
* [#HCMAPP-1357] - Foi criado um novo evento CheckBiometricAuthenticationRequested no AuthenticationBloc para permitir a validação exclusiva da biometria, que anteriormente era realizada apenas por meio das chamadas dos usecases.


# 9.1.2
[31/10/2024]

### Correções
* [#HCMAPP-1302] - Implementado fluxo de alteração de senha no primeiro acesso quando a autenticação de fator multiplo também está ativada. Agora após a validação do fator multiplo, o usuário é redirecionado para tela de alterar a senha quando a opção de "Alterar senha no primeiro acesso" está ativada.

### Alteração de dependências
* `senior_platform_authentication:`: ^6.1.2 -> ^6.1.3

# 9.1.1
[28/10/2024]

### Correções
* [GPO-8212](https://jira.senior.com.br/browse/GPO-8212) - Passando key token mesmo quando offline

# 9.1.0
[17/09/2024]

### Correções
* [#HCMAPP-1165] - Salvando o token corretamente no AuthenticationBloc. Dessa forma, podemos recuperar o token através do Bloc em vez de toda vez realizar a solicitação do SecureStorage

# 9.0.0
[01/08/2024]

### Melhorias
* [#HCMAPP-1165] - Foi alterado para o GetStoredTokenUsecase ter múltiplos retornos através do Records do Dart. O método agora retorna ou o token ou uma exception
* [#HCMAPP-1165] - Alterado versão da SDS

# 8.1.2
[02/07/2024]

### Correções
* [#HCMAPP-1142] - Biometria está deslogando a aplicação quando ocorre erro na validação da biometria, quando deveria enviar para a tela BiometricSecurityForm

# 8.1.1
[05/06/2024]

### Melhorias
* [GPO-8610](https://jira.senior.com.br/browse/GPO-8610) - Adição de parâmetros na tela de autenticação por usuário.

# 8.1.0
[20/05/2024]

### Melhorias
* [#HCMAPP-1039] - Foi alterado a mensagem de erro para quando o usuário fica sem acesso a internet e tenta fazer login. Agora a mensagem é mais clara.

### Correções
* [#HCMAPP-1039] - Alguns tenants possuem várias formas de autenticação e a biblioteca agora realiza uma verificação mais precisa para   definir o modo de autenticação de cada usuário. 

# 8.0.0
[09/05/2024]

### Melhorias
* [#HCMAPP-1005] - Foi realizada uma atualização do pacote http para corrigir a incompatibilidade ocorrida no senior_platform_authentication 5.0.0.

### Alteração de dependências
* `senior_platform_authentication`: ^5.0.0 -> ^6.0.0

# 7.0.3
[29/04/2024]

### Correções
* [#HCMAPP-1005] - A mensagem de redefinição de e-mail anteriormente utilizava os dados do campo 'usuários' para indicar o e-mail, no entanto, em muitos casos, o e-mail de redefinição era diferente. Fizemos uma atualização para não mais exibir o endereço de e-mail diretamente no texto.


# 7.0.2
[11/04/2024]

### Correções
* [#HCMAPP-1033] - Alterando para a verificação de conexão com a internet seja feita com um ping na plataforma. Da forma que estava, estava sendo bloqueado por alguns clientes que filtram alguns DNS´s em sua rede.

# 7.0.1
[15/03/2024]

### Melhorias
* [#HCMAPP-993] - Adicionado parâmetro para, em casos de SAML, abrir direto a página do SAML do cliente.

# 7.0.0
[28/02/2024]

### Correções
* [#HCMAPP-904] - Está mostrando mensagem de autenticação padrão da biometria. O pacote foi ajustado para que a mensagem seja exibida com a tradução correta. Agora, o aplicativo que estiver utilizando a biblioteca de autenticação não precisa mais fornecer a mensagem para a tela de biometria. A biblioteca já possui a mensagem padrão. Isso foi feito para garantir que todos os aplicativos que utilizam a biblioteca de autenticação tenham a mesma mensagem de autenticação padrão.
* [#HCMAPP-993] - Ajustes na autenticação por Biometria - foi criada uma nova tela para quando a biometria é cancelada ou o aplicativo é colocado em segundo plano. Nessa tela, o usuário tem a opção de fazer a biometria novamente ou deslogar do aplicativo. 
* [#HCMAPP-993] - Ajustes na autenticação por Biometria - Ajustado para quando usuario fazer o login, é o login for saml o campo de email do saml ja vem preenchido.

### Alteração de dependências
* `local_auth_android`: ^1.0.37

# 6.2.2
[16/02/2024]

### Correções
* [#DSN-4521] - Corrigido problema com o valor inicial dos campos na tela de cadastro de chave.

# 6.2.1
[01/02/2024]

### Melhorias
* [#ERPINOV-327] - Atualização de dependências.

### Alteração de dependências
* `senior_platform_authentication`:  ^4.1.0 -> ^4.2.0

# 6.2.0
[22/01/2024]

### Melhorias
* [#ERPINOV-326] - Atualização de dependências. Usando a versão 7 do senior_design_system.

### Correções
* [#HCMAPP-933] - Desativando Biometria por causa do refresh token

### Alteração de dependências
* `senior_design_system`:  ^5.0.0 -> ^7.0.1

# 6.1.0
[21/11/2023]

### Melhorias
* [#ERPINOV-308] - Atualização de todas as dependências. Agora a biblioteca consegue trabalhar com o novo token JWT gerado pela plataforma.

# 6.0.2
[16/11/2023]

### Correções
* [#HCMAPP-890] - Validação de possível erro de retorno de user e token da storage.

# 6.0.1
[14/11/2023]

### Correções
* [#GPO-7721] - Correção na ação do botão de voltar.

# 6.0.0
[13/11/2023]

### Novas funcionalidades
* [#GPO-7721] - Login com Chave de Aplicação.

# 5.0.0
[09/11/2023]

### Novas funcionalidades
* [#HCMAPP-855] - Login com Biometria [Implementada a funcionalidade de login por biometria, com detalhes adicionais disponíveis no README.md. Novidades e instruções atualizadas também foram incluídas para uma melhor experiência de usuário.] 
* [#HCMAPP-868] - Ajustar lib de autenticação
* [#HCMAPP-869] - Adicionar package LOCAL_AUTH na lib de autenticação [Adicionado o package local_auth na lib de autenticação para que seja possível utilizar a biometria do dispositivo.]
* [#HCMAPP-870] - Modal de ativação da biometria 
* [#HCMAPP-871] - Modal de validação da biometria


# 4.1.0
[01/11/2023]

### Correções
* [#HCMAPP-865] - Tirada obrigatoriedade do usuário ter e-mail 

# 4.0.3
[20/10/2023]

### Correções
* [#MNTERP-33820] - Correção bug de autenticação por SAML.

# 4.0.2
[19/10/2023]

### Correções
* [#MNTERP-33820] - Correção bug de autenticação por SAML.

# 4.0.1
[04/10/2023]

### Correções
* [#HCMAPP-859] - Erro login de alguns usuários por causa do username ser Nome.Sobrenome em vez de nome.sobrenome

# 4.0.0
[28/09/2023]

### Quebras de compatibilidade
O método initialize agora possui suporte aos ambientes da plataforma, sendo necessário passar apenas o novo enum `PlatformEnvironment` para inicialização da biblioteca.

Caso seja necessário, ainda temos suporte a custom urls, basta passar o valor custom do enum e os prâmetros baseUrl e frontendUrl. Veja a documentação para mais detalhes.

### Melhorias
* [#ERPINOV-258] - Foi melhorado o método de inicialização da biblioteca.

### Correções
* [#ERPINOV-258] - Correção link enviado no e-mail de recuperar senha.

### Alteração de dependências
* `senior_platform_authentication`:  ^2.1.0 -> ^3.0.0

# 3.2.0
[15/09/2023]

### Correções
* [#HUB-1018] - Foto do usuário não está aparecendo no app

### Alteração de dependências
* `senior_platform_authentication`:  ^2.0.0 -> ^2.1.0

# 3.1.0
[06/09/2023]

### Melhorias
* [#ERPINOV-214] - Melhorias no login offline para atualização das versões compatíveis com Dart 3.

# 3.0.0
[04/09/2023]

### Melhorias
* [#ERPINOV-214] - Atualizar versões do Dart e Flutter.

### Alteração de dependências
* `sdk`:  '>=2.19.2 <4.0.0' -> '>=3.0.0 <4.0.0'
* `flutter`:  '>=3.7.12' -> '>=3.13.0'
* `intl`:  ^0.17.0 -> ^0.18.1
* `flutter_secure_storage`:  ^8.0.0 -> ^9.0.0
* `senior_design_system`:  ^3.1.0 -> ^4.0.1
* `senior_design_tokens`:  ^2.0.0 -> ^3.0.1
* `senior_platform_authentication`:  ^1.1.0 -> ^2.0.0
* `mocktail`:  ^0.3.0 -> ^1.0.0

# 2.0.0
[17/07/2023]

### Novas funcionalidades
* [#HCMAPP-767] - Login offline 

### Alteração de dependências
* `senior_design_system`:  ^3.0.0 -> ^3.1.0
* `senior_platform_authentication`:  ^1.0.0 -> ^1.1.0

# 1.0.4
[13/06/2023]

### Correções
* [#ERPINOV-56] - Correções visuais apontadas em reunião semanal da biblioteca de login.

# 1.0.3
[06/06/2023]

### Correções
* [#ERPINOV-61] - Correção chave recaptcha em produção na jornada de recuperação de senha.

# 1.0.2
[25/05/2023]

### Correções
* [#HCMAPP-743] - ajustes dark mode 

### Alteração de dependências
* `senior_design_system`:  ^2.2.14 -> ^3.0.0

# 1.0.1
[18/05/2023]

### Novas funcionalidades
* N/A

### Melhorias
* [#ERPMERC-8390] - Melhoria no uso do RefreshStoredTokenUsecase com um construtor mais simples.

### Correções
* [#ERPMERC-8390] - Ajuste na jornada de login via SAML. O token não era obtido corretamento no iOS.

# 1.0.0
[17/05/2023]

### Novas funcionalidades
* [#ERPMERC-8787] - Suporte as localizações em Espanhol e Inglês.

# 0.0.4
[12/05/2023]

### Correções
* [#ERPMERC-8698] - Ajustes primeira versão.

# 0.0.2
[11/05/2023]

### Novas funcionalidades
* [#ERPMERC-8699] - Tela de ajuda genérica.
* [#ERPMERC-8697] - Tela de troca de senha.

# 0.0.1
[28/04/2023]
First release.
First release.
