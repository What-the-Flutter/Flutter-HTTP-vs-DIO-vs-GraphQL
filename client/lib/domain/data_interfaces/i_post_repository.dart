import 'package:client/domain/entities/post/post.dart';
import 'entity_repository.dart';

abstract class IPostRepository implements EntityRepository<Post> {
  List<Post> getAllPosts();
  Future<void> create(Post post);
  Future<void> delete(int id);
  Future<void> update(Post newPost);
  Future<Post> getPost(int id);
}
