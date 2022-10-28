import 'package:client/data/repositories/comment_repository.dart';
import 'package:client/data/repositories/post_repository.dart';
import 'package:client/data/repositories/user_repository.dart';
import 'package:client/domain/data_interfaces/i_comment_repository.dart';
import 'package:client/domain/data_interfaces/i_post_repository.dart';
import 'package:client/domain/data_interfaces/i_user_repository.dart';

import 'injector.dart';

void initRepositoryModule() {
  i.registerSingleton<IUserRepository>(UserRepository(i.get()));
  i.registerSingleton<IPostRepository>(PostRepository(i.get()));
  i.registerSingleton<ICommentRepository>(CommentRepository(i.get()));
}