import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment{
  const factory Comment({
    required String id,
    required String userId,
    required String postId,
    required String authorName,
    required String text,
    required DateTime date,
  })  = _Comment;

  factory Comment.fromJson(Map<String, Object?> json) => _$CommentFromJson(json);
}
