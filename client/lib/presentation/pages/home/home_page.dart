import 'package:client/presentation/pages/home/home_provider.dart';
import 'package:client/presentation/pages/postConstructor/post_constructor_page.dart';
import 'package:client/presentation/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => HomePageWidgetState();
}

class HomePageWidgetState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider.notifier).initPolling();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            _positionedBackGround(size),
            _positionedPostsList(size),
          ],
        ),
      ),
      bottomNavigationBar: _homeBottomAppBar(size),
      floatingActionButton: _homeFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void deactivate() {
    ref.read(homeProvider.notifier).stopPolling();
    super.deactivate();
  }

  Widget _positionedBackGround(Size size) {
    return Positioned(
      child: Container(
        width: size.width,
        height: size.height / 3.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(10),
            right: Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xff8d70fe),
              Color(0xff2da9ef),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Column(
          children: const [
            SizedBox(
              height: 60.0,
            ),
            Text(
              'Feed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _positionedPostsList(Size size) {
    final state = ref.watch(homeProvider);
    return Positioned(
      top: size.height / 6.5,
      left: 16.0,
      child: Container(
        width: size.width - 32.0,
        height: size.height / 1.2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(10.0),
            right: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            itemBuilder: (context, index) {
              return CardWidget(
                post: state.posts[index],
              );
            },
            itemCount: state.posts.length,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 4.0,
              );
            },
          ),
        ),
      ),
    );
  }

  FloatingActionButton _homeFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const PostConstructorPage(postAction: PostActions.create);
          },
        );
      },
      backgroundColor: const Color(0xff2da9ef),
      foregroundColor: const Color(0xffffffff),
      child: const Icon(
        Icons.add,
        size: 36.0,
      ),
    );
  }

  BottomAppBar _homeBottomAppBar(Size size) {
    return BottomAppBar(
      color: const Color(0xff2da9ef),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: size.height / 18.0,
      ),
    );
  }
}
