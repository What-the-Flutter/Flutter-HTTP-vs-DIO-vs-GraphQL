import 'package:client/domain/entities/user/user.dart';

abstract class IUserRepository {
  late final User user;
  Future<void> signupUser(User user);
  Future<void> loginUser(User user);
}
