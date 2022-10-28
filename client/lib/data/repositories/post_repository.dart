import 'package:client/data/repositories/base_repository.dart';
import 'package:client/domain/data_interfaces/i_post_repository.dart';
import 'package:client/domain/entities/post/post.dart';

class PostRepository extends BaseRepository implements IPostRepository {
  PostRepository(super.remoteDataSource);

  @override
  Future<void> create(Post post) async {
    return await remoteDataSource.createPost(post);
  }

  @override
  Future<void> delete(String id) async {
    return await remoteDataSource.deletePost(id);
  }

  @override
  Future<List<Post>> getAllPosts() async {
    return await remoteDataSource.getAllPosts();
  }

  @override
  Future<Post> getPost(String id) async {
    return await remoteDataSource.getPost(id);
  }

  @override
  Future<void> update(Post newPost) async {
    return await remoteDataSource.updatePost(newPost);
  }
}
