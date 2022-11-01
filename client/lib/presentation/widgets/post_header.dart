import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/app/theme/base_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostHeaderWidget extends StatefulWidget {
  final Post post;

  const PostHeaderWidget({
    super.key,
    required this.post,
  });

  @override
  State<PostHeaderWidget> createState() => _PostHeaderWidgetState();
}

class _PostHeaderWidgetState extends State<PostHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: BaseColors.backgroundColorLight),
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title,
              style: TextStyle(
                color: BaseColors.textColorDark,
                backgroundColor: BaseColors.backgroundHighlightColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              '@${widget.post.authorName}',
              style: TextStyle(
                color: BaseColors.textColorDark,
                backgroundColor: BaseColors.backgroundHighlightColor,
                fontSize: 16.0,
              ),
            ),
            Text(
              DateFormat.yMMMMd('en_US').format(widget.post.date),
              style: TextStyle(
                color: BaseColors.textColorDark,
                backgroundColor: BaseColors.backgroundHighlightColor,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              widget.post.text,
              style: TextStyle(
                color: BaseColors.textColorDark,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
