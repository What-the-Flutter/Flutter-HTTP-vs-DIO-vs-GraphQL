import 'package:client/presentation/pages/postConstructor/post_constructor_provider.dart';
import 'package:client/presentation/widgets/error_dialog.dart';
import 'package:client/presentation/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPostPage extends ConsumerStatefulWidget {
  const AddPostPage({super.key});

  @override
  ConsumerState<AddPostPage> createState() => AddPostPageState();
}

class AddPostPageState extends ConsumerState<AddPostPage> {
  final _postTextController = TextEditingController();
  final _titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _inputField(
              hintText: 'Title',
              controller: _titleTextController,
            ),
            _inputField(
              hintText: 'Text',
              controller: _postTextController,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NetworkingTextButton(
                  buttonText: 'create',
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
            )
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required String hintText,
    required TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: hintText),
        onChanged: (_) => {
          ref.read(addPostProvider.notifier).setButtonActive(
                _titleTextController.value.text,
                _postTextController.value.text,
              )
        },
        controller: controller,
        textAlign: TextAlign.start,
      ),
    );
  }
}
