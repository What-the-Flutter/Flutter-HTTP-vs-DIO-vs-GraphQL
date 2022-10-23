import 'package:client/domain/entities/post/post.dart';

class HomeState {
  final List<Post> posts;

  HomeState({required this.posts});

  HomeState copyWith({List<Post>? posts}) {
    return HomeState(
      posts: posts ?? this.posts,
    );
  }
}
