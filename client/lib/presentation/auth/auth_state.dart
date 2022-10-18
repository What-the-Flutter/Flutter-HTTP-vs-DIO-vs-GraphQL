enum AuthPageView { login, signup }

class AuthState {
  final bool isButtonActive;
  final AuthPageView pageView;

  AuthState({required this.isButtonActive, required this.pageView});

  AuthState copyWith({bool? isButtonActive, AuthPageView? pageView}) {
    return AuthState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
      pageView: pageView ?? this.pageView,
    );
  }
}
