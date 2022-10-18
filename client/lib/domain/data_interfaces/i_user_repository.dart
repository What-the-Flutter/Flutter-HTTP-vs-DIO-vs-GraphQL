import 'package:client/domain/entities/user/user.dart';
import 'entity_repository.dart';

abstract class IUserRepository implements EntityRepository<User> {
  Future<User> create(User user);
}