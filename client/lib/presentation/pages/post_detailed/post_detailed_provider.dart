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
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDetailedProvider =
    StateNotifierProvider<PostDetailedStateNotifier, PostDetailedState>((ref) {
  return PostDetailedStateNotifier();
});

class PostDetailedStateNotifier extends BaseStateNotifier<PostDetailedState> {
  final UserInteractor _userInteractor = i.get();
  final PostInteractor _postInteractor = i.get();
  final CommentInteractor _commentInteractor = i.get();

  late final Timer _timer;
  final _pollingTimeout = const Duration(seconds: 10);

  late Post post;
  late final User _user;

  PostDetailedStateNotifier()
      : super(
          PostDetailedState(
            isButtonActive: false,
            comments: [],
            showHeaderAdditionalInfo: false,
            commentAction: CommentActions.create,
            commentIdToUpdate: null,
          ),
        );

  void initState(Function onError) async {
    post = _postInteractor.post;
    await _getComments();
    _initPolling(onError);
    await launchRetrieveResult(
      () async {
        _user = _userInteractor.user;
      },
      errorHandler: (e) => onError,
    );
  }

  void _initPolling(Function onError) {
    launchRetrieveResult(
      () => _timer = Timer.periodic(_pollingTimeout, (_) async => await _getComments()),
      errorHandler: (e) => onError,
    );
  }

  void stopPolling() {
    _timer.cancel();
  }

  bool isCommentAuthor(String commentUserId) => commentUserId == _user.id;

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

  void initEditCommentState(String commentId) {
    state = state.copyWith(commentAction: CommentActions.edit, commentIdToUpdate: commentId);
  }

  Future<void> editComment(String text, Function onError) async {
    final comment = Comment(
      id: state.commentIdToUpdate!,
      userId: _user.id,
      postId: post.id,
      authorName: _user.name,
      text: text,
      date: DateTime.now(),
    );
    await launchRetrieveResult(() async {
      await _commentInteractor.updateComment(comment);
      await _getComments();
      state = state.copyWith(commentAction: CommentActions.create, commentIdToUpdate: null);
    }, errorHandler: (e) => onError);
  }

  Future<void> deleteComment(String commentId, Function onError) async {
    await launchRetrieveResult(() async {
      await _commentInteractor.deleteComment(commentId);
      await _getComments();
    }, errorHandler: (e) => onError);
  }

  void switchHeaderInfoState() {
    state = state.copyWith(showHeaderAdditionalInfo: !state.showHeaderAdditionalInfo);
  }

  void setButtonActive(String text) => state = state.copyWith(isButtonActive: text.isNotEmpty);
}
