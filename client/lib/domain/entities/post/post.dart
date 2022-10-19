import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post{
  const factory Post({
    required String id,
    required String userId,
    required String authorName,
    required String text,
    required String title,
    required DateTime date,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
