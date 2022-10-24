import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/interactors/post_interactor.dart';
import 'package:client/domain/interactors/user_interactor.dart';
import 'package:client/presentation/base/base_state_notifier.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:client/presentation/pages/postConstructor/post_constructor_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postConstructorProvider =
    StateNotifierProvider<PostConstructorStateNotifier, PostConstructorState>((ref) {
  return PostConstructorStateNotifier();
});

class PostConstructorStateNotifier extends BaseStateNotifier<PostConstructorState> {
  //TODO: implement error handling

  late final PostInteractor _postInteractor;
  late final User _user;

  PostConstructorStateNotifier()
      : super(
          PostConstructorState(
            isButtonActive: false,
          ),
        ) {
    //_postInteractor = i.get();
    //_user = i.get<UserInteractor>().user;
  }

  Future<void> addPost({
    required String title,
    required String text,
    required Function onSuccess,
    required Function onError,
  }) async {
    final post = CreatePostModel(
      userId: _user.id,
      authorName: _user.name,
      text: text,
      title: title,
      date: DateTime.now(),
    );
    return launchRetrieveResult(
      () async {
        await _postInteractor.addPost(post);
        onSuccess();
      },
      errorHandler: (e) => onError,
    );
  }

  void setButtonActive(String title, String text) =>
      state = state.copyWith(isButtonActive: title.isNotEmpty && text.isNotEmpty);
}
