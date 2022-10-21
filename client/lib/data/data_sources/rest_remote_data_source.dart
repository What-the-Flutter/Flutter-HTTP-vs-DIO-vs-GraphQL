import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/data/utils/remote_utils.dart';
import 'package:client/domain/constants/connectivity_constants.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:dio/dio.dart';

class RestRemoteDataSource implements IRemoteDataSource {
  final _dio = Dio();

  RestRemoteDataSource() {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  Future<void> createComment(CreateCommentModel comment) async {
    final response = await _dio.post('/comment', data: comment.toJson());
    return response.retrieveResult();
  }

  @override
  Future<void> createPost(CreatePostModel post) async {
    final response = await _dio.post('/post', data: post.toJson());
    return response.retrieveResult();
  }

  @override
  Future<void> createUser(CreateUserModel user) async {
    final response = await _dio.post('/createUser', data: user.toJson());
    return response.retrieveResult();
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final response = await _dio.delete('/comment/$commentId');
    return response.retrieveResult();
  }

  @override
  Future<void> deletePost(String postId) async {
    final response = await _dio.delete('/post/$postId');
    return response.retrieveResult();
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final response = await _dio.get('/comment/$postId');
    return response.retrieveResultAsList<Comment>();
  }

  @override
  Future<List<Post>> getAllPosts() async {
    final response = await _dio.get('/posts');
    return response.retrieveResultAsList<Post>();
  }

  @override
  Future<User> loginUser(CreateUserModel user) async {
    final response = await _dio.post('/login', data: user.toJson());
    return response.retrieveResult<User>()!;
  }

  @override
  Future<void> updateComment(Comment comment) async {
    final response = await _dio.put('/comment/${comment.id}', data: comment.toJson());
    return response.retrieveResult();
  }

  @override
  Future<void> updatePost(Post post) async {
    final response = await _dio.put('/post/${post.id}', data: post.toJson());
    return response.retrieveResult();
  }
}
