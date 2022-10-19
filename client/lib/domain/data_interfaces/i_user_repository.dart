import 'package:client/domain/entities/user/user.dart';
import 'entity_repository.dart';

abstract class IUserRepository implements EntityRepository<User> {
  Future<void> signupUser(User user);
  Future<User?> loginUser(String userName, String password);
}