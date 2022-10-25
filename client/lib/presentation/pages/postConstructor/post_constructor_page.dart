import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/pages/home/home_provider.dart';
import 'package:client/presentation/pages/postConstructor/post_constructor_provider.dart';
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
      title: Text(widget.postAction == PostActions.create ? 'New post' : 'Edit'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 80.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _inputField(
              hintText: 'Title',
              controller: _titleTextController,
              maxLines: 2,
            ),
            const SizedBox(
              height: 12.0,
            ),
            _inputField(
              hintText: 'Text',
              controller: _postTextController,
              maxLines: 6,
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.all(25.0),
      actions: [
        StateTextButton(
          buttonText: widget.postAction == PostActions.create ? 'Create' : 'Edit',
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
                await ref.read(homeProvider.notifier).getPosts();
                ref.read(postConstructorProvider.notifier).pop();
              },
              onError: () => showInfoDialog(
                context: context,
                title: 'Post error',
                content: 'Error occurred while creating the post',
                onButtonClick: ref.read(postConstructorProvider.notifier).pop,
              ),
            );
        break;
      case PostActions.edit:
        ref.read(postConstructorProvider.notifier).editPost(
              postId: widget.post!.id,
              title: postTitle,
              text: postText,
              onSuccess: () async {
                await ref.read(homeProvider.notifier).getPosts();
                ref.read(postConstructorProvider.notifier).pop();
              },
              onError: () => showInfoDialog(
                context: context,
                title: 'Post error',
                content: 'Error occurred while editing the post',
                onButtonClick: ref.read(postConstructorProvider.notifier).pop,
              ),
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
          borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.0, color: Color(0xff2da9ef)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
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
}
