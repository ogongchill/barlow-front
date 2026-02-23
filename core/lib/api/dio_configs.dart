const String _apiHost = String.fromEnvironment(
  'API_HOST',
  defaultValue: 'http://barlow-api.site:8080/',
);

class DioConfig {

  final String hostUrl;
  final Duration connectionTimeOut;
  final Duration receiveTimeOut;

  DioConfig({
    required this.hostUrl,
    required this.connectionTimeOut,
    required this.receiveTimeOut
  });
}

final DioConfig apiServerConfig = DioConfig(
    hostUrl: _apiHost,
    connectionTimeOut: const Duration(seconds: 10),
    receiveTimeOut: const Duration(seconds: 10)
);
