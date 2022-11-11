import 'package:client/data/data_sources/http/http_crud.dart';
import 'package:client/data/data_sources/interfaces/I_crud.dart';
import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/data/utils/remote_utils.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:http/http.dart';

class HttpRestRemoteDataSource implements IRemoteDataSource {
  final ICrud _httpCrud = HttpCrud();

  @override
  Future<void> createComment(Comment comment) async {
    final Response response = await _httpCrud.post('/comment', comment);
    return response.retrieveResult();
  }

  @override
  Future<void> createPost(Post post) async {
    final Response response = await _httpCrud.post('/post', post);
    return response.retrieveResult();
  }

  @override
  Future<void> createUser(User user) async {
    final Response response = await _httpCrud.post('/createUser', user);
    return response.retrieveResult();
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final Response response = await _httpCrud.delete('/comment/$commentId');
    return response.retrieveResult();
  }

  @override
  Future<void> deletePost(String postId) async {
    final Response response = await _httpCrud.delete('/post/$postId');
    return response.retrieveResult();
  }

  @override
  Future<List<Post>> getAllPosts() async {
    final Response response = await _httpCrud.get('/posts');
    return response.retrieveResultAsList<Post>();
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final Response response = await _httpCrud.get('/comment/$postId');
    return response.retrieveResultAsList<Comment>();
  }

  @override
  Future<Post> getPost(String postId) async {
    final Response response = await _httpCrud.get('/post/$postId');
    return response.retrieveResult<Post>()!;
  }

  @override
  Future<User> loginUser(User user) async {
    final Response response = await _httpCrud.post('/login', user);
    return response.retrieveResult<User>()!;
  }

  @override
  Future<void> updateComment(Comment comment) async {
    final Response response = await _httpCrud.put('/comment/${comment.id}', comment);
    return response.retrieveResult();
  }

  @override
  Future<void> updatePost(Post post) async {
    final Response response = await _httpCrud.put('/post/${post.id}', post);
    return response.retrieveResult();
  }
}
