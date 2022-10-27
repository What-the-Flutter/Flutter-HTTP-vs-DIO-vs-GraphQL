import 'dart:convert';
import 'dart:io';

import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/data/utils/remote_utils.dart';
import 'package:client/domain/constants/connectivity_constants.dart';
import 'package:client/domain/entities/api_object.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HttpRestRemoteDataSource implements IRemoteDataSource {
  Future<Map<String, String>> _headers() async {
    return {
      'Content-Type': 'application/json',
      'X-Time-Zone-Offset': DateTime.now().toLocal().toString(),
      'api-version': '1.0',
      'Accept-Language': 'en',
      'X-Platform': Platform.isIOS ? 'ios' : 'android',
      'App-version': (await PackageInfo.fromPlatform()).version,
    };
  }

  @override
  Future<void> createComment(Comment comment) async {
    final response = await _request(_Http.post, '/comment', body: comment);
    return response.retrieveResult();
  }

  @override
  Future<void> createPost(Post post) async {
    final response = await _request(_Http.post, '/post', body: post);
    return response.retrieveResult();
  }

  @override
  Future<void> createUser(User user) async {
    final response = await _request(_Http.post, '/createUser', body: user);
    return response.retrieveResult();
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final response = await _request(_Http.delete, '/comment/$commentId');
    return response.retrieveResult();
  }

  @override
  Future<void> deletePost(String postId) async {
    final response = await _request(_Http.delete, '/post/$postId');
    return response.retrieveResult();
  }

  @override
  Future<List<Post>> getAllPosts() async {
    final response = await _request(_Http.get, '/posts');
    return response.retrieveResultAsList<Post>();
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final response = await _request(_Http.get, '/comment/$postId');
    return response.retrieveResultAsList<Comment>();
  }

  @override
  Future<Post> getPost(String postId) async {
    final response = await _request(_Http.get, '/post/$postId');
    return response.retrieveResult<Post>()!;
  }

  @override
  Future<User> loginUser(User user) async {
    final response = await _request(_Http.post, '/login', body: user);
    return response.retrieveResult<User>()!;
  }

  @override
  Future<void> updateComment(Comment comment) async {
    final response = await _request(_Http.put, '/comment/${comment.id}', body: comment);
    return response.retrieveResult();
  }

  @override
  Future<void> updatePost(Post post) async {
    final response = await _request(_Http.put, '/post/${post.id}', body: post);
    return response.retrieveResult();
  }

  Future<Response> _request(
    _Http method,
    String url, {
    Map<String, String>? extraHeaders,
    ApiObject? body,
    Map<String, dynamic>? rawBody,
  }) async {
    final headers = await _headers();
    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }
    var b = rawBody;
    if (body != null) {
      b = body.toJson();
    }
    final uri = Uri.parse('${ConnectivityStrings.baseUrl}$url');
    final encodedBody = b == null ? null : jsonEncode(b);
    Response response;
    switch (method) {
      case _Http.get:
        response = await get(uri, headers: headers);
        break;
      case _Http.post:
        response = await post(uri, headers: headers, body: encodedBody);
        break;
      case _Http.put:
        response = await put(uri, headers: headers, body: encodedBody);
        break;
      case _Http.delete:
        response = await delete(uri, headers: headers);
        break;
      default:
        throw ArgumentError('Method is unknown');
    }
    return response;
  }
}

enum _Http {
  get,
  post,
  put,
  delete,
}
