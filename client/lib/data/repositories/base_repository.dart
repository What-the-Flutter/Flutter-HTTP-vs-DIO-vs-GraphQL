import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:flutter/foundation.dart';

class BaseRepository {
  @protected
  final IRemoteDataSource remoteDataSource;

  BaseRepository(this.remoteDataSource);
}