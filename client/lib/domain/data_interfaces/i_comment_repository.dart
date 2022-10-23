import 'package:client/domain/entities/comment/comment.dart';
import 'entity_repository.dart';

abstract class ICommentRepository implements EntityRepository<Comment> {
  Future<void> create(CreateCommentModel comment);
  Future<void> delete(String id);
  Future<void> update(Comment newComment);
  Future<List<Comment>> getAllByPostId(String postId);
}
