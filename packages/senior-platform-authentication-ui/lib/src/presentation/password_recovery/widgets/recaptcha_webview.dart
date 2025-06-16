import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../cubit/password_recovery_cubit.dart';

class RecaptchaWebView extends StatefulWidget {
  final String recaptchaUrl;
  final String customRecaptchaSiteKey;
  const RecaptchaWebView({
    super.key,
    required this.recaptchaUrl,
    required this.customRecaptchaSiteKey,
  });

  @override
  State<RecaptchaWebView> createState() => _RecaptchaWebViewState();
}

class _RecaptchaWebViewState extends State<RecaptchaWebView> {
  late final WebViewController _webViewController;
  late final WebViewCookieManager _cookieManager;
  double progress = 0;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

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
          onProgress: (int progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
      )
      ..addJavaScriptChannel(
        'JavaScriptMessenger',
        onMessageReceived: (JavaScriptMessage message) {
          if (context.mounted) {
            context
                .read<PasswordRecoveryCubit>()
                .onJavaScriptMessage(message.message);
          }
        },
      )
      ..loadRequest(Uri.parse(
          '${widget.recaptchaUrl}${widget.customRecaptchaSiteKey.isNotEmpty ? '?siteKey=${widget.customRecaptchaSiteKey}' : ''}'));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screenHeight / 1.5),
      child: Visibility(
        visible: progress >= 1.0,
        replacement: const Center(
          child: SeniorLoading(),
        ),
        child: WebViewWidget(
          controller: _webViewController,
          gestureRecognizers: gestureRecognizers,
        ),
      ),
    );
  }
}
