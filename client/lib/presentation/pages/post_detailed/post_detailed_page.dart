import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:client/presentation/app/theme/base_color_constants.dart';
import 'package:client/presentation/pages/home/home_provider.dart';
import 'package:client/presentation/pages/post_detailed/post_detailed_provider.dart';
import 'package:client/presentation/pages/post_detailed/post_detailed_state.dart';
import 'package:client/presentation/widgets/comment_card.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'package:client/presentation/widgets/post_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _commentTextController = Provider((ref) => TextEditingController());

class PostDetailedPage extends ConsumerStatefulWidget {
  const PostDetailedPage({super.key});

  @override
  ConsumerState<PostDetailedPage> createState() => PostDetailedPageWidgetState();
}

class PostDetailedPageWidgetState extends ConsumerState<PostDetailedPage> {
  late final Future<void> _stateInitialization;

  @override
  void initState() {
    _stateInitialization = ref.read(postDetailedProvider.notifier).initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ref.listen(postDetailedProvider, (previous, next) {
      if (next.showServerErrorMessage) {
        _showErrorDialog();
      }
    });
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            _positionedBackGround(size),
            _positionedPageContent(size),
          ],
        ),
      ),
    );
  }

  Widget _positionedPageContent(Size size) {
    return Positioned(
      top: size.height / 6.5,
      left: 16.0,
      child: Container(
        width: size.width - 32.0,
        height: size.height / 1.2,
        decoration: BoxDecoration(
          color: BaseColors.backgroundColorLight,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(10.0),
            right: Radius.circular(10.0),
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: size.height / 2.5,
                  minWidth: double.infinity,
                ),
                child: PostHeaderWidget(
                  post: ref.read(postDetailedProvider.notifier).post,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _commentInput(size),
                  _commentsBlock(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _commentInput(Size size) {
    final state = ref.watch(postDetailedProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width - 66.0 - 32.0,
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: BaseColors.borderColorBlocked),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: BaseColors.borderColorActive),
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: AppStrings.commentInputHintText(context),
              hintStyle: TextStyle(
                color: BaseColors.hintTextColor,
              ),
            ),
            onChanged: (_) => {
              ref
                  .read(postDetailedProvider.notifier)
                  .setButtonActive(ref.read(_commentTextController).text)
            },
            controller: ref.read(_commentTextController),
          ),
        ),
        IconButton(
          color: ref.watch(postDetailedProvider).isButtonActive
              ? BaseColors.iconColorDark
              : BaseColors.borderColorBlocked,
          onPressed: () => {if (ref.watch(postDetailedProvider).isButtonActive) _onButtonClick()},
          icon: Icon(
            state.commentAction == CommentActions.create ? Icons.send : Icons.refresh,
            size: 30.0,
          ),
        )
      ],
    );
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    ref.read(postDetailedProvider.notifier).pop();
                    ref.read(homeProvider.notifier).initState();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: BaseColors.iconColorLight,
                  ),
                ),
                Text(
                  AppStrings.postDetailedPageName(context),
                  style: TextStyle(
                    color: BaseColors.textColorLight,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(null),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _commentsBlock() {
    final state = ref.watch(postDetailedProvider);
    return Expanded(
      child: FutureBuilder<void>(
        future: _stateInitialization,
        builder: (
          BuildContext context,
          AsyncSnapshot<void> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.comments(context) + state.comments.length.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: BaseColors.textColorDark,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      final canUserSlideComment = ref
                          .read(postDetailedProvider.notifier)
                          .isCommentAuthor(state.comments[index].userId);

                      return CommentCardWidget(
                        isSlidable: canUserSlideComment,
                        comment: state.comments[index],
                        onDeleteButtonPressed: () {
                          ref
                              .read(postDetailedProvider.notifier)
                              .deleteComment(state.comments[index].id);
                        },
                        onEditButtonPressed: () {
                          ref
                              .read(postDetailedProvider.notifier)
                              .initEditCommentState(state.comments[index].id);
                          ref.read(_commentTextController).text = state.comments[index].text;
                        },
                      );
                    },
                    itemCount: state.comments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 2.0),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  void _showErrorDialog() {
    showInfoDialog(
      context: context,
      title: AppStrings.postError(context),
      content: AppStrings.serverErrorDescription(context),
      onButtonClick: ref.read(postDetailedProvider.notifier).pop,
    );
  }

  void _onButtonClick() async {
    final state = ref.watch(postDetailedProvider);
    final commentText = ref.read(_commentTextController).text.trim();
    switch (state.commentAction) {
      case CommentActions.create:
        ref.read(postDetailedProvider.notifier).addComment(commentText);
        break;
      case CommentActions.edit:
        ref.read(postDetailedProvider.notifier).editComment(commentText);
        break;
    }
    _resetInputWidget();
  }

  void _resetInputWidget() {
    ref.read(_commentTextController).clear();
    ref.read(postDetailedProvider.notifier).resetButtonState();
    FocusScope.of(context).unfocus();
  }

  @override
  void deactivate() {
    ref.read(postDetailedProvider.notifier).stopPolling();
    super.deactivate();
  }
}
