import 'package:client/data/repositories/base_repository.dart';
import 'package:client/domain/data_interfaces/i_user_repository.dart';
import 'package:client/domain/entities/user/user.dart';

class UserRepository extends BaseRepository implements IUserRepository {
  UserRepository(super.remoteDataSource);

  @override
  Future<User> loginUser(User user) async {
    return await remoteDataSource.loginUser(user);
  }

  @override
  Future<void> signupUser(User user) async {
    return await remoteDataSource.createUser(user);
  }
}
