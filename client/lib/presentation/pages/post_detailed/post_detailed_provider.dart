import 'dart:async';

import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/interactors/comment_interactor.dart';
import 'package:client/domain/interactors/post_interactor.dart';
import 'package:client/domain/interactors/user_interactor.dart';
import 'package:client/presentation/base/base_state_notifier.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:client/presentation/pages/post_detailed/post_detailed_state.dart';
import 'package:client/presentation/tools/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDetailedProvider =
    StateNotifierProvider<PostDetailedStateNotifier, PostDetailedState>((ref) {
  return PostDetailedStateNotifier();
});

class PostDetailedStateNotifier extends BaseStateNotifier<PostDetailedState> {
  static final _initialState = PostDetailedState(
    isButtonActive: false,
    comments: [],
    commentAction: CommentActions.create,
    commentIdToUpdate: null,
    showServerErrorMessage: false,
  );

  final UserInteractor _userInteractor = i.get();
  final PostInteractor _postInteractor = i.get();
  final CommentInteractor _commentInteractor = i.get();

  late Timer _timer;
  final _pollingTimeout = const Duration(seconds: 10);

  late Post post;
  late User _user;

  PostDetailedStateNotifier() : super(_initialState);

  Future<void> initState() async {
    post = _postInteractor.post;
    _user = _userInteractor.user;
    await _getComments();
    _initPolling();
  }

  void _initPolling() {
    _timer = Timer.periodic(_pollingTimeout, (_) async => await _getComments());
  }

  void stopPolling() => _timer.cancel();

  bool isCommentAuthor(String commentUserId) => commentUserId == _user.id;

  Future<void> _getComments() async {
    return launchRetrieveResult(
      () async {
        final comments = await _commentInteractor.getAllCommentsByPostId(post.id);
        comments.sort((a, b) => -a.date.compareTo(b.date));
        state = state.copyWith(comments: comments);
      },
      errorHandler: (e) => _openErrorDialog(),
    );
  }

  Future<void> addComment(String text) async {
    final commentModel = Comment(
      id: '0',
      userId: _user.id,
      postId: post.id,
      authorName: _user.name,
      text: text,
      date: DateTime.now(),
    );

    await launchRetrieveResult(
      () async {
        await _commentInteractor.createComment(commentModel);
      },
      errorHandler: (e) => _openErrorDialog(),
    );
    await _getComments();
  }

  void initEditCommentState(String commentId) {
    state = state.copyWith(commentAction: CommentActions.edit, commentIdToUpdate: commentId);
  }

  void resetButtonState() => state = state.copyWith(isButtonActive: false);

  Future<void> editComment(String text) async {
    final comment = Comment(
      id: state.commentIdToUpdate!,
      userId: _user.id,
      postId: post.id,
      authorName: _user.name,
      text: text,
      date: DateTime.now(),
    );
    await launchRetrieveResult(
      () async {
        await _commentInteractor.updateComment(comment);
        state = state.copyWith(commentAction: CommentActions.create, commentIdToUpdate: null);
      },
      errorHandler: (e) => _openErrorDialog(),
    );
    await _getComments();
  }

  Future<void> deleteComment(String commentId) async {
    await launchRetrieveResult(
      () async {
        await _commentInteractor.deleteComment(commentId);
      },
      errorHandler: (e) => _openErrorDialog(),
    );
    await _getComments();
  }

  void setButtonActive(String text) => state = state.copyWith(isButtonActive: text.isNotEmpty);

  void _openErrorDialog() => state.copyWith(showServerErrorMessage: true);

  void closeErrorDialog() {
    pop();
    state.copyWith(showServerErrorMessage: false);
  }
}
