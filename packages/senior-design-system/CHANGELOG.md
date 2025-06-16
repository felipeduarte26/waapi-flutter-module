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

# 10.1.1
[24/03/2025]

### Correções
* [SDS-194](https://jira.senior.com.br/browse/SDS-194) - Permitindo definir a notification message do SeniorColorfullHeaderStructure na inicialização do componente.

# 10.1.0
[20/03/2025]

### Melhorias
* [HCMAPP-1398](https://jira.senior.com.br/browse/HCMAPP-1398) - [Personalização][WAAPI] Personalização do WAAPI - Adaptação do Senior Design System (SDS) para suportar personalização de cores. Ajustes nos componentes SeniorBackdrop e SeniorPrimaryButton para suportar cores dinâmicas. Expansão do suporte à personalização para diversos componentes do SDS, incluindo botões, navegação, listas, modal, notificações, textos, entre outros. Criação da classe SeniorServiceColor para validação de contraste e acessibilidade. Novas propriedades primaryColor e secondaryColor no SeniorThemeData para gerenciar cores personalizadas. Melhorias na aplicação de temas customizados, incluindo abstração de estilos e ajustes para facilitar o uso do copyWith. Ajustes de contraste e elevação para melhorar a experiência visual em temas personalizados.
* [DSN-4704](https://jira.senior.com.br/browse/DSN-4704) - Propriedade contentAsWidget na modal.

# 10.0.2
[11/03/2025]

### Melhorias
* [SDS-185](https://jira.senior.com.br/browse/SDS-185) - Propriedade selected no componente Badge.

# 10.0.1
[18/02/2025]

### Correções
* [SDS-150](https://jira.senior.com.br/browse/SDS-150) - Atualizada a versão mínima do Flutter. Atualize para a versão 3.27.4 ou superior.

# 10.0.0
[13/02/2025]

### Quebras de compatibilidade
* [SDS-101](https://jira.senior.com.br/browse/SDS-101) - Atualizada a versão mínima do Flutter. Atualize para a versão 3.29.0 ou superior.

### Novas funcionalidades
* [SDS-101](https://jira.senior.com.br/browse/SDS-101) - Opção de aplicar Ícone no Switch e estilização de cores no estilo ativo e inativo deste ícone . propriedade [thumbIcon] para o Ícone. para estilização são as seguintes propriedades [thumbActiveColor] e [thumbInactiveColor] disponiveis na classe SeniorSwitchStyle

# 9.0.4
[05/02/2025]

### Novas funcionalidades
* [SDS-106](https://jira.senior.com.br/browse/SDS-106) - Opção de esconder estilização do dia Selecionado. propriedade [hideSelectedDay] que é default false.

### Correções
* [SDS-106](https://jira.senior.com.br/browse/SDS-106) - Aplicar uso da propriedade [colorRangeHighlightBackground] do [senior_calendar] que não era utilizada para alterar a cor de fundo.

# 9.0.3
[17/01/2025]

### Novas funcionalidades
* [SDS-97](https://jira.senior.com.br/browse/SDS-97) - Adicionado propriedade no senior_image_cropper para poder adicionar arquivos.

### Melhorias
* [HCMAPP-1400](https://jira.senior.com.br/browse/HCMAPP-1400) - Ajustado o componente senior_backdrop para suportar cores dinâmicas fornecidas pela funcionalidade de personalização mobile. Adicionando o método copyWith em [SeniorBackdropThemeData] e [SeniorBackdropStyle] para facilitar a criação de variações do tema é xportado o arquivo [themes.dart] para centralizar as definições de tema.
* [HCMAPP-1408](https://jira.senior.com.br/browse/HCMAPP-1408) - Ajustado o componente [SeniorPrimaryButton] para suportar cores dinâmicas fornecidas pela funcionalidade de personalização mobile. Foi adiciona novo parâmetro [outlineBorderColor]. caso o parâmetro venha nulo pegara a cor do parâmetro [BorderColor] como e atualmente.
* [HCMAPP-1401](https://jira.senior.com.br/browse/HCMAPP-1401) - Adaptação do Senior Design System (SDS) para suportar cores dinâmicas provenientes da funcionalidade de personalização mobile. Essa atualização permite que os componentes utilizem cores personalizadas definidas pelo usuário, garantindo consistência visual e flexibilidade.[senior_balance] [senior_badge] [senior_bottom_navigation_bar] [senior_bottom_sheet] [senior_button] [senior_calendar] [senior_card] [senior_carousel_slider]
* [HCMAPP-1412](https://jira.senior.com.br/browse/HCMAPP-1412) - [Personalização][SDS] Criar métodos para validação de cores - Adicionada a classe [SeniorServiceColor].
[getColorSquareButtonsTheme]: Retorna a cor ideal para ícones, considerando contraste com a cor de fundo (claro ou escuro) e estado do botão (habilitado/desabilitado).
[getColorTheme]: Avalia o contraste de uma cor fornecida com branco e retorna preto se o contraste for insuficiente.
[contrastRatio]: Calcula a relação de contraste entre duas cores para validação de acessibilidade.
* [DSN-4704](https://jira.senior.com.br/browse/DSN-4704) - Propriedade contentAsWidget na modal.

# 9.0.2
[02/12/2024]

### Melhorias
* [HCMAPP-1290](https://jira.senior.com.br/browse/HCMAPP-1290) - Adicionado Parâmetros [padding] e [textStyle] nos componentes SeniorBadgeWidget e SeniorBadgeBase, permitindo a customização do padding e do estilo do texto.

### Correções
* [DSN-4675](https://jira.senior.com.br/browse/DSN-4675) - Correções Sonar.

# 9.0.1
[25/11/2024]

### Correções
* [#ERPINOV-674](https://jira.senior.com.br/browse/ERPINOV-674) - Adicionando a dependência direta do Intl novamente.

### Alteração de dependências
* `intl`: ^0.18.1 -> ^0.19.0

# 9.0.0
[25/11/2024]

### Melhorias
* [#ERPINOV-674](https://jira.senior.com.br/browse/ERPINOV-674) - Atualização de dependências e versão do SDK do example.

### Alteração de dependências
* `dotted_border`: ^2.0.0+3 -> ^2.1.0
* `flutter_image_compress`: ^2.0.4 -> ^2.3.0
* `flutter_svg`: ^2.0.7 -> ^2.0.14
* `font_awesome_flutter`: ^10.5.0 -> ^10.8.0
* `image_picker`: ^1.0.2 -> ^1.1.2
* `path_provider`: ^2.1.0 -> ^2.1.5
* `provider`: ^6.0.5 -> ^6.1.2
* `rive`: ^0.11.14 -> ^0.13.17
* `senior_design_tokens`: ^3.0.0 -> ^3.0.1
* `signature`: ^5.4.0 -> ^5.5.0
* `table_calendar`: ^3.0.9 -> ^3.1.2
* `image_cropper`: ^5.0.0 -> ^8.0.2
* `intl`: removido

# 8.1.1
[04/10/2024]

### Melhorias
* [#ERPINOV-614](https://jira.senior.com.br/browse/ERPINOV-614) SDS - Alteração no SeniorLinearLongPressButton para icone opcional

# 8.1.0
[02/10/2024]

### Novas funcionalidades
* [DSN-4679](https://jira.senior.com.br/browse/DSN-4679) - Novo componente SeniorIcon.

# 8.0.4
[02/10/2024]

### Melhorias
* [DSN-4647](https://jira.senior.com.br/browse/DSN-4647) - Disponibilizada a propriedade closable e onClose no SeniorModal.

# 8.0.3
[27/08/2024]

### Melhorias
# 8.0.2
[20/08/2024]

### Melhorias
* [HCMAPP-1246](https://jira.senior.com.br/browse/HCMAPP-1246) - Adicionado Parâmetro [paddingListView] no componente SeniorSquareButtonsMenu com valor padrão de [EdgeInsets.zero], permitindo a customização do padding na lista de botões.

# 8.0.1
[30/07/2024]

### Correções
* [DSN-4643](https://jira.senior.com.br/browse/DSN-4643) - Ajustada a cor dos ícones do SeniorTextField no tema escuro.

# 8.0.0
[30/07/2024]

### Quebras de compatibilidade
* Agora o SeniorDropdownButton não salva o valor selecionado internamente. É necessário repassar o valor recebido no onSelect para o parâmetro value.

### Correções
* [DSN-4634](https://jira.senior.com.br/browse/DSN-4634) - Permitindo limpar os valores do SeniorDropdownButton e SeniorMultidropdownButton.

# 7.0.17
[24/07/2024]

### Correções
* [DSN-4635](https://jira.senior.com.br/browse/DSN-4635) - Removendo padding ao redor do SeniorSquareButtonsMenu.

# 7.0.16
[09/07/2024]

### Melhorias
* [HCMAPP-1109](https://jira.senior.com.br/browse/HCMAPP-1109) adicionado parametro titlePadding  padding do título é titleAlignment o para alinhamento do título `Senior_bottom_Sheet_Widget`
Adicionado parametro disableLayoutBuilder opcional para desativar LayoutBuilder no `Senior_check_box` pois em algumas situações a implementação do checkbox dava overflow no layout.
Adicionado a opção de ter um checkbox abaixo do content  `Senior_modal_widget`;

# 7.0.15
[02/07/2024]

### Melhorias
* [HCMAPP-1146](https://jira.senior.com.br/browse/HCMAPP-1146) - Adicionados novos parâmetros opcionais nos componentes: `SENIOR_BOTTOM_SHEET_WIDGET`: Adicionado o parâmetro opcional `padding` é `SENIOR_TEXT_FIELD_WIDGET`: Adicionados os parâmetros opcionais `border` e `expands`.

# 7.0.14
[27/06/2024]

### Correções
* [DSN-4619](https://jira.senior.com.br/browse/DSN-4619) - Ajustando Scroll no SeniorBottomSheet.

# 7.0.13
[17/06/2024]

### Melhorias
* [DSN-4617](https://jira.senior.com.br/browse/DSN-4617) - Ajustando as cores do dark mode do SeniorText.

# 7.0.12
[14/06/2024]

### Melhorias
* [DSN-4616](https://jira.senior.com.br/browse/DSN-4616) - Permitindo passar a duração para o SeniorSnackbar.

# 7.0.11
[13/06/2024]

### Correções
* [DSN-4606](https://jira.senior.com.br/browse/DSN-4606) - Ajustando o contraste das notificações do SeniorColorfulHeaderStructure.

# 7.0.10
[11/06/2024]

# 7.0.9
[11/06/2024]

# 7.0.8
[10/06/2024]

### Melhorias
* [HCMAPP-981](https://jira.senior.com.br/browse/HCMAPP-981) - Foi criado um novo serviço para obter imagens da galeria ou da câmera. Anteriormente, isso só era possível utilizando o componente SeniorImageCropper. Agora, é possível realizar essa tarefa diretamente através do serviço SeniorImageService, chamando as funções getImageFromGallery ou getImageFromCamera, sem a necessidade de utilizar o componente SeniorImageCropper.

# 7.0.7
[04/04/2024]

### Melhorias
* [DSN-4544](https://jira.senior.com.br/browse/DSN-4544) - Ajustes nas cores e no estilo de borda do SeniorTextField.

# 7.0.6
[27/03/2024]

### Melhorias
* [HCMAPP-1021](https://jira.senior.com.br/browse/HCMAPP-1021) - foi alterado o comportamento do label do BottomNavigationBarItem para quando estiver selecionado ficar em negrito. foi adicionado 2 paramentros para o BottomNavigationBarItem, o IconSize e o IconPadding para que possa ser customizado o tamanho do icone e o padding do icone.

# 7.0.5
[16/02/2024]

### Correções
* [GPO-8291](https://jira.senior.com.br/browse/GPO-8291) - Removendo a dependência de permission_handler que não é mais necessária.

# 7.0.4
[31/01/2024]

### Correções
* [DSN-4504](https://jira.senior.com.br/browse/DSN-4504) - Ajuste no buildNotification do SeniorNotificationList
* [DSN-4505](https://jira.senior.com.br/browse/DSN-4505) - Ajuste no hintTextColor e HelperTextColor do SeniorTextField

# 7.0.3
[31/01/2024]

### Correções
* [DSN-4503](https://jira.senior.com.br/browse/DSN-4503) - Ajuste na propriedade elevation do SeniorBottomSheet

# 7.0.2
[24/01/2024]

### Correções
* [DSN-4496](https://jira.senior.com.br/browse/DSN-4496) - Ajuste no nome da propriedade suffixWidget e suffixIcon do componente SeniorTextField.

# 7.0.1
[19/01/2024]

### Correções
* [DSN-4496](https://jira.senior.com.br/browse/DSN-4496) - Pequenas correções no SeniorTextField.
- Disponibilizada a propriedade hintText;
- Disponibilizada a propriedade autovalidateMode;
- Adicionado uma cor de fundo para o campo;
- Adicionado um padding no componente para que outros componentes não sobreponham o label do campo.
- Ajustado espaçamento lateral do conteúdo que estava maior do que o esperado.

# 7.0.0
[16/01/2024]

### Quebras de compatibilidade
* [DSN-4383](https://jira.senior.com.br/browse/DSN-4383) - Novo SeniorTextField. Muito mais próximo do TextField do Material.
* Removendo a propriedade iconData do SeniorMenuListItem.

# 6.0.3
[19/12/2023]

### Melhorias
* [HCMAPP-908](https://jira.senior.com.br/browse/HCMAPP-908) - SeniorMenuItemList a partir de agora permite um Widget onde era um IconData para atender diversos cenários.
- Os botões do componente SeniorModal podem ter um estado de ocupado..
* [DSN-4232](https://jira.senior.com.br/browse/DSN-4232) - Ajustando componentes para usar a nova escala de cinza.

# 6.0.2
[15/12/2023]

### Correções
* [DSN-4462](https://jira.senior.com.br/browse/DSN-4462) - Corrigindo warning na definição das plataformas compatíveis.

# 6.0.1
[14/12/2023]

### Correções
* [DSN-4458](https://jira.senior.com.br/browse/DSN-4458) - Ajustando o tema do SeniorCheckbox e do texto do Material.

# 6.0.0
[27/11/2023]

### Quebras de compatibilidade
* [DSN-4409](https://jira.senior.com.br/browse/DSN-4409) - O parâmetro size deixa de existir no componente SeniorButton.
- Não há mais a variação de tamanho small e big do SeniorButton e SeniorLinearLongPressButton.
- O componente SeniorActionButton foi removido da biblioteca.
- O componente SeniorAppBar foi removido da biblioteca.
- O componente SeniorEvaluation foi removido da biblioteca.
- O parâmetro onTapBack do SeniorColorfulHeaderStructure foi removido.
- O parâmetro horizontalPadding do SeniorNotificationList foi removido.

# 5.1.3
[27/11/2023]

### Correções
* [DSN-4436](https://jira.senior.com.br/browse/DSN-4436) - Removendo _surfaceTintColor_ do SeniorModal.

# 5.1.2
[26/11/2023]

### Correções
* [DSN-4436](https://jira.senior.com.br/browse/DSN-4436) - Ajustando o tema dos componentes nativos do Material.

# 5.1.1
[26/11/2023]

### Melhorias
* [DSN-4410](https://jira.senior.com.br/browse/DSN-4410) - Atualizado o componente Senior Text na nova escala de cinza.

# 5.1.0
[24/11/2023]

### Novas funcionalidades
* [DSN-4223](https://jira.senior.com.br/browse/DSN-4223) - Widget SeniorExpandableList.

# 5.0.2
[21/11/2023]

### Melhorias
* [DSN-4407](https://jira.senior.com.br/browse/DSN-4407) - Foi removido o padding que envolvia o SeniorProgressBar para facilitar o alinhamento do componente.

### Correções
* [DSN-4407](https://jira.senior.com.br/browse/DSN-4407) - O SeniorModal não estava permitindo usar botões danger.

# 5.0.1
[21/11/2023]

### Melhorias
* [DSN-4261](https://jira.senior.com.br/browse/DSN-4261) - Permitindo remover um item do SeniorNotificationList. Adicionando representação de status nos itens.

# 5.0.0
[20/10/2023]

### Quebras de compatibilidade
* [DSN-4359](https://jira.senior.com.br/browse/DSN-4359) - O componente Modal deixa de receber componentes buttons e recebe apenas as propriedades dos botões, sendo agora responsabilidade da modal criar e posicionar os botões. Agora posiciona em coluna em telas menores e em linha em telas maiores.

### Melhorias
* [DSN-4359](https://jira.senior.com.br/browse/DSN-4359) - Posicionando os botões da Modal em linha.

# 4.0.5
[02/10/2023]

### Melhorias
* [DSN-4340](https://jira.senior.com.br/browse/DSN-4340) - Ajustando estilos da mensagem do SeniorColorfulHeaderStructure.

# 4.0.4
[02/10/2023]

### Melhorias
* [DSN-4341](https://jira.senior.com.br/browse/DSN-4341) - Disponibilizando busy state para todos os tipos de botões.

# 4.0.3
[27/09/2023]

### Correções
* [DSN-4339](https://jira.senior.com.br/browse/DSN-4339) - Corrigido contraste da mensagem do SeniorColorfulHeaderStructure no darkmode.

# 4.0.2
[22/09/2023]

### Correções
* [DSN-4336](https://jira.senior.com.br/browse/DSN-4336) - Corrigido a construção do SeniorBadge com base na posição do ícone.

# 4.0.1
[29/08/2023]

### Melhorias
* [DSN-4308](https://jira.senior.com.br/browse/DSN-4308) - Determinando as plataformas suportadas pelo pacote.

# 4.0.0
[18/08/2023]

### Quebras de compatibilidade
* [DSN-3888](https://jira.senior.com.br/browse/DSN-3888) - Foi reescrito o componente SeniorButton. Novas propriedades foram disponbilizadas, como o estado outlined e danger nos primários. A forma de utilização dos botões também mudou, sendo necessário adequar os projetos que usavam a antiga versão do componente.
resumo das alterações:
  * O tipo de botão danger deixa de exisitir e passa a ser uma propriedade do botão primário.
  * Foi disponibilizado o estado outlined nos botões primérios.
  * O estado _busy_, assim como a mensagem de carregamento -- _busyMessage_ -- fica exclusivo apenas do botão primário. Se no seu projeto estava sendo usado um estado de carregamento em um botão secundário ou terciário entre em contato com o UX do seu produto.
  * O construtor _SeniorButton.icon_ deixa de existir e todos os botões recebem o parâmetro icon que pode ser informado para adicionar um ícone ao botão.
  * Foram disponibilizados os construtores _SeniorButton.primary_, _SeniorButton.secondary_ e _SeniorButton.ghost_ para criar botões primários, secundários e terceários respectivamente.
  * Construir o botão apenas com SeniorButton cria sempre um botão primário.
  * O parâmetro _fullLength_ passou a se chamar _fullWidth_. O funcionamento se manteve o mesmo.
  * Foi disponibilizado o parâmetro _style_ que permite customizar um botão específico da aplicação.
  * As propriedades de estilo do componente utilizadas no tema mudaram. Se no aplicativo estão sendo customizados os estilos do botão é importante rever o tema. Os temas light e dark padrão já estão adequados.

* [DSN-4219](https://jira.senior.com.br/browse/DSN-4219) - Foi reescrito o componente SeniorImageCropper. A antiga versão era um impeditivo para atualizarmos a versão do Flutter para suportar o SKD do Dart igual ou superior a 3. Algumas mudanças no componente foram geradas, em usabilidade e características. consulte a Dart Doc para adequá-lo ao seu projeto.
  * O componente não tem mais a dependência do image_crop que impedia a evolução da biblioteca.
  * O estilo no momento de recortar a imagem mudou. Agora difere de acordo com o sistema operacional em execução, tendo uma aparência em Android e outra no iOS.
  * Foram adicionados os parâmetros onException para tratar erros inesperados e alguns parâmetros que definem o texto de botões foram adicionados e outros removidos.

* [DSN-4245](https://jira.senior.com.br/browse/DSN-4245) - Foi reescrito o componente SeniorBadge para comportar o antigo SeniorBadge e o SeniorStatefulBadge. Agora as badges podem ser selecionáveis. O componente SeniorStatefulBadge não estará mais disponível e pode ser usado o SeniorBadge com os parâmetros `value` e `onSelect`.

* [DSN-4219](https://jira.senior.com.br/browse/DSN-4219) - Atualizada a versão do Flutter para suportar o SDK do Dart igual ou superior a 3 no projeto. Será necessário realizar atualização nos projetos que utilizam este pacote também para garantir um bom funcionamento.
  * **Versão do Flutter:** 3.13.0.
  * **Versão do Dart:** 3.1.0.

# 3.2.1
[07/08/2023]

### Melhorias
* [DSN-4242](https://jira.senior.com.br/browse/DSN-4242) - Adicionado README do projeto.

# 3.2.0
[31/07/2023]

### Melhorias
* [HCMAPP-810](https://jira.senior.com.br/browse/HCMAPP-810) - Deixando a criação do dia customizável.

# 3.1.0
[12/07/2023]

### Melhorias
* [HCMAPP-772](https://jira.senior.com.br/browse/HCMAPP-772) - SeniorBadge com suporte para adicionar cor do ícone.

# 3.0.5
[29/06/2023]

### Melhorias
* [DSN-4181](https://jira.senior.com.br/browse/DSN-4181) - Foram realizados ajustes para adequar o Image Cropper ao tema dark.

# 3.0.4
[28/06/2023]

### Correções
* [DSN-4120](https://jira.senior.com.br/browse/DSN-4120) - Foram feitos os seguintes ajustes nos componentes:
- Cor do placeholder do componente SeniorTextField no tema claro.
- Cor dos ícones no componente SeniorTextField no tema claro.
- Padding do conteúdo do SeniorTextField.
- Tamanho do SeniorTextField de senha com foco.

# 3.0.3
[12/06/2023]

### Melhorias
* [DSN-4150](https://jira.senior.com.br/browse/DSN-4150) - Ajuste espaçamento bottomSheet quando title é null.

# 3.0.2
[26/05/2023]

### Correções
* [HCMAPP-743](https://jira.senior.com.br/browse/HCMAPP-743) - Ajuste calendario para respeitar darkmode.

# 3.0.1
[25/05/2023]

### Alteração de dependências
* Atualização do Rive.

# 3.0.0
[25/05/2023]

### Quebras de compatibilidade
* Será necessário atualizar a versão do Rive para a versão 0.11.1 nos projetos.
* Os parâmetros do widget SeniorCalendar mudaram.

### Correções
* [GPO-7124](https://jira.senior.com.br/browse/GPO-7124) - Correção do calendário

# 2.2.17
[24/05/2023]

### Correções
* [HCMAPP-743](https://jira.senior.com.br/browse/HCMAPP-743) - Ajustada cor do SeniorIconButton.
* [HCMAPP-743](https://jira.senior.com.br/browse/HCMAPP-743) - Alterada a Cor do Container que agrupa os buttons do SeniorImagemCroppe para adequar ao tema escuro.

# 2.2.16
[17/05/2023]

### Alteração de dependências
* Atualização do flutter_svg de 1.1.6 para 2.0.5.

# 2.2.15
[11/05/2023]

### Alteração de dependências
* Usando a versão 0.17.0 do intl.

# 2.2.14
[11/05/2023]

### Melhorias
* [DSN-4115](https://jira.senior.com.br/browse/DSN-4115) - Ajustes SeniorTextField.password, BottomSheet dinâmico e validator do PinCode.

# 2.2.13
[05/05/2023]

### Correções
* [HCMAPP-585](https://jira.senior.com.br/browse/hcmapp-585) - Feito correção no padding do GridView do SeniorCaldendar, feito correção no titleTextStyle do SeniorBottomSheetWidget que não estava pegando as alterações de fonte enviadas pelo parametro.
* [DSN-4111](https://jira.senior.com.br/browse/DSN-4111) - Correção de erro que impedia exibir a bottom-sheet quando o content tivesse um expanded.
* [DSN-4111](https://jira.senior.com.br/browse/DSN-4111) - Ajustando a cor do ícone de mostrar e ocultar a senha nos campos de senha.
* [DSN-4111](https://jira.senior.com.br/browse/DSN-4111) - Ajustando as cores de label, helper e borda do senior_text_field no tema light e dark padrão.
* [DSN-4111](https://jira.senior.com.br/browse/DSN-4111) - Correção da borda inferior do campo de senha quando tem foco.

# 2.2.12
[28/04/2023]

### Alteração de dependências
* Atualização de dependência do projeto.

# 2.2.11
[26/04/2023]

### Correções
* [DSN-4082](https://jira.senior.com.br/browse/DSN-4082) - Ajuste de validação do SeniorTextField de acordo com a flag validateOnChange.

# 2.2.10
[26/04/2023]

### Melhorias
* [DSN-4081](https://jira.senior.com.br/browse/DSN-4081) - Disponibilizando os parâmetros *fullLength* e *size* no SeniorLinearLongPressButton.

# 2.2.9
[25/04/2023]

### Correções
* [DSN-4077](https://jira.senior.com.br/browse/DSN-4077) - Posicionamento do closeButton, título e padding no SeniorBottonSheet.

# 2.2.8
[24/04/2023]

### Correções
* [DSN-4076](https://jira.senior.com.br/browse/DSN-4076) - Correção de bug que impedia que não fosse possível ocultar o leading da app bar do Colorful Header Structure.

# 2.2.7
[18/04/2023]

### Melhorias
* [DSN-4065](https://jira.senior.com.br/browse/DSN-4065) - Possibilidade de ter a altura do BottomSheet flexível de acordo com a altura do conteúdo.
* [HCMAPP-704](https://jira.senior.com.br/browse/hcmapp-704) - Ajuste para possibilitar rolagem horizontal de página e atualizar a aba atual

# 2.2.6
[14/04/2023]

### Correções
* [DSN-4044](https://jira.senior.com.br/browse/DSN-4044) - Ajustes nas abas e marcando onTapBack como deprecated.

# 2.2.5
[12/04/2023]

### Melhorias
* [DSN-4045](https://jira.senior.com.br/browse/DSN-4045) - Possibilidade de adicionar abas no SeniorColorfulHeaderStructure.

### Correções
* [DSN-3842](https://jira.senior.com.br/browse/DSN-3842) - Ajustada a cor de fundo do SeniorDropdownButton e do SeniorTextField.

# 2.2.4
[11/04/2023]

### Melhorias
* [DSN-4050](https://jira.senior.com.br/browse/DSN-4050) - Adicionada a possibilidade de ter bordas no SeniorCard.

# 2.2.3
[05/04/2023]

### Melhorias
* [DSN-4044](https://jira.senior.com.br/browse/DSN-4044) - Leading do SeniorColorfulHeader passa a ser definido pelos produtos.

# 2.2.2
[04/04/2023]

### Correções
* [DSN-4043](https://jira.senior.com.br/browse/DSN-4043) - Correção de alinhamento do checkbox e seu título quando tem mais de um linha.

# 2.2.1
[04/04/2023]

### Melhorias
* [HCMAPP-686](https://jira.senior.com.br/browse/HCMAPP-686) - Inclusão de ocultar a opção de fechar a notificação.

### Correções
* [DSN-4034](https://jira.senior.com.br/browse/DSN-4034) - Disponibilizada a propriedade validadeOnChange no SeniorTextField.

# 2.2.0
[28/03/2023]

* [GPO-7133](https://jira.senior.com.br/browse/GPO-7133) - Adição das notificações no ColorfulHeaderStructure.

# 2.1.5
[17/03/2023]

### Melhorias
* [GPO-7132](https://jira.senior.com.br/browse/GPO-7132) - Adição de seleção por período no calendário.

# 2.1.4
[13/03/2023]

### Correções
* [GPO-7130](https://jira.senior.com.br/browse/GPO-7130) - Adicionando os métodos select e unselect no SeniorStatefulBadge.
* [GPO-7130](https://jira.senior.com.br/browse/GPO-7130) - Adicionando a propriedade outlined no SeniorBadge.

# 2.1.3
[10/03/2023]

### Melhorias
* [DSN-3977](https://jira.senior.com.br/browse/DSN-3977) - Adicionando elipsis quando o texto ocupa mais espaço do que o disponível no botão.

# 2.1.2
[09/03/2023]

### Melhorias
* [ERPAVG-885](https://jira.senior.com.br/browse/ERPAVG-885) - Adicionada a possibilidade de controlar o tamanho do leading do backdrop.

# 2.1.1
[07/03/2023]

### Correções
* [HCMAPP-585](https://jira.senior.com.br/browse/hcmapp-585) - Feito correção no padding do GridView do SeniorCaldendar, feito correção no titleTextStyle do SeniorBottomSheetWidget que não estava pegando as alterações de fonte enviadas pelo parametro.

# 2.1.0
[03/03/2023]

### Novas funcionalidades
* [GPO-7131](https://jira.senior.com.br/browse/DSN-7131) - Criação do widget SeniorStatefulBadgeWidget

### Melhorias
* [DSN-3966](https://jira.senior.com.br/browse/DSN-3966) - Ajustando a documentação do SeniorLoading para referenciar as constantes de tamanho.

### Correções
* [DSN-3940](https://jira.senior.com.br/browse/DSN-3940) - Ajustada a responsividade do título e subtítulo do componente SeniorList.
* [DSN-3933](https://jira.senior.com.br/browse/DSN-3933) - Ajustado o tema dark do componente SeniorCheckbox.

# 2.0.0
[27/02/2023]

### Melhorias
* N/A

### Quebras de compatibilidade
* [GPO-7126](https://jira.senior.com.br/browse/GPO-7126) - O componente LongPressButton passou a ser chamado de CircularLongPressButton.

### Novas funcionalidades
* [GPO-7126](https://jira.senior.com.br/browse/GPO-7126) - Disponibilizando o componente LinearLongPressButton.

# 1.1.5
[27/02/2023]

### Melhorias
* [DSN-3925](https://jira.senior.com.br/browse/DSN-3925) - Agora o onChanged do Radio Button é disparado no seu título também.

# 1.1.4
[24/02/2023]

### Correções
* Versão do Intl para compatibilidade.

# 1.1.3
[16/02/2023]

### Melhorias
* [DSN-3923](https://jira.senior.com.br/browse/DSN-3923) - Disponibilizando as propriedade darkColor e iconDarkColor nos objetos SeniorTimelineIndicators. Permitindo assim definir uma cor para o indicador e para seu ícone em light mode e dark mode.

# 1.1.2
[16/02/2023]

### Melhorias
* [DSN-3918](https://jira.senior.com.br/browse/DSN-3918) - Atualização de cores do tema dark do componente SeniorSquareButtonsMenu.

# 1.1.1
[15/02/2023]

### Correções
* [DSN-3917](https://jira.senior.com.br/browse/DSN-3917) - Ajustado alinhamento do radio button com o seu texto.

# 1.1.0
[14/02/2023]

### Novas funcionalidades
[DSN-3907](https://jira.senior.com.br/browse/DSN-3907) - Disponibilizado o componente SeniorText.

### Correções
[DSN-3883](https://jira.senior.com.br/browse/DSN-3883) - Ajuste no processo de publicação da biblioteca.

# 1.0.0
[31/01/2023]

### Quebras de compatibilidade
[DSN-3883](https://jira.senior.com.br/browse/DSN-3883) - Atualização do Flutter para a versão `3.7.0`.

# 0.28.6
[25/01/2023]

### Melhorias
[DSN-3870](https://jira.senior.com.br/browse/DSN-3870) - Permitindo informar o ícone do SeniorLongPressButton.

# 0.28.5
[17/01/2023]

### Correções
[ERPAVG-627](https://jira.senior.com.br/browse/ERPAVG-627) - Corrigido problema que gerava uma sobreposição entre o cursor e o label do PasswordField.

# 0.28.4
[17/11/2022]

[DSN-3727](https://jira.senior.com.br/browse/DSN-3727) - Corrigido problema que criava um espaço extra na bottom sheet quando o teclado era aberto.

# 0.28.3
[04/11/2022]

[DSN-3719](https://jira.senior.com.br/browse/DSN-3719) - Removendo lineHeight de texto de botão para que ele fique centralizado.


# 0.28.2
[01/11/2022]

[DSN-3124](https://jira.senior.com.br/browse/DSN-3124) - Ajustando cores de elementos do SeniorTimeline.

# 0.28.1
[27/10/2022]

### Correções
[DSN-1710](https://jira.senior.com.br/browse/DSN-1710) - Corrigido erro ao abrir a bottom-sheet.
[DSN-1710](https://jira.senior.com.br/browse/DSN-1710) - Adicionada novamente a propriedade bottomText que não estava mais disponível.

# 0.28.0
[24/10/2022]

### Quebras de compatibilidade
[DSN-3597](https://jira.senior.com.br/browse/DSN-3597) - Com a nova estrutura de temas é necessário adicionar o Widget SeniorDesignSystem no ponto mais alto da árvore de Widgets.
Isso irá garantir que o gerenciamento de temas seja construído.
A ausência deste widget causará erros.
[DSN-3597](https://jira.senior.com.br/browse/DSN-3597) - É necessário que o compileSdkVersion esteja na versão 33.

### Novas funcionalidades
[DSN-3597](https://jira.senior.com.br/browse/DSN-3597) - DarkTheme dos componentes e gerenciamento de temas.

# 0.27.7
[24/10/2022]

### Correções
* [HCMAPP-496](https://jira.senior.com.br/browse/HCMAPP-496) - Correção de erro que acontecia quando o nome do usuário continha espaços seguidos.

# 0.27.6
[18/10/2022]

### Melhorias
* Tornando o texto que indica o limite de caracteres no SeniorTextField opcional.

# 0.27.5
[06/10/2022]
* Alterado o comportamento da SeniorBottomSheet, para que a mesma se redimensione ao exibir o teclado.

# 0.27.4
[28/09/2022]
* [DSN-3631](https://jira.senior.com.br/browse/DSN-3631) - Usando as constantes de fontes.

# 0.27.3
[28/09/2022]

### Melhorias
* [DSN-3632](https://jira.senior.com.br/browse/DSN-3632) - Usando as constantes de tamanhos de ícones.

# 0.27.2
[05/09/2022]
* Adicionando o componente SeniorSuccessAnimation. [DSN-3216](https://jira.senior.com.br/browse/DSN-3216).
* Adicionando o componente SliderDots. [DSN-3559](https://jira.senior.com.br/browse/DSN-3559).

# 0.27.1
[30/08/2022]

### Melhorias
* Disponibilizando a opção de apagar o conteúdo dos campos do componente Pin Code Fields. [DSN-3283](https://jira.senior.com.br/browse/DSN-3283).
* Disponibilizando a opção de colar conteúdo da área de transferência no componente Pin Code Fields. [DSN-3283](https://jira.senior.com.br/browse/DSN-3283).
* Disponibilizando a possibilidade de bordas quadradas no componente Stepper. [DSN-3565](https://jira.senior.com.br/browse/DSN-3565).
* Habilitando no componente Stepper a possibilidade de configurar as cores dos steps pelos estados de *completedStepColor*, *currentStepColor* e *uncompletedStepColor*. [DSN-3565](https://jira.senior.com.br/browse/DSN-3565).

# 0.27.0
[16/08/2022]

### Novas funcionalidades
* Adicionado o componente SeniorLongPressButton. [DSN-3539](https://jira.senior.com.br/browse/DSN-3539).
* Adicionado o componente SeniorCarouselSlider. [DSN-3396](https://jira.senior.com.br/browse/DSN-3396).

# 0.26.2
[12/08/2022]

### Melhorias
* Formatação do código para o style guide do Flutter. [DSN-3470](https://jira.senior.com.br/browse/DSN-3470).
* Alteração no link da homepage. [DSN-3470](https://jira.senior.com.br/browse/DSN-3470).

# 0.26.1
[11/08/2022]

### Melhorias
* Correções de lint. [DSN-3470](https://jira.senior.com.br/browse/DSN-3470)

# 0.26.0
[10/08/2022]

### Quebras de compatibilidade
* Downgrade do SdkVersion. [HCMAPP-422](https://jira.senior.com.br/browse/HCMAPP-422).

# 0.25.0
[04/08/2022]

### Novas funcionalidades
* Adicionado o componente SeniorCalendar. [HCMAPP-419](https://jira.senior.com.br/browse/HCMAPP-419).
* Adicionado o componente SeniorIconButton. [DSN-3451](https://jira.senior.com.br/browse/DSN-3451).
* Adicionado o componente SeniorSignature. [DSN-3398](https://jira.senior.com.br/browse/DSN-3398).
* Melhorias no componente SeniorStatePage. [DSN-3141](https://jira.senior.com.br/browse/DSN-3141).
* Adicionado o componente SeniorSlideToAct. [DSN-3402](https://jira.senior.com.br/browse/DSN-3402).

### Quebras de compatibilidade
* Atualização do Flutter para a versão 3.0.5. [DSN-3470](https://jira.senior.com.br/browse/DSN-3470).

# 0.24.0
* Adicionado o componente SeniorStepper. [HCMAPP-420](https://jira.senior.com.br/browse/HCMAPP-420).

# 0.23.0
[27/06/2022]

### Melhorias
* Atualizado o componente SeniorDropdownButton e disponibilizado o SeniorMultidropdownButton [DSN-3381](https://jira.senior.com.br/browse/DSN-3381).
* Ajustes no componente SeniorBadge. [DSN-3414](https://jira.senior.com.br/browse/DSN-3414).

# 0.22.0
[13/06/2022]

### Melhorias
* Permitindo passar mais de dois valores para o componente SeniorBalance. [DSN-3375](https://jira.senior.com.br/browse/DSN-3375).

# 0.21.6
[13/05/2022]

### Correções
* Adicionando variação de desabilitado no componente Card. [DSN-3374](https://jira.senior.com.br/browse/DSN-3374).

# 0.21.5
[13/05/2022]

### Correções
* Ajuste no componente SeniorCheckbox para alinhar no centro quando não houver título. [ERPATR-1466](https://jira.senior.com.br/browse/ERPATR-1466).


# 0.21.4
[11/05/2022]

### Melhorias
* Correção no componente SeniorBackdrop para não precisar recalcular a posição do body quando não possui abas configuradas. [DSN-3302](https://jira.senior.com.br/browse/DSN-3302).

# 0.21.3
[09/05/2022]

### Correções
* Ajustando tamanho mínimo do card. [DSN-3295](https://jira.senior.com.br/browse/DSN-3295).

# 0.21.2
[09/05/2022]

### Melhorias
* Disponibilizando os parâmetros padding e margin para o componente SeniorCard. [DSN-3295](https://jira.senior.com.br/browse/DSN-3295).

# 0.21.1
[06/05/2022]

### Correções
* Correção em border radius em componentes elevados. [DSN-3295](https://jira.senior.com.br/browse/DSN-3295).

# 0.21.0
[05/05/2022]

### Novas funcionalidades
* Adicionado o componente SeniorPinCodeField. [DSN-3283](https://jira.senior.com.br/browse/DSN-3283).

# 0.20.0
[29/03/2022]

### Novas funcionalidades
* O componente SeniorCard foi reescrito. [DSN-3002](https://jira.senior.com.br/browse/DSN-3002).
* Adicionado o componente SeniorList. [DSN-2993](https://jira.senior.com.br/browse/DSN-2993).
* Adicionado o componente SeniorDrawer. [DSN-3000](https://jira.senior.com.br/browse/DSN-3000).

# 0.19.9
[28/04/2022]

### Melhorias
* Alterando o design do componente TextField quando tiver mais linhas para uma aparência de TextArea. [DSN-3031](https://jira.senior.com.br/browse/DSN-3031).

# 0.19.8
[25/04/2022]

### Melhorias
* Permitindo desabilitar o comportamento de minimizar o componente Timeline opcional. [DSN-3249](https://jira.senior.com.br/browse/DSN-3249).

# 0.19.7
[13/04/2022]

### Melhorias
* Adicionando a propriedade titleMaxLines no componente SeniorMenuListItem. [DSN-3232](https://jira.senior.com.br/browse/DSN-3232).

# 0.19.6
[12/04/2022]
### Correções
* Fechar a notificação ao clicar na mesma. [HCMAPP-313](https://jira.senior.com.br/browse/HCMAPP-313).

# 0.19.5
[07/04/2022]

### Correções
* Ajustando padding do componente SeniorCard para centralizar o conteúdo. [DSN-3217](https://jira.senior.com.br/browse/DSN-3217).

# 0.19.4
[30/03/2022]

### Correções
* Correção em alinhamento no text field de senha que impedia que o conteúdo fosse visualizado. [DSN-3177](https://jira.senior.com.br/browse/DSN-3177).

# 0.19.3
[29/03/2022]

### Correções
* Adicionando ClipRRect nos componentes SeniorBackdrop e SeniorColorfulHeaderStructure para fazer com que o contéudo interno respeite o border radius da layer. [DSN-3148](https://jira.senior.com.br/browse/DSN-3148).

# 0.19.2
[29/03/2022]

### Correções
* Correção da cor do ícone de fechar do componente SeniorBottomSheet. [DSN-3177](https://jira.senior.com.br/browse/DSN-3177).
* Correção da cor do botão ghost quando desabilitado. [DSN-3177](https://jira.senior.com.br/browse/DSN-3177).

# 0.19.1
[29/03/2022]

### Correções
* Correção das cores quando o SeniorRating está habilitado e desabilitado. [DSN-3177](https://jira.senior.com.br/browse/DSN-3177).
* Correção no SeniorSwitch para retornar somente o switch quando não tiver título, evitando erro de alinhamento. [DSN-3177](https://jira.senior.com.br/browse/DSN-3177).
* Correção das cores quando o SeniorSquareButtonsMenu está habilitado e desabilitado. [DSN-3177](https://jira.senior.com.br/browse/DSN-3177).
* Parâmetro listen no SeniorThemeProvider.getTheme que é repassado para o Provider. [DSN-3177](https://jira.senior.com.br/browse/DSN-3177).
* Correção nas cores de SeniorModal. Tamanho flexível de acordo com o conteúdo apresentado. [DSN-3177](https://jira.senior.com.br/browse/DSN-3177).

# 0.19.0
[28/03/2022]

### Novas funcionalidades
* Adicionado o componente SeniorTimeline [DSN-3124](https://jira.senior.com.br/browse/DSN-3124).
* Adicionado o componente SeniorStatePage[DSN-3141](https://jira.senior.com.br/browse/DSN-3141).
* Adicionado o componente SeniorGradientIcon [DSN-3146](https://jira.senior.com.br/browse/DSN-3146).

# 0.18.2
[27/03/2022]

### Melhorias
* Disponibilizando a propriedade focusNode no componente SeniorTextField. [DSN-3088](https://jira.senior.com.br/browse/DSN-3088).

# 0.18.1
[25/03/2022]

### Melhorias
* Tornando a apresentação do ícone de ação do componente card opcional. [DSN-3137](https://jira.senior.com.br/browse/DSN-3137).

# 0.18.0
[22/03/2022]

### Alteração de dependências
* Atualizando a dependência de font_awesome_flutter para a versão 10.0.0 [DSN-3105](https://jira.senior.com.br/browse/DSN-3105).

# 0.17.1
[18/03/2022]

### Melhorias
  *Adicionada cor primária da senior no RefreshIndicator. [ERPAGRO-7481](https://jira.senior.com.br/browse/ERPAGRO-7481).

### Correções
  *Corrigido problema do setState. [ERPAGRO-7481](https://jira.senior.com.br/browse/ERPAGRO-7481).
  *Corrigido bug em que não exibia o leading da appBar. [ERPAGRO-7481](https://jira.senior.com.br/browse/ERPAGRO-7481).

# 0.17.0
[18/03/2022]

### Melhorias
* Adicionando estrutura de temas para os componentes [DSN-2849](https://jira.senior.com.br/browse/DSN-2849).
* Adicionando os parâmetros iconColor e textColor no componente SeniorDraggableItem [DSN-2849](https://jira.senior.com.br/browse/DSN-2849).

# 0.16.0
[11/03/2022]

### Novas funcionalidades
* Criado o SeniorBackdrop [ERPAGRO-7481](https://jira.senior.com.br/browse/ERPAGRO-7481).

### Melhorias
* Os componentes SeniorColorfulHeaderStructure, SeniorAppBarHome, SeniorAppBarPage, SeniorAppBarCustom foram depreciados [ERPAGRO-7481](https://jira.senior.com.br/browse/ERPAGRO-7481).
* Adicionadas documentações de componentes  [DSN-2928](https://jira.senior.com.br/browse/DSN-2928).

# 0.15.15
[18/02/2022]

### Melhorias
* Adicionado o parâmetro "bottom" à SeniorAppBarCustom [DSN-3022](https://jira.senior.com.br/browse/DSN-3022).
* PreferredSize agora é configurado através do parâmetro "prefSize" na SeniorAppBar/Custom [DSN-3022](https://jira.senior.com.br/browse/DSN-3022).

# 0.15.14
[17/02/2022]

### Melhorias
* Componente SeniorBadge que irá substituir o SeniorEvaluation [DSN-2979](https://jira.senior.com.br/browse/DSN-2979).

# 0.15.13
[15/02/2022]

### Melhorias
* Ajustes nos espaçamentos do *SeniorSquareButtonsMenu* [HCMAPP-265](https://jira.senior.com.br/browse/HCMAPP-265)

# 0.15.12
[15/02/2022]

### Melhorias
* Definindo Navigation.pop como ação padrão para o botão de voltar do SeniorColorfulHeaderStructure [HCMAPP-257](https://jira.senior.com.br/browse/HCMAPP-257).

# 0.15.11
[14/02/2022]

### Melhorias
* Adicionado espaçamento embaixo respeitando o "notch" do IOS [HCMAPP-257](https://jira.senior.com.br/browse/HCMAPP-257)

# 0.15.10
[10/02/2022]

### Correções
* [DSN-2922](https://jira.senior.com.br/browse/DSN-2922) - Removendo cor de fundo adicionada abaixo dos checkbox no *SquareButtonMenu*.

# 0.15.9
[08/02/2022]

### Melhorias
* [DSN-2922](https://jira.senior.com.br/browse/DSN-2922) - Adicionando as propriedades *extraTapMargin* e *actionOnTitle* para permitir uma área maior de toque no checkbox e selecioná-lo a partir do title.

# 0.15.8
[31/01/2022]

### Correções
* Adicionado o elevation na SeniorAppBar para remover o problema de exibir sombras.
* Removido o Align do SeniorAppBarCustom, para que quando passe um leading null ele respeite o padrão da AppBar.
* Alterado o preferredSize de 100 para 50.

# 0.15.7
[31/01/2022]

### Correções
* Ajustes nas cores do componente SeniorCheckbox. [DSN-2909](https://jira.senior.com.br/browse/DSN-2909)

# 0.15.6
[27/01/2022]

### Correções
* Tamanho dos botões da tela de salvar imagem de acordo com o tamanho da tela no SeniorImageCropper. [N/A.](https://jira.senior.com.br/browse/DSN-2859)
* Usando Permission.photos para requisitar permissão para os arquivos de imagem. [N/A.](https://jira.senior.com.br/browse/DSN-2859)

# 0.15.5
[24/01/2022]

### Correções
* Condicionando a solicitação de permissão de acesso à câmera e arquivos no componente ImageCropper a dispositivos iOS. [DSN-2870](https://jira.senior.com.br/browse/DSN-2870)

# 0.15.4
[21/01/2022]

### Correções
* Opção de reduzir a qualidade de imagem para limitar seu tamanho no componente SeniorImageCropper. [HCMAPP-183](https://jira.senior.com.br/browse/HCMAPP-183)
* Adicionando estado isLoading no componente SeniorProfilePicture. [HCMAPP-183](https://jira.senior.com.br/browse/HCMAPP-183)

# 0.15.3
[21/01/2022]

### Correções
* Tamanho dos botões de acordo com o tamanho da tela no SeniorImageCropper. [DSN-2859](https://jira.senior.com.br/browse/DSN-2859)

# 0.15.2
[14/01/2022]

### Correções
* Apresentando ícone de push no card apenas se tiver pushAction. [DSN-2854](https://jira.senior.com.br/browse/DSN-2854)

# 0.15.1
[14/01/2022]

### Correções
* Deixando título do ContactBook como opcional. [HCMAPP-157](https://jira.senior.com.br/browse/HCMAPP-157)

# 0.15.0
[12/01/2022]

### Novas funcionalidades
* Added *SeniorContactBookItem* component.

# 0.14.6
[31/12/2021]

### Fix
- *SeniorNotificationList* adjust push button padding and consider lower padding for some iOS devices.

### Features
- N/A

# 0.14.5

[{28/12/2021}]

### Fix

- *SeniorNotificationList* move the loading component to the item list and changes the button type from *secondary* to *ghost* and changed the button fullLength property to true.

# 0.14.4

[{28/12/2021}]

### Features

- Added *SeniorNotificationSnackbar*

# 0.14.3

[{28/12/2021}]

### Fix

- *SeniorNotificationList* add a scrollbar along with your controller.

### Features

# 0.14.2

[{28/12/2021}]

### Fix

- *SeniorSwitch* component resizing.

### Features

- Remove top padding in *SeniorNotificationList*.

# 0.14.1

[{27/12/2021}]

### Features

- isRead in *SeniorNotificationList* component.

# 0.14.0

[{24/12/2021}]

### Features

- Added *SeniorNotificationList* component.

# 0.13.1

[{20/12/2021}]

### Features

- Added *Dismissible* behavior in *SeniorCard* component.

# 0.13.0

[{20/12/2021}]

### Features

- Added *SeniorImageCropper* component.

# 0.12.0

[{13/12/2021}]

### Features

- Added *SeniorDraggableList* component.
- Added *SeniorMessageCard* component.

# 0.11.5

[{09/12/2021}]

### Features

- Revert property *hasTopShadow* on *SeniorColorfulHeaderStructure* component.

# 0.11.4

[09/12/2021]

### Features

- Added property *hasTopShadow* on *SeniorColorfulHeaderStructure* component.

# 0.11.3

[06/12/2021]

### Fix

- Adding the *itemPadding* and *itemSize* properties to the *SeniorRating* component.

# 0.11.2

[03/12/2021]

### Fix

- *SeniorSwitch* component resizing.

# 0.11.1

[02/12/2021]

### Fix

- Remove space from prefixIcon if there is no icon in *SeniorDropdownButton*.

# 0.11.0

[01/12/2021]

### Features

- Added *SeniorAppBarCustom* component.

# 0.10.15

[29/11/2021]

### Fix

- Parameter to inform the label of the *SeniorTextField* component's counter and allow internationalization.
- Setting null value as default for *textInputAction* in *SeniorTextField* component.

# 0.10.14

[26/11/2021]

### Fix

- Title font resizing in *SeniorBottonSheet* component.


# 0.10.13

[25/11/2021]

### Fix

- Aligned label with hint text in *SeniorTextField* component.

# 0.10.12

[24/11/2021]

### Fix

- Not required icon in *SeniorMenuItemList* component.
- Aligned label and hint text in *SeniorTextField* component.
- Added textInputAction property in *SeniorTextField* component.
- Added onFieldSubmitted property in *SeniorTextField* component.

# 0.10.11

[23/11/2021]

### Feature

- Add title in *SeniorBottomSheet*.

# 0.10.10

[23/11/2021]

### Features

- Updating senior_desing_tokens version.

# 0.10.9

[19/11/2021]

### Fix

 - Padding fix in *SeniorMenuListItem* component.

# 0.10.8

[19/11/2021]

### Features

 - Added *SeniorBottomSheet* component.

# 0.9.8

[11/11/2021]

### Fix

 - Padding fix in *SeniorEvaluation* component.

# 0.9.7

[10/11/2021]

### Fix

 - Fix in *SeniorQuotes* component width.

# 0.9.6

[08/11/2021]

### Fix

 - Reduce radius of *SeniorColorfulHeaderStructure* component.

# 0.9.5

[04/11/2021]

### Fix

 - Size fix from *SeniorBottomNavigationBar* on iOS devices.

# 0.9.4

[01/11/2021]

### Fix

 - Fixed elements color from *SeniorAppBar*.

# 0.9.3

[01/11/2021]

### Fix

 - Fixed the InkWell animation border radius from *SeniorCard*.
 - Fixed the InkWell animation border radius from *SeniorSquareButtonsMenu*.
 - Fixed border from *SeniorTextField*.

# 0.9.2

[29/10/2021]

### Fix

- Animation busy state in *SeniorButton* component.
- Added custom padding in *SeniorSquareButtonMenu*.

# 0.9.1

[29/10/2021]

### Fix

- Added *key* property in *SeniorSquareButtonsMenuItemData* class.

# 0.9.0

[28/10/2021]

### Features

- Added *SeniorTextField.password* component
- Fixed *SquareButtonsMenu* component that was transparent when there was no *Material* on top of it in the tree

# 0.8.5

[28/10/2021]

### Fix

- Added *duration* and *dismissDirection* properties in *SeniorSnackbar* component
- Color adjustment in SeniorMenuItemList component

# 0.8.4

[25/10/2021]

### Fix

- Added disabled state and checkbox in SeniorSquareButtonsMenu component
- Fixed issue that caused SeniorCard component not to execute onTap event
- Setting SeniorCheckbox background color when active

# 0.8.3

[25/10/2021]

### Fix

- Added wave effect to SeniorSquareButtonsMenu and SeniorCard components

# 0.7.3

[22/10/2021]

### Fix

- Removing *scroll* from *SeniorColorfulHeaderStructure*

# 0.7.2

[20/10/2021]

### Fix

- Added *ignoreGestures* in *SeniorRating* component

# 0.7.1

[20/10/2021]

### Fix

- Removed *disabled* parameter on *Chip* component

# 0.7.0

[19/10/2021]

### Features

- Added the following widgets:
    * SeniorProfileRating;

# 0.6.0

[19/10/2021]

### Features

- Added the following widgets:
    * SeniorLoading;
    * SeniorColorfulHeaderStructure;
    * SeniorEvaluation;
    * SeniorMenuListItem;
    * SeniorModal;
    * SeniorSquareButtonsMenu e
    * SeniorQuotes.

# 0.5.0

[13/10/2021]

### Features

- SeniorRating, SeniorCard added.

# 0.4.0

[04/10/2021]

### Features

- Added app with examples.

# 0.3.1

[29/09/2021]

### Features

- Font correction in Senior TextField component.

# 0.3.0

[21/09/2021]

### Features

- Senior Design System SeniorBalance widgtes available.

# 0.2.1

[17/09/2021]

### Features

- Updating senior_desing_tokens version.

# 0.2.0

[08/09/2021]

### Features

- Fixes in the SeniorTextField widget and obscureText property.
- SeniorDropdownButton widget available.
- SeniorExpansionPanelList available.
- SeniorInfoCard available.
- Fixes in the SeniorTopBar widget.
- widget documentation.

# 0.1.0

[09/08/2021]

### Features

- Senior Design System SeniorInfoCard widgtes available.

# 0.0.2

[28/07/2021]

### Features

- Senior Design System SeniorCheckbox, SeniorSwitch, SeniorTextField, SeniorTopBar widgtes available.

# 0.0.1

[14/07/2021]

### Features
- Senior Design System SeniorActionButton, SeniorBottomNavigationBar, SeniorButton, SeniorRadioButton, SeniorTabBar widgtes available.
- Senior Design System SeniorActionButton, SeniorBottomNavigationBar, SeniorButton, SeniorRadioButton, SeniorTabBar widgtes available.
