import 'package:client/domain/entities/post/post.dart';

class PostsState {
  final List<Post> posts;

  PostsState({required this.posts});

  PostsState copyWith({List<Post>? posts}) {
    return PostsState(
      posts: posts ?? this.posts,
    );
  }
}
