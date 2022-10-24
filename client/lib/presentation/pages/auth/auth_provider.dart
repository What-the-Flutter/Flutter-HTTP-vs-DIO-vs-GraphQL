import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/interactors/user_interactor.dart';
import 'package:client/presentation/app/navigation/route_constants.dart';
import 'package:client/presentation/base/base_state_notifier.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:client/presentation/pages/auth/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});

class AuthStateNotifier extends BaseStateNotifier<AuthState> {
  late final UserInteractor _userInteractor;

  AuthStateNotifier()
      : super(
          AuthState(
            isButtonActive: false,
            pageView: AuthPageView.login,
            showErrorMessage: false,
          ),
        ) {
    //_userInteractor = i.get();
  }

  Future<void> signup({
    required String username,
    required String password,
    required Function onSuccess,
  }) async {
    final user = CreateUserModel(name: username, password: password);
    return launchRetrieveResult(
      () async {
        await _userInteractor.signup(user);
        state = state.copyWith(
          showErrorMessage: false,
          isButtonActive: false,
          pageView: AuthPageView.login,
        );
        onSuccess();
      },
      errorHandler: () => state = state.copyWith(showErrorMessage: true),
    );
  }

  Future<void> login({required String username, required String password}) async {
    final user = CreateUserModel(name: username, password: password);
    return launchRetrieveResult(
      () async {
        await _userInteractor.login(user);
        appRouter.replaceNamed(Routes.post);
      },
      errorHandler: (_) => state = state.copyWith(showErrorMessage: true),
    );
  }

  void switchPageView(AuthPageView newView) => state = state.copyWith(pageView: newView);

  void setButtonActive(String username, String password) =>
      state = state.copyWith(isButtonActive: username.isNotEmpty && password.isNotEmpty);
}