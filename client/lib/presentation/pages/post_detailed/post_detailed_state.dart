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
  final bool showServerErrorMessage;

  PostDetailedState({
    this.commentIdToUpdate,
    required this.isButtonActive,
    required this.comments,
    required this.commentAction,
    required this.showServerErrorMessage,
  });

  PostDetailedState copyWith({
    String? commentIdToUpdate,
    bool? isButtonActive,
    List<Comment>? comments,
    CommentActions? commentAction,
    bool? showServerErrorMessage,
  }) {
    return PostDetailedState(
      commentIdToUpdate: commentIdToUpdate ?? this.commentIdToUpdate,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      comments: comments ?? this.comments,
      commentAction: commentAction ?? this.commentAction,
      showServerErrorMessage: showServerErrorMessage ?? this.showServerErrorMessage,
    );
  }
}
