import 'package:client/domain/entities/comment/comment.dart';
import 'entity_repository.dart';

abstract class ICommentRepository implements EntityRepository<Comment> {
  Future<void> create(Comment comment);
  Future<void> delete(int id);
  Future<void> update(Comment newComment);
  Future<List<Comment>> getAllByPostId(int postId);
}
