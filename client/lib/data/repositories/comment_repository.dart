import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/domain/data_interfaces/i_comment_repository.dart';
import 'package:client/domain/entities/comment/comment.dart';

class CommentRepository implements ICommentRepository {
  final IRemoteDataSource _remoteDataSource;

  CommentRepository(this._remoteDataSource);

  @override
  Future<void> create(Comment comment) async {
    return await _remoteDataSource.createComment(comment);
  }

  @override
  Future<void> delete(String id) async {
    return await _remoteDataSource.deleteComment(id);
  }

  @override
  Future<List<Comment>> getAllByPostId(String postId) async {
    return await _remoteDataSource.getCommentsByPostId(postId);
  }

  @override
  Future<void> update(Comment newComment) async {
    return await _remoteDataSource.updateComment(newComment);
  }
}
