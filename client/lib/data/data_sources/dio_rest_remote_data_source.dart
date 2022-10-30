import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/data/utils/remote_utils.dart';
import 'package:client/domain/constants/connectivity_constants.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:dio/dio.dart';

class DioRestRemoteDataSource implements IRemoteDataSource {
  final _dio = Dio();

  DioRestRemoteDataSource() {
    _dio.options.baseUrl = ConnectivityStrings.baseUrl;
  }

  @override
  Future<void> createComment(Comment comment) async {
    late final Response response;
    try {
      response = await _dio.post('/comment', data: comment.toJson());
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult();
  }

  @override
  Future<void> createPost(Post post) async {
    late final Response response;
    try {
      response = await _dio.post('/post', data: post.toJson());
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult();
  }

  @override
  Future<void> createUser(User user) async {
    late final Response response;
    try {
      response = await _dio.post('/createUser', data: user.toJson());
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult();
  }

  @override
  Future<void> deleteComment(String commentId) async {
    late final Response response;
    try {
      response = await _dio.delete('/comment/$commentId');
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult();
  }

  @override
  Future<void> deletePost(String postId) async {
    late final Response response;
    try {
      response = await _dio.delete('/post/$postId');
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult();
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    late final Response response;
    try {
      response = await _dio.get('/comment/$postId');
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResultAsList<Comment>();
  }

  @override
  Future<List<Post>> getAllPosts() async {
    late final Response response;
    try {
      response = await _dio.get('/posts');
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResultAsList<Post>();
  }

  @override
  Future<User> loginUser(User user) async {
    late final Response response;
    try {
      response = await _dio.post('/login', data: user.toJson());
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult<User>()!;
  }

  @override
  Future<void> updateComment(Comment comment) async {
    late final Response response;
    try {
      response = await _dio.put('/comment/${comment.id}', data: comment.toJson());
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult();
  }

  @override
  Future<void> updatePost(Post post) async {
    late final Response response;
    try {
      response = await _dio.put('/post/${post.id}', data: post.toJson());
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult();
  }

  @override
  Future<Post> getPost(String postId) async {
    late final Response response;
    try {
      response = await _dio.get('/post/$postId');
    } on DioError catch (e) {
      _handleError(e);
    }
    return response.retrieveResult<Post>()!;
  }

  void _handleError(DioError e) {
    e.response?.statusCode == 401 || e.response?.statusCode == 409
        ? throw WrongUserDataException()
        : throw Exception(
            'Error: ${e.response?.statusMessage} \n Error code: ${e.response?.statusCode}');
  }
}
