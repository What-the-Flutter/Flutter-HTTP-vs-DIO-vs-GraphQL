import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/data_interfaces/i_user_repository.dart';
import 'package:client/domain/interactors/base_interactor.dart';

class UserInteractor extends BaseInteractor {
  final IUserRepository _userRepository;

  UserInteractor(this._userRepository);

  User get user => _userRepository.user;

  Future<void> signup(User entity) async {
    return _userRepository.signupUser(entity);
  }

  Future<void> login(User entity) async {
    return _userRepository.loginUser(entity);
  }
}
