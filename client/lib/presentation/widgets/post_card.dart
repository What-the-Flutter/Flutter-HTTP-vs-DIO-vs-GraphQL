import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:client/presentation/app/theme/base_color_constants.dart';
import 'package:client/presentation/pages/post_constructor/post_constructor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class PostCardWidget extends StatelessWidget {
  final Post post;
  final bool isSlidable;
  final VoidCallback onDeleteButtonPressed;
  final VoidCallback onTap;

  const PostCardWidget({
    Key? key,
    required this.post,
    required this.isSlidable,
    required this.onDeleteButtonPressed,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: isSlidable,
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          const SizedBox(
            width: 2,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(16),
            onPressed: (_) => showDialog(
              context: context,
              builder: (context) => PostConstructorPage(
                postAction: PostActions.edit,
                post: post,
              ),
            ),
            backgroundColor: BaseColors.editButtonColor,
            foregroundColor: BaseColors.textColorLight,
            icon: Icons.edit,
            label: AppStrings.edit(context),
          ),
          const SizedBox(
            width: 2,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(16),
            onPressed: (_) => onDeleteButtonPressed(),
            backgroundColor: BaseColors.deleteButtonColor,
            foregroundColor: BaseColors.textColorLight,
            icon: Icons.delete,
            label: AppStrings.delete(context),
          ),
        ],
      ),
      child: Card(
        elevation: 8,
        shadowColor: BaseColors.customShadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        post.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd('en_US').format(post.date),
                      style: TextStyle(
                        color: BaseColors.textColorDark,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '@${post.authorName}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'comments: ${post.commentCount}',
                      style: TextStyle(
                        color: BaseColors.textColorDark,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          subtitle: Text(
            post.text,
            overflow: TextOverflow.fade,
            maxLines: 3,
            softWrap: true,
            style: TextStyle(
              color: BaseColors.textColorCustom,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
