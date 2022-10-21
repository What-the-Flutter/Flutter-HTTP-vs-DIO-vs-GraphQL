import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/interactors/user_interactor.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  //TODO: implement error handling

  late final UserInteractor _userInteractor;

  AuthStateNotifier()
      : super(
          AuthState(
            isButtonActive: false,
            pageView: AuthPageView.login,
          ),
        ) {
    //_userInteractor = i.get();
  }

  Future<void> signup(String username, String password) async {
    final user = CreateUserModel(name: username, password: password);
    return _userInteractor.signup(user);
  }

  Future<bool> login(String username, String password) async {
    final user = CreateUserModel(name: username, password: password);
    return _userInteractor.login(user);
  }

  void switchPageView(AuthPageView newView) =>
      state = state.copyWith(pageView: newView);

  void setButtonActive(String username, String password) => state = state
      .copyWith(isButtonActive: username.isNotEmpty && password.isNotEmpty);
}
