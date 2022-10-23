import 'auth_provider.dart';
import 'auth_state.dart';
import 'package:client/presentation/widgets/text_button.dart';
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
        title: const Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usernameField(),
            _passwordField(),
            _confirmationButton(),
            _switchPageViewButton(),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
      child: TextField(
        decoration: const InputDecoration.collapsed(hintText: 'Name'),
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
        decoration: const InputDecoration.collapsed(hintText: 'Password'),
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
          buttonText: 'Login',
          onClick: () => Navigator.pushNamed(context, '/posts'),
        );
      case AuthPageView.signup:
        return NetworkingTextButton(
          isButtonActive: state.isButtonActive,
          buttonText: 'SignUp',
          onClick: () {},
        );
      default:
        return Container();
    }
  }

  Widget _switchPageViewButton() {
    final pageView = ref.watch(authProvider).pageView;
    switch (pageView) {
      case AuthPageView.login:
        return Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
          child: GestureDetector(
            onTap: () => ref
                .read(authProvider.notifier)
                .switchPageView(AuthPageView.signup),
            child: const Text(
              'I don`t have an account',
              style: TextStyle(
                color: Colors.black26,
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
            onTap: () => ref
                .read(authProvider.notifier)
                .switchPageView(AuthPageView.login),
            child: const Text(
              'I already have an account',
              style: TextStyle(
                color: Colors.black26,
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
