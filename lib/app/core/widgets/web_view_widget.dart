import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../enums/analytics/waapi_loading_size_enum.dart';
import '../extension/media_query_extension.dart';
import 'waapi_loading_widget.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  final String onLoadErrorMessage;
  final bool showWebViewNavigationBar;

  const WebViewWidget({
    Key? key,
    required this.url,
    required this.onLoadErrorMessage,
    this.showWebViewNavigationBar = true,
  }) : super(key: key);

  @override
  State<WebViewWidget> createState() {
    return _WebViewWidgetState();
  }
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final GlobalKey _webViewKey = GlobalKey();
  final CookieManager _cookieManager = CookieManager.instance();
  final authenticationBloc = Modular.get<AuthenticationBloc>();

  InAppWebViewController? _webViewController;
  Token? token;

  var canGoBack = false;
  var canGoForward = false;
  var loadCompleted = false;
  var firstLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      token = authenticationBloc.state.token;
      if (token != null) {
        setCookies(token);
      }
    });
  }

  String get _getFormattedUri =>
      widget.url.contains('?') ? '${widget.url}&fromAppInBrowser=true' : '${widget.url}?fromAppInBrowser=true';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
          offstage: firstLoading,
          child: Column(
            children: [
              widget.showWebViewNavigationBar
                  ? _WebViewNavigationBar(
                      webViewController: _webViewController,
                      loadCompleted: loadCompleted,
                      canGoBack: canGoBack,
                      canGoForward: canGoForward,
                    )
                  : const SizedBox(),
              Expanded(
                child: InAppWebView(
                  key: _webViewKey,
                  initialUrlRequest: URLRequest(url: WebUri(_getFormattedUri)),
                  onWebViewCreated: _onWebViewCreated,
                  onProgressChanged: onProgressChanged,
                  onLoadStop: _onLoadStop,
                  onLoadError: _onLoadError,
                  onLoadHttpError: _onLoadError,
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                      mediaPlaybackRequiresUserGesture: false,
                      javaScriptEnabled: true,
                      useOnDownloadStart: true,
                      clearCache: true,
                    ),
                    android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                      loadWithOverviewMode: true,
                      useWideViewPort: false,
                      builtInZoomControls: false,
                      domStorageEnabled: true,
                      supportMultipleWindows: true,
                      disableDefaultErrorPage: true,
                    ),
                  ),
                  shouldOverrideUrlLoading: (controller, action) async {
                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              ),
            ],
          ),
        ),
        Offstage(
          offstage: !firstLoading,
          child: const WaapiLoadingWidget(),
        ),
      ],
    );
  }

  void _onWebViewCreated(controller) {
    _webViewController = controller;
  }

  Future<void> setCookies(Token? token) async {
    final seniorTokenCookie = {
      'expires_in': token?.expiresIn ?? '',
      'username': token?.username ?? '',
      'token_type': 'bearer',
      'access_token': token?.accessToken ?? '',
      'refresh_token': token?.refreshToken ?? '',
      'type': 'internal',
      'email': token?.email ?? '',
    };

    await _cookieManager.setCookie(
      url: WebUri(widget.url),
      name: 'com.senior.token',
      value: jsonEncode(seniorTokenCookie),
    );
  }

  void onProgressChanged(_, progress) {
    setState(() {
      loadCompleted = progress == 100;
    });
  }

  void _onLoadStop(controller, __) {
    controller.canGoBack().then(
      (value) {
        setState(() {
          canGoBack = value;
          if (firstLoading) {
            firstLoading = false;
          }
        });
      },
    );

    controller.canGoForward().then(
      (value) {
        setState(() {
          canGoForward = value;
        });
      },
    );

    if (!widget.showWebViewNavigationBar) {
      String script = """
                document.querySelector('#declineSignButton').remove();
              """;
      controller?.evaluateJavascript(source: script);
    }
  }

  void _onLoadError(_, __, ___, ____) {
    ScaffoldMessenger.of(context).showSnackBar(
      SeniorSnackBar.error(
        message: widget.onLoadErrorMessage,
      ),
    );
  }
}

class _WebViewNavigationBar extends StatelessWidget {
  final InAppWebViewController? _webViewController;
  final bool _loadCompleted;
  final bool _canGoBack;
  final bool _canGoForward;

  const _WebViewNavigationBar({
    Key? key,
    InAppWebViewController? webViewController,
    bool loadCompleted = false,
    bool canGoBack = false,
    bool canGoForward = false,
  })  : _webViewController = webViewController,
        _loadCompleted = loadCompleted,
        _canGoBack = canGoBack,
        _canGoForward = canGoForward,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return Container(
      height: SeniorSpacing.huge,
      color: Colors.transparent,
      child: Visibility(
        visible: _loadCompleted,
        replacement: AnimatedContainer(
          duration: kThemeAnimationDuration,
          height: SeniorIconSize.medium * 2,
          width: context.widthSize,
          child: const Center(
            child: SizedBox(
              child: WaapiLoadingWidget(
                waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
              ),
            ),
          ),
        ),
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.xsmall,
          ),
          child: OverflowBar(
            alignment: MainAxisAlignment.center,
            overflowSpacing: 0,
            children: <Widget>[
              IconButton(
                icon: SeniorIcon(
                  icon: FontAwesomeIcons.arrowLeft,
                  style: SeniorIconStyle(
                    color: _canGoBack ? themeRepository.theme.primaryColor : SeniorColors.secondaryColor500,
                  ),
                  size: SeniorIconSize.medium,
                ),
                onPressed: _canGoBack ? _goBack : null,
              ),
              IconButton(
                icon: SeniorIcon(
                  icon: FontAwesomeIcons.arrowRotateRight,
                  size: SeniorIconSize.medium,
                  style: themeRepository.isCustomTheme()
                      ? SeniorIconStyle(
                          color: SeniorServiceColor.getContrastAdjustedColorTheme(
                            color: themeRepository.theme.primaryColor!,
                          ),
                        )
                      : null,
                ),
                onPressed: _reloadPage,
              ),
              IconButton(
                icon: SeniorIcon(
                  icon: FontAwesomeIcons.arrowRight,
                  style: SeniorIconStyle(
                    color: _canGoForward ? themeRepository.theme.primaryColor : SeniorColors.secondaryColor500,
                  ),
                  size: SeniorIconSize.medium,
                ),
                onPressed: _canGoForward ? _goForward : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goForward() {
    _webViewController?.goForward();
  }

  void _reloadPage() {
    _webViewController?.reload();
  }

  void _goBack() {
    _webViewController?.goBack();
  }
}
