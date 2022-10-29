import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:client/presentation/app/theme/base_color_constants.dart';
import 'package:client/presentation/pages/auth/auth_state.dart';
import 'package:client/presentation/pages/auth/widgets/auth_background.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPageWidget extends ConsumerStatefulWidget {
  const AuthPageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthPageWidget> createState() => AuthPageWidgetState();
}

class AuthPageWidgetState extends ConsumerState<AuthPageWidget> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _appLogo(size),
              _authStateString(),
              _errorMessage(),
              SizedBox(
                height: size.height / 6,
                child: Stack(
                  children: [
                    _authInputsContainer(),
                    _confirmationButton(),
                  ],
                ),
              ),
              _switchPageViewButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appLogo(Size size) {
    return Container(
      margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
      child: FlutterLogo(
        size: size.height / 8,
        style: FlutterLogoStyle.markOnly,
      ),
    );
  }

  Widget _authStateString() {
    final state = ref.watch(authProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 32.0, bottom: 24),
          child: Text(
            state.pageView.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: BaseColors.textColorCustom,
            ),
          ),
        ),
      ],
    );
  }

  Widget _authInputsContainer() {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(
        right: 70,
      ),
      decoration: BoxDecoration(
        color: BaseColors.backgroundColorLight,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
        boxShadow: [
          BoxShadow(
            color: BaseColors.shadowColor.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _usernameField(),
          _passwordField(),
        ],
      ),
    );
  }

  Widget _errorMessage() {
    final state = ref.watch(authProvider);
    if (state.showErrorMessage) {
      return Container(
        margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
        child: Text(
          state.pageView == AuthPageView.login
              ? AppStrings.wrongAuthFields(context)
              : AppStrings.wrongLoginFields(context),
          style: TextStyle(
            color: BaseColors.textColorError,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _usernameField() {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 32.0),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(Icons.account_circle_rounded),
          hintText: AppStrings.name(context),
        ),
        onChanged: (text) => ref.read(authProvider.notifier).setButtonActive(
              text,
              _passwordTextController.value.text,
            ),
        controller: _usernameTextController,
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 32),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(Icons.lock),
          hintText: AppStrings.password(context),
        ),
        onChanged: (text) => ref.read(authProvider.notifier).setButtonActive(
              _usernameTextController.value.text,
              text,
            ),
        controller: _passwordTextController,
      ),
    );
  }

  Widget _confirmationButton() {
    final state = ref.watch(authProvider);
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          if (state.isButtonActive) {
            switch (state.pageView) {
              case AuthPageView.login:
                return onLoginClick();
              case AuthPageView.signup:
                return onSignupClick();
              default:
                return;
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 24.0),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: BaseColors.backgroundColor.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            shape: BoxShape.circle,
            color:
                state.isButtonActive ? BaseColors.buttonColorActive : BaseColors.borderColorBlocked,
          ),
          child: Icon(
            Icons.arrow_forward_outlined,
            color: BaseColors.iconColorLight,
            size: 32,
          ),
        ),
      ),
    );
  }

  void onLoginClick() {
    FocusScope.of(context).unfocus();
    ref.read(authProvider.notifier).login(
          username: _usernameTextController.value.text,
          password: _passwordTextController.value.text,
          onError: _showErrorDialog,
        );
    _usernameTextController.clear();
    _passwordTextController.clear();
  }

  void onSignupClick() {
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
          onError: _showErrorDialog,
        );
    _usernameTextController.clear();
    _passwordTextController.clear();
  }

  Widget _switchPageViewButton() {
    final pageView = ref.watch(authProvider).pageView;
    switch (pageView) {
      case AuthPageView.login:
        return GestureDetector(
          onTap: () => ref.read(authProvider.notifier).switchPageView(AuthPageView.signup),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, top: 24),
                child: Text(
                  AppStrings.userHasNoAccount(context),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: BaseColors.textColorSwitch,
                  ),
                ),
              ),
            ],
          ),
        );
      case AuthPageView.signup:
        return GestureDetector(
          onTap: () => ref.read(authProvider.notifier).switchPageView(AuthPageView.login),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, top: 24),
                child: Text(
                  AppStrings.userHasAccount(context),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: BaseColors.textColorSwitch,
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  void _showErrorDialog() {
    showInfoDialog(
      context: context,
      title: AppStrings.authError(context),
      content: AppStrings.serverErrorDescription(context),
      onButtonClick: ref.read(authProvider.notifier).pop,
    );
  }
}
