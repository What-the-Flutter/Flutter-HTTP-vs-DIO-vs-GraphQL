import 'package:client/data/utils/remote_utils.dart';
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
  static final _initialState = AuthState(
    isButtonActive: false,
    pageView: AuthPageView.login,
    showErrorMessage: false,
  );

  late final UserInteractor _userInteractor;

  AuthStateNotifier() : super(_initialState) {
    _userInteractor = i.get();
  }

  Future<void> signup({
    required String username,
    required String password,
    required Function onSuccess,
    required Function onError,
  }) async {
    final user = User(
      id: '0',
      name: username,
      password: password,
    );
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
      errorHandler: (e) {
        if (e is WrongUserDataException) {
          state = state.copyWith(showErrorMessage: true);
        } else {
          onError();
        }
      },
    );
  }

  Future<void> login({
    required String username,
    required String password,
    required Function onError,
  }) async {
    final user = User(
      id: '0',
      name: username,
      password: password,
    );
    return launchRetrieveResult(
      () async {
        await _userInteractor.login(user);
        appRouter.replaceNamed(Routes.home);
      },
      errorHandler: (e) {
        if (e is WrongUserDataException) {
          state = state.copyWith(showErrorMessage: true);
        } else {
          onError();
        }
      },
    );
  }

  void switchPageView(AuthPageView newView) => state = state.copyWith(
        pageView: newView,
        showErrorMessage: false,
      );

  void setButtonActive(String username, String password) =>
      state = state.copyWith(isButtonActive: username.isNotEmpty && password.isNotEmpty);
}
