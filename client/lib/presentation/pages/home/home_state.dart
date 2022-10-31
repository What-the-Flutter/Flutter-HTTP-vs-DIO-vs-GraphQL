import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/base/base_state.dart';

class HomeState extends BaseState {
  final List<Post> posts;
  final String userId;

  HomeState({required this.posts, required this.userId});

  HomeState copyWith({List<Post>? posts, String? userId}) {
    return HomeState(
      posts: posts ?? this.posts,
      userId: userId ?? this.userId,
    );
  }
}
