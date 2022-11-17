abstract class ConnectivityStrings {
  static const networkModule = String.fromEnvironment(
    'NETWORK_MODULE',
    defaultValue: 'http',
  );
  static const _baseDomain = '10.10.28.55';
  static final int _port = networkModule == NetworkModule.graphql.name ? 5000 : 5001;
  static final String _domain = networkModule == NetworkModule.graphql.name ? 'graphql' : 'api';
  static final String baseUrl = 'http://$_baseDomain:$_port/$_domain';
}

enum NetworkModule {
  http,
  dio,
  graphql,
}
