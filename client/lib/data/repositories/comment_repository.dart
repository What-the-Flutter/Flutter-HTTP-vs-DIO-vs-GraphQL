import 'package:client/data/repositories/base_repository.dart';
import 'package:client/domain/data_interfaces/i_comment_repository.dart';
import 'package:client/domain/entities/comment/comment.dart';

class CommentRepository extends BaseRepository implements ICommentRepository {
  CommentRepository(super.remoteDataSource);

  @override
  Future<void> create(_) async => await remoteDataSource.createComment(_);

  @override
  Future<void> delete(_) async => await remoteDataSource.deleteComment(_);

  @override
  Future<List<Comment>> getAllByPostId(_) async => await remoteDataSource.getCommentsByPostId(_);

  @override
  Future<void> update(_) async => await remoteDataSource.updateComment(_);
}
