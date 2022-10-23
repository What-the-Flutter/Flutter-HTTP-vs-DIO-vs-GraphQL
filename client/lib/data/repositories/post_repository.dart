import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/domain/data_interfaces/i_post_repository.dart';
import 'package:client/domain/entities/post/post.dart';

class PostRepository implements IPostRepository {
  final IRemoteDataSource _remoteDataSource;

  PostRepository(this._remoteDataSource);

  @override
  Future<void> create(CreatePostModel post) async {
    return await _remoteDataSource.createPost(post);
  }

  @override
  Future<void> delete(String id) async {
    return await _remoteDataSource.deletePost(id);
  }

  @override
  Future<List<Post>> getAllPosts() async {
    return await _remoteDataSource.getAllPosts();
  }

  @override
  Future<Post> getPost(String id) async {
    return await _remoteDataSource.getPost(id);
  }

  @override
  Future<void> update(Post newPost) async {
    return await _remoteDataSource.updatePost(newPost);
  }
}
