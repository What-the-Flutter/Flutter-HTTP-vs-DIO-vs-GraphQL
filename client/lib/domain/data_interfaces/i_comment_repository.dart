import 'package:client/domain/entities/comment/comment.dart';

abstract class ICommentRepository {
  Future<void> create(Comment comment);
  Future<void> delete(String id);
  Future<void> update(Comment newComment);
  Future<List<Comment>> getAllByPostId(String postId);
}
