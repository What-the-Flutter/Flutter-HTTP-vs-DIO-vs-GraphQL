import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/domain/data_interfaces/i_user_repository.dart';
import 'package:client/domain/entities/user/user.dart';

class UserRepository implements IUserRepository {
  final IRemoteDataSource _remoteDataSource;

  UserRepository(this._remoteDataSource);

  @override
  Future<User> loginUser(User user) async {
    return await _remoteDataSource.loginUser(user);
  }

  @override
  Future<void> signupUser(User user) async {
    return await _remoteDataSource.createUser(user);
  }
}
