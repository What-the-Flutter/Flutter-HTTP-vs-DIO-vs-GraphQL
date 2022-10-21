import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';

abstract class IRemoteDataSource {
  Future<void> createUser(CreateUserModel user);
  Future<User> loginUser(CreateUserModel user);

  Future<List<Post>> getAllPosts();
  Future<Post> getPost(String postId);
  Future<void> createPost(CreatePostModel post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String postId);

  Future<List<Comment>> getCommentsByPostId(String postId);
  Future<void> createComment(CreateCommentModel comment);
  Future<void> updateComment(Comment comment);
  Future<void> deleteComment(String commentId);
}
