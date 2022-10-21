import 'package:client/domain/data_interfaces/i_comment_repository.dart';
import 'package:client/domain/interactors/base_interactor.dart';

class CommentInteractor extends BaseInteractor {
  final ICommentRepository _commentRepository;

  CommentInteractor(this._commentRepository);
}
