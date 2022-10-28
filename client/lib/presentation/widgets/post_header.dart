import 'package:client/domain/entities/post/post.dart';
import 'package:client/presentation/app/theme/base_color_canstatns.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostHeaderWidget extends StatefulWidget {
  final Post post;
  final bool showHeaderAdditionalInfo;

  const PostHeaderWidget({
    super.key,
    required this.post,
    required this.showHeaderAdditionalInfo,
  });

  @override
  State<PostHeaderWidget> createState() => _PostHeaderWidgetState();
}

class _PostHeaderWidgetState extends State<PostHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: BaseColors.backgroundColorLight),
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Stack(
        fit: StackFit.loose,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.post.text,
              style: TextStyle(
                color: BaseColors.textColorDark,
                fontSize: 16.0,
              ),
            ),
          ),
          Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            child: AnimatedOpacity(
              opacity: widget.showHeaderAdditionalInfo ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: BaseColors.backgroundHighlightColor,
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.post.title,
                      style: TextStyle(
                        color: BaseColors.textColorDark,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
