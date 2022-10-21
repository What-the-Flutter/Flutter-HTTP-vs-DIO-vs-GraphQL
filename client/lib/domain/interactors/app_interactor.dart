import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/domain/interactors/base_interactor.dart';

class AppInteractor extends BaseInteractor {
  final IRemoteDataSource _remoteDataSource;

  AppInteractor(this._remoteDataSource);
}
