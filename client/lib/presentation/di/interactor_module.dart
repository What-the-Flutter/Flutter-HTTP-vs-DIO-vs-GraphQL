import 'package:client/domain/interactors/comment_interactor.dart';
import 'package:client/domain/interactors/post_interactor.dart';
import 'package:client/domain/interactors/user_interactor.dart';

import 'injector.dart';

void initInteractorModule() {
  i.registerSingleton<UserInteractor>(UserInteractor(i.get()));
  i.registerSingleton<PostInteractor>(PostInteractor(i.get()));
  i.registerSingleton<CommentInteractor>(CommentInteractor(i.get()));
}
