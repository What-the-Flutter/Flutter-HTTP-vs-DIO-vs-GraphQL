import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/presentation/base/base_state.dart';

enum CommentActions {
  create,
  edit,
}

class PostDetailedState extends BaseState {
  final bool isButtonActive;
  final List<Comment> comments;
  final String? commentIdToUpdate;
  final CommentActions commentAction;

  PostDetailedState({
    this.commentIdToUpdate,
    required this.isButtonActive,
    required this.comments,
    required this.commentAction,
  });

  PostDetailedState copyWith({
    String? commentIdToUpdate,
    bool? isButtonActive,
    List<Comment>? comments,
    CommentActions? commentAction,
  }) {
    return PostDetailedState(
      commentIdToUpdate: commentIdToUpdate ?? this.commentIdToUpdate,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      comments: comments ?? this.comments,
      commentAction: commentAction ?? this.commentAction,
    );
  }
}
