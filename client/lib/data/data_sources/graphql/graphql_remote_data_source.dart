import 'package:client/data/data_sources/interfaces/i_remote_data_source.dart';
import 'package:client/data/utils/graphql_query_strings.dart';
import 'package:client/data/utils/remote_utils.dart';
import 'package:client/domain/constants/connectivity_constants.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:graphql/client.dart';

class GraphqlRemoteDataSource implements IRemoteDataSource {
  late final GraphQLClient _client;

  GraphqlRemoteDataSource() {
    final Link link = HttpLink(
      ConnectivityStrings.baseUrl,
    );
    _client = GraphQLClient(
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.networkOnly,
        ),
      ),
      link: link,
    );
  }

  @override
  Future<void> createComment(Comment comment) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueryStrings.createComment),
      variables: <String, dynamic>{
        'postId': comment.postId,
        'userId': comment.userId,
        'authorName': comment.authorName,
        'text': comment.text,
        'date': comment.date.toString(),
      },
    );

    final QueryResult result = await _client.mutate(options);
    return result.retrieveResult();
  }

  @override
  Future<void> createPost(Post post) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueryStrings.createPost),
      variables: <String, dynamic>{
        'userId': post.userId,
        'authorName': post.authorName,
        'title': post.title,
        'text': post.text,
        'date': post.date.toString(),
      },
    );

    final QueryResult result = await _client.mutate(options);
    return result.retrieveResult();
  }

  @override
  Future<void> createUser(User user) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueryStrings.createUser),
      variables: <String, dynamic>{
        'name': user.name,
        'password': user.password,
      },
    );

    final QueryResult result = await _client.mutate(options);
    return result.retrieveResult(tag: 'createUserMutation');
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueryStrings.deleteComment),
      variables: <String, dynamic>{
        'id': commentId,
      },
    );

    final QueryResult result = await _client.mutate(options);
    return result.retrieveResult();
  }

  @override
  Future<void> deletePost(String postId) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueryStrings.deletePost),
      variables: <String, dynamic>{
        'id': postId,
      },
    );

    final QueryResult result = await _client.mutate(options);
    return result.retrieveResult();
  }

  @override
  Future<List<Post>> getAllPosts() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueryStrings.getPosts),
    );
    final QueryResult result = await _client.query(options);
    return result.retrieveResultAsList<Post>(tag: 'posts');
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueryStrings.getCommentsByPostId),
      variables: <String, dynamic>{
        'postId': postId,
      },
    );
    final QueryResult result = await _client.query(options);
    return result.retrieveResultAsList<Comment>(tag: 'comments');
  }

  @override
  Future<Post> getPost(String postId) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueryStrings.getPost),
      variables: <String, dynamic>{
        'id': postId,
      },
    );
    final QueryResult result = await _client.query(options);
    return result.retrieveResult<Post>(tag: 'post')!;
  }

  @override
  Future<User> loginUser(User user) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueryStrings.loginUser),
      variables: <String, dynamic>{
        'name': user.name,
        'password': user.password,
      },
    );

    final QueryResult result = await _client.mutate(options);
    return result.retrieveResult<User>(tag: 'loginMutation')!;
  }

  @override
  Future<void> updateComment(Comment comment) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueryStrings.updateComment),
      variables: <String, dynamic>{
        'id': comment.id,
        'text': comment.text,
      },
    );

    final QueryResult result = await _client.mutate(options);
    return result.retrieveResult();
  }

  @override
  Future<void> updatePost(Post post) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueryStrings.updatePost),
      variables: <String, dynamic>{
        'id': post.id,
        'title': post.title,
        'text': post.text,
      },
    );

    final QueryResult result = await _client.mutate(options);
    return result.retrieveResult();
  }
}
