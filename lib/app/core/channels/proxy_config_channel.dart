import 'package:flutter/services.dart';

class ProxyConfigChannel {
  const ProxyConfigChannel(this._channel);
  static const channelName = 'br.com.senior.employee/proxy';
  static const _getProxyConfig = 'getProxyConfig';
  final MethodChannel _channel;

  Future<String?> getProxyConfig() => _channel.invokeMethod(_getProxyConfig);
}
