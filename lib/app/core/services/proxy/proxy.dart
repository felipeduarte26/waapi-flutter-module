import 'dart:io';

class MyProxyHttpOverride extends HttpOverrides {
  MyProxyHttpOverride(this.proxy);
  final String proxy;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..findProxy = (uri) {
        return 'PROXY $proxy;';
      }
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
