import 'dart:async';

import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/interactors/post_iteractor.dart';
import 'package:client/presentation/pages/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});

class HomeStateNotifier extends StateNotifier<HomeState> {
  late Timer _timer;
  final _pollingTimeout = const Duration(seconds: 10);

  late final PostInteractor _postInteractor;
  //TODO: implement error handling

  HomeStateNotifier()
      : super(
          HomeState(
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

  void openPostPage(String postId) {}
}
