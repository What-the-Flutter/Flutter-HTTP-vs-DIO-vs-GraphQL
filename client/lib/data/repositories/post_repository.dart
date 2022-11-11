import 'package:client/data/repositories/base_repository.dart';
import 'package:client/domain/data_interfaces/i_post_repository.dart';
import 'package:client/domain/entities/post/post.dart';

class PostRepository extends BaseRepository implements IPostRepository {
  PostRepository(super.remoteDataSource);

  @override
  Future<void> create(_) async => await remoteDataSource.createPost(_);

  @override
  Future<void> delete(_) async => await remoteDataSource.deletePost(_);

  @override
  Future<List<Post>> getAllPosts() async => await remoteDataSource.getAllPosts();

  @override
  Future<Post> getPost(_) async => await remoteDataSource.getPost(_);

  @override
  Future<void> update(_) async => await remoteDataSource.updatePost(_);
}
