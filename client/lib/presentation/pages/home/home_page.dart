import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:client/presentation/app/theme/base_color_canstatns.dart';
import 'package:client/presentation/pages/home/home_provider.dart';
import 'package:client/presentation/pages/postConstructor/post_constructor_page.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'package:client/presentation/widgets/post_card.dart';
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
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(10),
            right: Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [
              BaseColors.gradientColorOne,
              BaseColors.gradientColorTwo,
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 60.0,
            ),
            Text(
              AppStrings.homePageName(context),
              style: TextStyle(
                color: BaseColors.textColorLight,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
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
        decoration: BoxDecoration(
          color: BaseColors.foregroundColor,
          borderRadius: const BorderRadius.horizontal(
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
              final canUserSlidePost =
                  ref.read(homeProvider.notifier).isPostAuthor(state.posts[index].userId);

              return PostCardWidget(
                isSlidable: canUserSlidePost,
                post: state.posts[index],
                onDeleteButtonPressed: () {
                  ref.read(homeProvider.notifier).removePost(
                        state.posts[index].id,
                        () => showInfoDialog(
                          context: context,
                          title: AppStrings.postError(context),
                          content: AppStrings.postDeleteErrorDescription(context),
                          onButtonClick: ref.read(homeProvider.notifier).pop,
                        ),
                      );
                },
              );
            },
            itemCount: state.posts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4.0),
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
          builder: (context) => const PostConstructorPage(
            postAction: PostActions.create,
          ),
        );
      },
      backgroundColor: BaseColors.backgroundColor,
      foregroundColor: BaseColors.foregroundColor,
      child: const Icon(
        Icons.add,
        size: 36.0,
      ),
    );
  }

  BottomAppBar _homeBottomAppBar(Size size) {
    return BottomAppBar(
      color: BaseColors.backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(height: size.height / 18.0),
    );
  }
}
