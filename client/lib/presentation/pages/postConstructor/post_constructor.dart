import 'package:client/presentation/pages/postConstructor/post_constructor_provider.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'package:client/presentation/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PostActions {
  create,
  edit,
}

class PostConstructor extends ConsumerStatefulWidget {
  final PostActions postAction;
  final String? postId;

  const PostConstructor({
    Key? key,
    required this.postAction,
    this.postId,
  }) : super(key: key);

  @override
  ConsumerState<PostConstructor> createState() => _PostConstructorState();
}

class _PostConstructorState extends ConsumerState<PostConstructor> {
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
          buttonText:
              widget.postAction == PostActions.create ? 'create' : 'edit',
          isButtonActive: ref.watch(addPostProvider).isButtonActive,
          onClick: () {
            final postTitle = _titleTextController.text;
            final postText = _postTextController.text;
            ref
                .read(addPostProvider.notifier)
                .addPost(postTitle, postText)
                .then(
                  (_) => Navigator.pop(context),
                )
                .onError(
                  (error, stackTrace) => showDialog(
                    context: context,
                    builder: (_) => errorDialog(
                      context: context,
                      errorTitle: 'Post error',
                      errorMessage: error.toString(),
                    ),
                    barrierDismissible: true,
                  ),
                );
          },
        ),
      ],
    );
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
        ref.read(addPostProvider.notifier).setButtonActive(
              _titleTextController.value.text,
              _postTextController.value.text,
            )
      },
      controller: controller,
    );
  }
}
