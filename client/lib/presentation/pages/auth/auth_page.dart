import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:client/presentation/app/theme/base_color_canstatns.dart';
import 'package:client/presentation/pages/auth/auth_state.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'auth_provider.dart';
import 'package:client/presentation/widgets/text_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPageWidget extends ConsumerStatefulWidget {
  const AuthPageWidget({super.key});

  @override
  ConsumerState<AuthPageWidget> createState() => AuthPageWidgetState();
}

class AuthPageWidgetState extends ConsumerState<AuthPageWidget> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.authenticationPageName(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _errorMessage(),
            _usernameField(),
            _passwordField(),
            _confirmationButton(),
            _switchPageViewButton(),
          ],
        ),
      ),
    );
  }

  Widget _errorMessage() {
    final state = ref.watch(authProvider);
    if (state.showErrorMessage) {
      return Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
        child: Text(
          state.pageView == AuthPageView.login
              ? AppStrings.wrongAuthFields(context)
              : AppStrings.wrongLoginFields(context),
          style: TextStyle(
            color: BaseColors.textColorError,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _usernameField() {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: AppStrings.name(context),
        ),
        onChanged: (text) => ref.read(authProvider.notifier).setButtonActive(
              text,
              _passwordTextController.value.text,
            ),
        controller: _usernameTextController,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: AppStrings.password(context),
        ),
        onChanged: (text) => ref.read(authProvider.notifier).setButtonActive(
              _usernameTextController.value.text,
              text,
            ),
        controller: _passwordTextController,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _confirmationButton() {
    final state = ref.watch(authProvider);
    switch (state.pageView) {
      case AuthPageView.login:
        return NetworkingTextButton(
          isButtonActive: state.isButtonActive,
          buttonText: AppStrings.login(context),
          onClick: onLoginClick,
        );
      case AuthPageView.signup:
        return NetworkingTextButton(
          isButtonActive: state.isButtonActive,
          buttonText: AppStrings.signUp(context),
          onClick: onSignupClick,
        );
      default:
        return Container();
    }
  }

  void onLoginClick() {
    _usernameTextController.clear();
    _passwordTextController.clear();
    FocusScope.of(context).unfocus();
    ref.read(authProvider.notifier).login(
          username: _usernameTextController.value.text,
          password: _passwordTextController.value.text,
          onError: () => showInfoDialog(
            context: context,
            title: AppStrings.authError(context),
            content: AppStrings.authLoginErrorDescription(context),
            onButtonClick: ref.read(authProvider.notifier).pop,
          ),
        );
  }

  void onSignupClick() {
    _usernameTextController.clear();
    _passwordTextController.clear();
    FocusScope.of(context).unfocus();
    ref.read(authProvider.notifier).signup(
          username: _usernameTextController.value.text,
          password: _passwordTextController.value.text,
          onSuccess: () => showInfoDialog(
            context: context,
            title: AppStrings.successfulSignUp(context),
            content: AppStrings.successfulSignUpDescription(context),
            onButtonClick: ref.read(authProvider.notifier).pop,
          ),
          onError: () => showInfoDialog(
            context: context,
            title: AppStrings.authError(context),
            content: AppStrings.authSignupErrorDescription(context),
            onButtonClick: ref.read(authProvider.notifier).pop,
          ),
        );
  }

  Widget _switchPageViewButton() {
    final pageView = ref.watch(authProvider).pageView;
    switch (pageView) {
      case AuthPageView.login:
        return Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
          child: GestureDetector(
            onTap: () => ref.read(authProvider.notifier).switchPageView(AuthPageView.signup),
            child: Text(
              AppStrings.userHasNoAccount(context),
              style: TextStyle(
                color: BaseColors.textColorDark,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );
      case AuthPageView.signup:
        return Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
          child: GestureDetector(
            onTap: () => ref.read(authProvider.notifier).switchPageView(AuthPageView.login),
            child: Text(
              AppStrings.userHasAccount(context),
              style: TextStyle(
                color: BaseColors.textColorDark,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
