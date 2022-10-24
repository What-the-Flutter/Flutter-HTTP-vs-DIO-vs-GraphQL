import 'dart:async';

import 'package:client/domain/interactors/post_interactor.dart';
import 'package:client/presentation/base/base_state_notifier.dart';
import 'package:client/presentation/pages/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});

class HomeStateNotifier extends BaseStateNotifier<HomeState> {
  late Timer _timer;
  final _pollingTimeout = const Duration(seconds: 10);

  late final PostInteractor _postInteractor;

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
    //getPosts();
  }

  Future<void> getPosts() async {
    final newPosts = await _postInteractor.getPosts();
    state = state.copyWith(posts: newPosts);
    return;
  }

  void removePost(String postId, Function onError) async {
    return launchRetrieveResult(
      () async {
        await _postInteractor.removePost(postId);
        await getPosts();
      },
      errorHandler: (e) => onError,
    );
  }

  void openPostPage(String postId) {}
}
