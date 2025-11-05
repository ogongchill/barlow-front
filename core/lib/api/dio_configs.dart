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

final DioConfig testServerConfig = DioConfig(
    hostUrl: 'http://barlow-api.site:8080/',
    connectionTimeOut: const Duration(seconds: 10),
    receiveTimeOut: const Duration(seconds: 10)
);
