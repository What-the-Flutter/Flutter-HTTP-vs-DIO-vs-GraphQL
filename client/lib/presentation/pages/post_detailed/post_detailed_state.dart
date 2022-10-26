import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/presentation/base/base_state.dart';

class PostDetailedState extends BaseState {
  final bool isButtonActive;
  final List<Comment> comments;

  PostDetailedState({required this.isButtonActive, required this.comments});

  PostDetailedState copyWith({
    bool? isButtonActive,
    List<Comment>? comments,
  }) {
    return PostDetailedState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
      comments: comments ?? this.comments,
    );
  }
}
