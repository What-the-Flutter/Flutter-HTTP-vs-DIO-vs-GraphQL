class AddPageState {
  final bool isButtonActive;

  AddPageState({required this.isButtonActive});

  AddPageState copyWith({bool? isButtonActive}) {
    return AddPageState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
    );
  }
}
