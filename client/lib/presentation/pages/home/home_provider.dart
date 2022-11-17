import 'dart:async';

import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/interactors/post_interactor.dart';
import 'package:client/domain/interactors/user_interactor.dart';
import 'package:client/presentation/app/navigation/route_constants.dart';
import 'package:client/presentation/base/base_state_notifier.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:client/presentation/pages/home/home_state.dart';
import 'package:client/presentation/tools/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});

class HomeStateNotifier extends BaseStateNotifier<HomeState> {
  static final _initialState = HomeState(posts: [], userId: '', showServerErrorMessage: false);

  late Timer _timer;
  final _pollingTimeout = const Duration(seconds: 10);

  late final PostInteractor _postInteractor;
  late final User _user;

  HomeStateNotifier() : super(_initialState) {
    _postInteractor = i.get();
    _user = i.get<UserInteractor>().user;
  }

  void initState() async {
    if(mounted) {
      await getPosts();
      if(state.userId != _user.id) {
        state = state.copyWith(userId: _user.id);
      }
    }
    _initPolling();
  }

  void _initPolling() async =>
      _timer = Timer.periodic(_pollingTimeout, (_) async => await getPosts());

  void stopPolling() => _timer.cancel();

  Future<void> getPosts() async {
    return launchRetrieveResult(
      () async {
        final newPosts = await _postInteractor.getPosts();
        newPosts.sort((a, b) => -a.date.compareTo(b.date));
        state = state.copyWith(posts: newPosts);
      },
      errorHandler: (e) => _openErrorDialog,
    );
  }

  void removePost(String postId) async {
    return launchRetrieveResult(
      () async {
        await _postInteractor.removePost(postId);
        final newPosts = await _postInteractor.getPosts();
        state = state.copyWith(posts: newPosts);
      },
      errorHandler: (e) => _openErrorDialog,
    );
  }

  void openPostPage(String postId) async {
    return launchRetrieveResult(
      () async {
        await _postInteractor.setPost(postId);
        appRouter.pushNamed(Routes.post);
      },
      errorHandler: (e) => _openErrorDialog,
    );
  }

  void _openErrorDialog() => state.copyWith(showServerErrorMessage: true);

  void closeErrorDialog() {
    pop();
    state.copyWith(showServerErrorMessage: false);
  }
}
