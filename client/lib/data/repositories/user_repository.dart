import 'package:client/data/repositories/base_repository.dart';
import 'package:client/domain/data_interfaces/i_user_repository.dart';
import 'package:client/domain/entities/user/user.dart';

class UserRepository extends BaseRepository implements IUserRepository {
  @override
  late final User user;

  UserRepository(super.remoteDataSource);

  @override
  Future<void> loginUser(_) async => user = await remoteDataSource.loginUser(_);

  @override
  Future<void> signupUser(_) async => await remoteDataSource.createUser(_);
}
