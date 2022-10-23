import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/data_interfaces/i_user_repository.dart';
import 'package:client/domain/interactors/base_interactor.dart';

class UserInteractor extends BaseInteractor {
  final IUserRepository _userRepository;
  late final User user;

  UserInteractor(this._userRepository);

  Future<void> signup(CreateUserModel entity) async {
    return _userRepository.signupUser(entity);
  }

  Future<bool> login(CreateUserModel entity) async {
    final dbUser = await _userRepository.loginUser(entity);
    if (dbUser != null) {
      user = dbUser;
      return true;
    }
    return false;
  }
}
