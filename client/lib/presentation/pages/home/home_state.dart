import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/base/base_state.dart';

class HomeState extends BaseState {
  final List<Post> posts;

  HomeState({required this.posts});

  HomeState copyWith({List<Post>? posts}) {
    return HomeState(
      posts: posts ?? this.posts,
    );
  }
}
