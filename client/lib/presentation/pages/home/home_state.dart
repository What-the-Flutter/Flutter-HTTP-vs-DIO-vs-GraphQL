import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/base/base_state.dart';

class HomeState extends BaseState {
  final List<Post> posts;
  final String userId;
  final bool showServerErrorMessage;

  HomeState({
    required this.posts,
    required this.userId,
    required this.showServerErrorMessage,
  });

  HomeState copyWith({
    List<Post>? posts,
    String? userId,
    bool? showServerErrorMessage,
  }) {
    return HomeState(
      posts: posts ?? this.posts,
      userId: userId ?? this.userId,
      showServerErrorMessage: showServerErrorMessage ?? this.showServerErrorMessage,
    );
  }
}
