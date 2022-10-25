import 'dart:async';

import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
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
  late final User _user;

  HomeStateNotifier()
      : super(
          HomeState(
            posts: [],
          ),
        ) {
    //_postInteractor = i.get();
    //_user = i.get<UserInteractor>().user;
    //getPosts();
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

  bool isPostAuthor(String authorId) {
    return _user.id == authorId;
  }

  void openPostPage(String postId) {}
}
