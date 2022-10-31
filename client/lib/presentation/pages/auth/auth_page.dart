import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:client/presentation/app/theme/base_color_constants.dart';
import 'package:client/presentation/pages/auth/auth_state.dart';
import 'package:client/presentation/pages/auth/widgets/auth_background.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _usernameTextController = Provider((ref) => TextEditingController());
final _passwordTextController = Provider((ref) => TextEditingController());

class AuthPageWidget extends StatelessWidget {
  const AuthPageWidget({super.key});

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
    return Consumer(
      builder: (context, ref, _) {
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
      },
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
    return Consumer(
      builder: (context, ref, child) {
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
      },
    );
  }

  Widget _usernameField() {
    return Consumer(
      builder: (context, ref, child) {
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
                  ref.read(_passwordTextController).value.text,
                ),
            controller: ref.read(_usernameTextController),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          margin: const EdgeInsets.only(left: 16, right: 32),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: const Icon(Icons.lock),
              hintText: AppStrings.password(context),
            ),
            onChanged: (text) => ref.read(authProvider.notifier).setButtonActive(
                  ref.read(_usernameTextController).value.text,
                  text,
                ),
            controller: ref.read(_passwordTextController),
          ),
        );
      },
    );
  }

  Widget _confirmationButton() {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(authProvider);
        return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (state.isButtonActive) {
                switch (state.pageView) {
                  case AuthPageView.login:
                    return onLoginClick(ref, context);
                  case AuthPageView.signup:
                    return onSignupClick(ref, context);
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
                color: state.isButtonActive
                    ? BaseColors.buttonColorActive
                    : BaseColors.borderColorBlocked,
              ),
              child: Icon(
                Icons.arrow_forward_outlined,
                color: BaseColors.iconColorLight,
                size: 32,
              ),
            ),
          ),
        );
      },
    );
  }

  void onLoginClick(WidgetRef ref, BuildContext context) {
    FocusScope.of(context).unfocus();
    ref.read(authProvider.notifier).login(
          username: ref.read(_usernameTextController).value.text,
          password: ref.read(_passwordTextController).value.text,
          onError: () => _showErrorDialog(ref, context),
        );
    ref.read(_usernameTextController).clear();
    ref.read(_passwordTextController).clear();
  }

  void onSignupClick(WidgetRef ref, BuildContext context) {
    FocusScope.of(context).unfocus();
    ref.read(authProvider.notifier).signup(
          username: ref.read(_usernameTextController).value.text,
          password: ref.read(_passwordTextController).value.text,
          onSuccess: () => showInfoDialog(
            context: context,
            title: AppStrings.successfulSignUp(context),
            content: AppStrings.successfulSignUpDescription(context),
            onButtonClick: ref.read(authProvider.notifier).pop,
          ),
          onError: () => _showErrorDialog(ref, context),
        );
    ref.read(_usernameTextController).clear();
    ref.read(_passwordTextController).clear();
  }

  Widget _switchPageViewButton() {
    return Consumer(
      builder: (context, ref, child) {
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
      },
    );
  }

  void _showErrorDialog(WidgetRef ref, BuildContext context) {
    showInfoDialog(
      context: context,
      title: AppStrings.authError(context),
      content: AppStrings.serverErrorDescription(context),
      onButtonClick: ref.read(authProvider.notifier).pop,
    );
  }
}
