import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment{
  const factory Comment({
    required int id,
    required int userId,
    required int postId,
    required String authorName,
    required String text,
    required DateTime date,
  })  = _Comment;

  factory Comment.fromJson(Map<String, Object?> json) => _$CommentFromJson(json);
}
