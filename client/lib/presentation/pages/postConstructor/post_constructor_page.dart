import 'package:client/presentation/pages/home/home_provider.dart';
import 'package:client/presentation/pages/postConstructor/post_constructor_provider.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'package:client/presentation/widgets/networking_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PostActions {
  create,
  edit,
}

class PostConstructorPage extends ConsumerStatefulWidget {
  final PostActions postAction;
  final String? postId;

  const PostConstructorPage({
    Key? key,
    required this.postAction,
    this.postId,
  }) : super(key: key);

  @override
  ConsumerState<PostConstructorPage> createState() => _PostConstructorPageState();
}

class _PostConstructorPageState extends ConsumerState<PostConstructorPage> {
  final _postTextController = TextEditingController();
  final _titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      title: const Text('New post'),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _inputField(
              hintText: 'Title',
              controller: _titleTextController,
            ),
            const SizedBox(
              height: 12,
            ),
            _inputField(
              hintText: 'Text',
              controller: _postTextController,
            ),
          ],
        ),
      ),
      actions: [
        NetworkingTextButton(
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
        // TODO: Handle this case.
        break;
    }
  }

  Widget _inputField({
    required String hintText,
    required TextEditingController controller,
  }) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
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
