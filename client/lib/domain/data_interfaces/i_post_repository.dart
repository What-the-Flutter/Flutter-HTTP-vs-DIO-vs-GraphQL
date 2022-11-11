import 'package:client/domain/entities/post/post.dart';

abstract class IPostRepository {
  Future<List<Post>> getAllPosts();
  Future<void> create(Post post);
  Future<void> delete(String id);
  Future<void> update(Post newPost);
  Future<Post> getPost(String id);
}
