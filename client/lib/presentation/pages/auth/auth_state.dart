import 'package:client/presentation/base/base_state.dart';

enum AuthPageView { login, signup }

class AuthState extends BaseState {
  final bool isButtonActive;
  final bool showErrorMessage;
  final AuthPageView pageView;
  final bool showServerErrorMessage;

  AuthState({
    required this.isButtonActive,
    required this.pageView,
    required this.showErrorMessage,
    required this.showServerErrorMessage,
  });

  AuthState copyWith({
    bool? isButtonActive,
    AuthPageView? pageView,
    bool? showErrorMessage,
    bool? showServerErrorMessage,
  }) {
    return AuthState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
      pageView: pageView ?? this.pageView,
      showErrorMessage: showErrorMessage ?? this.showErrorMessage,
      showServerErrorMessage: showServerErrorMessage ?? this.showServerErrorMessage,
    );
  }
}
