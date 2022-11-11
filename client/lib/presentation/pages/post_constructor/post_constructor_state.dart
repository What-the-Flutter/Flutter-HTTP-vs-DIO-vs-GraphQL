import 'package:client/presentation/base/base_state.dart';

class PostConstructorState extends BaseState {
  final bool isButtonActive;
  final bool showServerErrorMessage;

  PostConstructorState({required this.showServerErrorMessage, required this.isButtonActive});

  PostConstructorState copyWith({bool? isButtonActive, bool? showServerErrorMessage}) {
    return PostConstructorState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
      showServerErrorMessage: showServerErrorMessage ?? this.showServerErrorMessage,
    );
  }
}
