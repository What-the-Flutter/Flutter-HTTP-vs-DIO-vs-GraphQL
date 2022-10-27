import 'package:client/domain/data_interfaces/i_post_repository.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/interactors/base_interactor.dart';

class PostInteractor extends BaseInteractor {
  final IPostRepository _postRepository;
  late final Post post;

  PostInteractor(this._postRepository);

  Future<void> setPost(String postId) async {
    post = await _postRepository.getPost(postId);
  }

  Future<void> addPost(Post post) {
    return _postRepository.create(post);
  }

  Future<void> editPost(Post post) {
    return _postRepository.update(post);
  }

  Future<List<Post>> getPosts() async {
    return _postRepository.getAllPosts();
  }

  Future<void> removePost(String postId) async {
    return _postRepository.delete(postId);
  }
}
