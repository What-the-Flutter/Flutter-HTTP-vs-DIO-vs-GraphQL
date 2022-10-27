import 'package:client/domain/data_interfaces/i_comment_repository.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/interactors/base_interactor.dart';

class CommentInteractor extends BaseInteractor {
  final ICommentRepository _commentRepository;

  CommentInteractor(this._commentRepository);

  Future<void> createComment(Comment commentModel) {
    return _commentRepository.create(commentModel);
  }

  Future<void> updateComment(Comment comment) {
    return _commentRepository.update(comment);
  }

  Future<void> deleteComment(String commentId) {
    return _commentRepository.delete(commentId);
  }

  Future<List<Comment>> getAllCommentsByPostId(String postId) {
    return _commentRepository.getAllByPostId(postId);
  }
}
