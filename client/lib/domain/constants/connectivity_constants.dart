abstract class ConnectivityStrings {
  static const networkModule = String.fromEnvironment(
    'NETWORK_MODULE',
    defaultValue: 'http',
  );
  static const _baseDomain = 'localhost';
  static late int _port;
  static late String _domain;

  static String get baseUrl {
    if (networkModule == NetworkModule.http.name || networkModule == NetworkModule.dio.name) {
      _port = 5001;
      _domain = 'api';
    } else if (networkModule == NetworkModule.graphql.name) {
      _port = 5000;
      _domain = 'graphql';
    }
    return 'http://$_baseDomain:$_port/$_domain';
  }
}

enum NetworkModule {
  http,
  dio,
  graphql,
}
