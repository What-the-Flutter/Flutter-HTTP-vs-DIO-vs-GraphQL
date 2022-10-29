import 'package:client/presentation/base/base_state.dart';

class PostConstructorState extends BaseState {
  final bool isButtonActive;

  PostConstructorState({required this.isButtonActive});

  PostConstructorState copyWith({bool? isButtonActive}) {
    return PostConstructorState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
    );
  }
}
