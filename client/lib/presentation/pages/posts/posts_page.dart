import 'package:client/presentation/pages/posts/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsPage extends ConsumerStatefulWidget {
  const PostsPage({super.key});

  @override
  ConsumerState<PostsPage> createState() => PostsPageWidgetState();
}

class PostsPageWidgetState extends ConsumerState<PostsPage> {
  @override
  void initState() {
    super.initState();
    ref.read(postsProvider.notifier).initPolling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: _postsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addPost');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void deactivate() {
    ref.read(postsProvider.notifier).stopPolling();
    super.deactivate();
  }

  Widget _postsList() {
    final state = ref.watch(postsProvider);
    return ListView.separated(
      itemCount: state.posts.length,
      padding: const EdgeInsets.all(10),
      separatorBuilder: (context, index) => const Divider(thickness: 2),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => ref
              .read(postsProvider.notifier)
              .onPostClick(state.posts[index].id),
          child: ListTile(
            title: Text(state.posts[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.posts[index].authorName,
                  style: TextStyle(
                    color: Colors.blue[900],
                  ),
                ),
                Text(state.posts[index].text),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      state.posts[index].date.toString(),
                    )
                  ],
                ),
                const Text('comments: 0'),
              ],
            ),
          ),
        );
      },
    );
  }
}
