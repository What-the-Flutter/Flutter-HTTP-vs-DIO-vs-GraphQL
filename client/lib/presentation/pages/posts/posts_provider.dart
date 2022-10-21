import 'dart:async';

import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/interactors/post_iteractor.dart';
import 'package:client/presentation/pages/posts/posts_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider =
    StateNotifierProvider<PostsStateNotifier, PostsState>((ref) {
  return PostsStateNotifier();
});

class PostsStateNotifier extends StateNotifier<PostsState> {
  late Timer _timer;
  final _pollingTimeout = const Duration(seconds: 10);

  late final PostInteractor _postInteractor;
  //TODO: implement error handling

  PostsStateNotifier()
      : super(
          PostsState(
            posts: [],
          ),
        ) {
    //_postInteractor = i.get();
    //_getPosts();
  }

  void initPolling() {
    _timer = Timer.periodic(_pollingTimeout, _poll);
  }

  void stopPolling() {
    _timer.cancel();
  }

  void _poll(Timer _) {
    //_getPosts();
  }

  Future<void> _getPosts() async {
    final newPosts = await _postInteractor.getPosts();
    state = state.copyWith(posts: newPosts);
    return;
  }

  void onPostClick(String postId) {}
}
