import 'package:client/data/data_sources/interfaces/I_crud.dart';
import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';

class RestRemoteDataSource implements IRemoteDataSource {
  late final ICrud _crud;

  RestRemoteDataSource(this._crud);

  @override
  Future<void> createComment(Comment comment) async {
    final response = await _crud.post('/comment', comment);
    return response.retrieveResult();
  }

  @override
  Future<void> createPost(Post post) async {
    final response = await _crud.post('/post', post);
    return response.retrieveResult();
  }

  @override
  Future<void> createUser(User user) async {
    var response = await _crud.post('/createUser', user);
    return response.retrieveResult();
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final response = await _crud.delete('/comment/$commentId');
    return response.retrieveResult();
  }

  @override
  Future<void> deletePost(String postId) async {
    final response = await _crud.delete('/post/$postId');
    return response.retrieveResult();
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final response = await _crud.get('/comment/$postId');
    return response.retrieveResultAsList<Comment>();
  }

  @override
  Future<List<Post>> getAllPosts() async {
    final response = await _crud.get('/posts');
    return response.retrieveResultAsList<Post>();
  }

  @override
  Future<User> loginUser(User user) async {
    var response = await _crud.post('/login', user);
    return response.retrieveResult<User>()!;
  }

  @override
  Future<void> updateComment(Comment comment) async {
    final response = await _crud.put('/comment/${comment.id}', comment);
    return response.retrieveResult();
  }

  @override
  Future<void> updatePost(Post post) async {
    final response = await _crud.put('/post/${post.id}', post);
    return response.retrieveResult();
  }

  @override
  Future<Post> getPost(String postId) async {
    final response = await _crud.get('/post/$postId');
    return response.retrieveResult<Post>()!;
  }
}
