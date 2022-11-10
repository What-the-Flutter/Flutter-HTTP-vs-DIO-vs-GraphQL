import 'package:client/data/data_sources/dio/dio_crud.dart';
import 'package:client/data/data_sources/interfaces/I_crud.dart';
import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:client/data/utils/remote_utils.dart';
import 'package:dio/dio.dart';

class DioRestRemoteDataSource implements IRemoteDataSource {
  final ICrud _dio = DioCrud();

  @override
  Future<void> createComment(Comment comment) async {
    final Response response = await _dio.post('/comment', comment);
    return response.retrieveResult();
  }

  @override
  Future<void> createPost(Post post) async {
    final Response response = await _dio.post('/post', post);
    return response.retrieveResult();
  }

  @override
  Future<void> createUser(User user) async {
    final Response response = await _dio.post('/createUser', user);
    return response.retrieveResult();
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final Response response = await _dio.delete('/comment/$commentId');
    return response.retrieveResult();
  }

  @override
  Future<void> deletePost(String postId) async {
    final Response response = await _dio.delete('/post/$postId');
    return response.retrieveResult();
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final Response response = await _dio.get('/comment/$postId');
    return response.retrieveResultAsList<Comment>();
  }

  @override
  Future<List<Post>> getAllPosts() async {
    final Response response = await _dio.get('/posts');
    return response.retrieveResultAsList<Post>();
  }

  @override
  Future<User> loginUser(User user) async {
    final Response response = await _dio.post('/login', user);
    return response.retrieveResult<User>()!;
  }

  @override
  Future<void> updateComment(Comment comment) async {
    final Response response = await _dio.put('/comment/${comment.id}', comment);
    return response.retrieveResult();
  }

  @override
  Future<void> updatePost(Post post) async {
    final Response response = await _dio.put('/post/${post.id}', post);
    return response.retrieveResult();
  }

  @override
  Future<Post> getPost(String postId) async {
    final Response response = await _dio.get('/post/$postId');
    return response.retrieveResult<Post>()!;
  }
}
