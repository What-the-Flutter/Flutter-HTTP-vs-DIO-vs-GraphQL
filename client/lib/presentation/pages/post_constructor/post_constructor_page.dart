import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:client/presentation/app/theme/base_color_canstatns.dart';
import 'package:client/presentation/pages/home/home_provider.dart';
import 'package:client/presentation/pages/post_constructor/post_constructor_provider.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'package:client/presentation/widgets/text_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PostActions {
  create,
  edit,
}

class PostConstructorPage extends ConsumerStatefulWidget {
  final PostActions postAction;
  final Post? post;

  const PostConstructorPage({
    Key? key,
    required this.postAction,
    this.post,
  }) : super(key: key);

  @override
  ConsumerState<PostConstructorPage> createState() => _PostConstructorPageState();
}

class _PostConstructorPageState extends ConsumerState<PostConstructorPage> {
  final _postTextController = TextEditingController();
  final _titleTextController = TextEditingController();

  @override
  void initState() {
    if (widget.post != null) {
      _titleTextController.text = widget.post!.title;
      _postTextController.text = widget.post!.text;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _postTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      title: Text(widget.postAction == PostActions.create
          ? AppStrings.create(context)
          : AppStrings.edit(context)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 80.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _inputField(
              hintText: AppStrings.title(context),
              controller: _titleTextController,
              maxLines: 2,
            ),
            const SizedBox(
              height: 12.0,
            ),
            _inputField(
              hintText: AppStrings.text(context),
              controller: _postTextController,
              maxLines: 6,
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.all(25.0),
      actions: [
        StateTextButton(
          buttonText: widget.postAction == PostActions.create
              ? AppStrings.create(context)
              : AppStrings.edit(context),
          isButtonActive: ref.watch(postConstructorProvider).isButtonActive,
          onClick: onButtonClick,
        ),
      ],
    );
  }

  void onButtonClick() async {
    final postTitle = _titleTextController.text;
    final postText = _postTextController.text;
    switch (widget.postAction) {
      case PostActions.create:
        ref.read(postConstructorProvider.notifier).addPost(
              title: postTitle,
              text: postText,
              onSuccess: () async {
                await ref.read(homeProvider.notifier).getPosts(_showErrorDialog);
                ref.read(postConstructorProvider.notifier).pop();
              },
              onError: _showErrorDialog,
            );
        break;
      case PostActions.edit:
        ref.read(postConstructorProvider.notifier).editPost(
              postId: widget.post!.id,
              title: postTitle,
              text: postText,
              onSuccess: () async {
                await ref.read(homeProvider.notifier).getPosts(_showErrorDialog);
                ref.read(postConstructorProvider.notifier).pop();
              },
              onError: _showErrorDialog,
            );
        break;
    }
  }

  Widget _inputField({
    required String hintText,
    required TextEditingController controller,
    required int maxLines,
  }) {
    return TextField(
      minLines: 1,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: BaseColors.borderColorBlocked),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: BaseColors.borderColorActive),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: BaseColors.hintTextColor,
        ),
      ),
      onChanged: (_) => {
        ref.read(postConstructorProvider.notifier).setButtonActive(
              _titleTextController.value.text,
              _postTextController.value.text,
            )
      },
      controller: controller,
    );
  }

  void _showErrorDialog() {
    showInfoDialog(
      context: context,
      title: AppStrings.postError(context),
      content: AppStrings.serverErrorDescription(context),
      onButtonClick: ref.read(postConstructorProvider.notifier).pop,
    );
  }
}
