import 'package:client/presentation/app/navigation/routes.dart';
import 'package:client/presentation/auth/auth_widget.dart';
import 'package:client/presentation/pages/postConstructor/post_constructor_page.dart';
import 'package:client/presentation/pages/posts/posts_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Networking DI samples',
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const AuthPageWidget(),
          Routes.posts: (context) => const PostsPage(),
          Routes.addPost: (context) => const AddPostPage(),
          Routes.post: (context) => throw Error(),
        },
      ),
    );
  }
}
