import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../cubit/saml_authentication_cubit.dart';

class SAMLAuthenticationWebview extends StatefulWidget {
  final String tenantDomain;
  final String? username;
  const SAMLAuthenticationWebview({
    super.key,
    required this.tenantDomain,
    required this.username,
  });

  @override
  State<SAMLAuthenticationWebview> createState() =>
      SAMLAuthenticationWebviewState();
}

class SAMLAuthenticationWebviewState extends State<SAMLAuthenticationWebview> {
  late final WebViewController _webViewController;
  late final WebViewCookieManager _cookieManager;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    _cookieManager = WebViewCookieManager();
    _cookieManager.clearCookies();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..clearCache()
      ..clearLocalStorage()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            log('>>>>> PAGE STARTED ==> $url');
          },
          onPageFinished: (String url) {
            log('>>>>> PAGE FINISHED ==> $url');
            checkForSeniorXCookies();
            if (widget.username != null && widget.username!.isNotEmpty) {
              final emailScript = '''
                    var email = document.getElementById('userNameInput');
                    if (email) {
                      email.value = '${widget.username}';
                    }
                  ''';
              _webViewController.runJavaScript(emailScript);
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // Blocking any navigation to prevent Senior X loads
            return request.url
                    .startsWith('https://platform.senior.com.br/senior-x/#/')
                ? NavigationDecision.prevent
                : NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://platform.senior.com.br/login/'
          '?redirectTo=https://platform.senior.com.br'
          '&tenant=${widget.tenantDomain}'
          '&check-browser-compatibility=false'
          '&saml=true'));

    // Precisa buscar os cookies via timer, porque o AD faz vários
    // redirecionamentos e não da tempo de pegar o token antes dele
    // redirecionar a tela novamente. O problema é mais perceptível no iOS.
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      checkForSeniorXCookies();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController,
    );
  }

  bool stopCheck = false;

  void checkForSeniorXCookies() async {
    // Condição para evitar chamar o context após a tela ser destruída.
    if (stopCheck) {
      return;
    }

    final cookies = await _webViewController
        .runJavaScriptReturningResult('document.cookie');

    if (mounted) {
      final success =
          context.read<SAMLAuthenticationCubit>().verifySeniorXCookies(cookies);
      setState(() {
        stopCheck = success;
      });
    }
  }
}
