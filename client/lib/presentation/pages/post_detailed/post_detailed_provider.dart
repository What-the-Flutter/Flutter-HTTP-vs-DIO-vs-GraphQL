import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/interactors/comment_interactor.dart';
import 'package:client/domain/interactors/post_interactor.dart';
import 'package:client/domain/interactors/user_interactor.dart';
import 'package:client/presentation/base/base_state_notifier.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:client/presentation/pages/post_detailed/post_detailed_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDetailedProvider = StateNotifierProvider<PostDetailedStateNotifier, PostDetailedState>((ref) {
  return PostDetailedStateNotifier();
});

class PostDetailedStateNotifier extends BaseStateNotifier<PostDetailedState> {
  late final UserInteractor _userInteractor;
  late final PostInteractor _postInteractor;
  late final CommentInteractor _commentInteractor;

  late final Post post;
  late final bool isPostAuthor;
  late final User _user;

  PostDetailedStateNotifier()
      : super(
          PostDetailedState(
            isButtonActive: false,
            comments: [],
          ),
        );

  void initState(Function onError) async {
    _userInteractor = i.get();
    _postInteractor = i.get();
    _commentInteractor = i.get();

    await launchRetrieveResult(() async {
      await _getComments();
      post = _postInteractor.post;
      _user = _userInteractor.user;
      isPostAuthor = post.userId == _user.id;
    }, errorHandler: (e) => onError);
  }

  Future<void> _getComments() async {
    state = state.copyWith(comments: await _commentInteractor.getAllCommentsByPostId(post.id));
  }

  Future<void> addComment(String text, Function onError) async {
    final commentModel = Comment(
      id: '0',
      userId: _user.id,
      postId: post.id,
      authorName: _user.name,
      text: text,
      date: DateTime.now(),
    );

    await launchRetrieveResult(() async {
      await _commentInteractor.createComment(commentModel);
      await _getComments();
    }, errorHandler: (e) => onError);
  }

  Future<void> editComment(String commentId, String text, Function onError) async {
    final comment = Comment(
      id: commentId,
      userId: _user.id,
      postId: post.id,
      authorName: _user.name,
      text: text,
      date: DateTime.now(),
    );
    await launchRetrieveResult(() async {
      await _commentInteractor.updateComment(comment);
      await _getComments();
    }, errorHandler: (e) => onError);
  }

  Future<void> deleteComment(String commentId, Function onError) async {
    await launchRetrieveResult(() async {
      await _commentInteractor.deleteComment(commentId);
      await _getComments();
    }, errorHandler: (e) => onError);
  }

  void setButtonActive(String text) => state = state.copyWith(isButtonActive: text.isNotEmpty);
}
