import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:client/domain/interactors/post_iteractor.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:client/presentation/pages/postConstructor/post_constructor_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addPostProvider = StateNotifierProvider<AddPageStateNotifier, AddPageState>((ref) {
  return AddPageStateNotifier();
});

class AddPageStateNotifier extends StateNotifier<AddPageState> {
  //TODO: implement error handling

  late final PostInteractor _postInteractor;

  AddPageStateNotifier()
      : super(
          AddPageState(
            isButtonActive: false,
          ),
        ) {
    //_postInteractor = i.get();
  }

  Future<void> addPost(String title, String text) async {
    //getit user singleton
    // final user = i.get<User>();
    // final post = CreatePostModel(
    //   userId: user.id,
    //   authorName: user.name,
    //   text: text,
    //   title: title,
    //   date: DateTime.now(),
    // );
    // await _postInteractor.addPost(post);
  }

  void setButtonActive(String title, String text) =>
      state = state.copyWith(isButtonActive: title.isNotEmpty && text.isNotEmpty);
}
