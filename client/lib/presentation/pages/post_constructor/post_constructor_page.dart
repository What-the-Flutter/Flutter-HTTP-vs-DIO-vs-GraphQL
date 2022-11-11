import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:client/presentation/app/theme/base_color_constants.dart';
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

final _postTextController = Provider((ref) => TextEditingController());
final _titleTextController = Provider((ref) => TextEditingController());

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
  @override
  void initState() {
    if (widget.post != null) {
      ref.read(_titleTextController).text = widget.post!.title;
      ref.read(_postTextController).text = widget.post!.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ref.listen(postConstructorProvider, (previous, next) {
      if (next.showServerErrorMessage) {
        _showErrorDialog();
      }
    });
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
        width: size.width - 80,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _inputField(
                hintText: AppStrings.title(context),
                controller: ref.read(_titleTextController),
                maxLines: (size.height > 700) ? 2 : 1,
              ),
              const SizedBox(
                height: 12.0,
              ),
              _inputField(
                hintText: AppStrings.text(context),
                controller: ref.read(_postTextController),
                maxLines: (size.height > 700) ? 5 : 1,
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(25.0),
      actions: [
        NetworkingTextButton(
          buttonText: widget.postAction == PostActions.create
              ? AppStrings.create(context)
              : AppStrings.edit(context),
          isButtonActive: ref.watch(postConstructorProvider).isButtonActive,
          onClick: _onButtonClick,
          margin: 0,
        ),
      ],
    );
  }

  void _onButtonClick() async {
    final postTitle = ref.read(_titleTextController).text.trim();
    final postText = ref.read(_postTextController).text.trim();
    switch (widget.postAction) {
      case PostActions.create:
        ref.read(postConstructorProvider.notifier).addPost(
              title: postTitle,
              text: postText,
              onSuccess: _resetPage,
            );
        break;
      case PostActions.edit:
        ref.read(postConstructorProvider.notifier).editPost(
              postId: widget.post!.id,
              title: postTitle,
              text: postText,
              onSuccess: _resetPage,
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
              ref.read(_titleTextController).value.text,
              ref.read(_postTextController).value.text,
            )
      },
      controller: controller,
    );
  }

  void _resetPage() async {
    await ref.read(homeProvider.notifier).getPosts();
    ref.read(postConstructorProvider.notifier).pop();
    ref.read(_titleTextController).clear();
    ref.read(_postTextController).clear();
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
