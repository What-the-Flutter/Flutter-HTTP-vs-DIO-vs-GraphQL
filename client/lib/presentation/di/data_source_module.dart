import 'package:client/data/data_sources/crud/dio_crud.dart';
import 'package:client/data/data_sources/graphql_remote_data_source.dart';
import 'package:client/data/data_sources/crud/http_crud.dart';
import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/data/data_sources/rest_remote_data_source.dart';
import 'package:client/domain/constants/connectivity_constants.dart';

import 'injector.dart';

void initDataSourceModule() {
  final IRemoteDataSource remoteDataSource;
  if (ConnectivityStrings.networkModule == NetworkModule.dio.name) {
    remoteDataSource = RestRemoteDataSource(DioCrud());
  } else if (ConnectivityStrings.networkModule == NetworkModule.http.name) {
    remoteDataSource = RestRemoteDataSource(HttpCrud());
  } else if (ConnectivityStrings.networkModule == NetworkModule.graphql.name) {
    remoteDataSource = GraphqlRemoteDataSource();
  } else {
    throw Exception('Wrong network module');
  }
  i.registerSingleton<IRemoteDataSource>(remoteDataSource);
}
