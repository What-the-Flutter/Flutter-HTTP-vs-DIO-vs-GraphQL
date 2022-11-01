import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/presentation/app/theme/base_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCardWidget extends StatefulWidget {
  final Comment comment;
  final bool isSlidable;
  final Function? onDeleteButtonPressed;
  final Function? onEditButtonPressed;

  const CommentCardWidget({
    Key? key,
    required this.comment,
    required this.isSlidable,
    this.onDeleteButtonPressed,
    this.onEditButtonPressed,
  }) : super(key: key);

  @override
  State<CommentCardWidget> createState() => _CommentCardWidgetState();
}

class _CommentCardWidgetState extends State<CommentCardWidget> {
  bool _showFullComment = false;
  bool _commentActionsState = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: widget.isSlidable ? BaseColors.backgroundHighlightColor : BaseColors.cardColor,
        elevation: 1.0,
        shadowColor: BaseColors.customShadowColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: BaseColors.borderColorBlocked),
          borderRadius: BorderRadius.circular(
            6.0,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showFullComment = !_showFullComment;
              _commentActionsState = false;
            });
          },
          onLongPress: () {
            if (widget.isSlidable) {
              setState(() {
                _commentActionsState = !_commentActionsState;
              });
            }
          },
          child: ListTile(
            title: _commentActionsState
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        color: BaseColors.editButtonColor,
                        onPressed: () {
                          widget.onEditButtonPressed!();
                          _commentActionsState = false;
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        color: BaseColors.deleteButtonColor,
                        onPressed: () {
                          widget.onDeleteButtonPressed!();
                          _commentActionsState = false;
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@${widget.comment.authorName}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMMd('en_US').format(widget.comment.date),
                        style: TextStyle(
                          color: BaseColors.textColorDark,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
            subtitle: _commentActionsState
                ? null
                : Text(
                    overflow: _showFullComment ? null : TextOverflow.fade,
                    maxLines: _showFullComment ? null : 3,
                    softWrap: true,
                    widget.comment.text,
                    style: TextStyle(
                      color: BaseColors.textColorCustom,
                      fontSize: 16.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
