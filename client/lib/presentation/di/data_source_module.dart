import 'package:client/data/data_sources/dio/dio_rest_remote_data_source.dart';
import 'package:client/data/data_sources/graphql/graphql_remote_data_source.dart';
import 'package:client/data/data_sources/http/http_rest_remote_data_source.dart';
import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/domain/constants/connectivity_constants.dart';

import 'injector.dart';

void initDataSourceModule() {
  final IRemoteDataSource remoteDataSource;
  if (ConnectivityStrings.networkModule == NetworkModule.dio.name) {
    remoteDataSource = DioRestRemoteDataSource();
  } else if (ConnectivityStrings.networkModule == NetworkModule.http.name) {
    remoteDataSource = HttpRestRemoteDataSource();
  } else if (ConnectivityStrings.networkModule == NetworkModule.graphql.name) {
    remoteDataSource = GraphqlRemoteDataSource();
  } else {
    throw Exception('Wrong network module');
  }
  i.registerSingleton<IRemoteDataSource>(remoteDataSource);
}
