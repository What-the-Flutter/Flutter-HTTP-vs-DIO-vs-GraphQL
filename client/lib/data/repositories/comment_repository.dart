import 'package:client/data/repositories/base_repository.dart';
import 'package:client/domain/data_interfaces/i_comment_repository.dart';
import 'package:client/domain/entities/comment/comment.dart';

class CommentRepository extends BaseRepository implements ICommentRepository{
  CommentRepository(super.remoteDataSource);

  @override
  Future<void> create(Comment comment) async {
    return await remoteDataSource.createComment(comment);
  }

  @override
  Future<void> delete(String id) async {
    return await remoteDataSource.deleteComment(id);
  }

  @override
  Future<List<Comment>> getAllByPostId(String postId) async {
    return await remoteDataSource.getCommentsByPostId(postId);
  }

  @override
  Future<void> update(Comment newComment) async {
    return await remoteDataSource.updateComment(newComment);
  }
}
