import 'package:client/domain/entities/api_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post.freezed.dart';

part 'post.g.dart';

@freezed
class Post with _$Post implements ApiObject {
  const factory Post({
    required String id,
    required String userId,
    required String authorName,
    required String text,
    required String title,
    required DateTime date,
    @Default(0) int commentCount,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}

@freezed
class CreatePostModel with _$CreatePostModel implements ApiObject {
  const factory CreatePostModel({
    required String userId,
    required String authorName,
    required String text,
    required String title,
    required DateTime date,
    @Default(0) int commentCount,
  }) = _CreatePostModel;

  factory CreatePostModel.fromJson(Map<String, Object?> json) => _$CreatePostModelFromJson(json);
}
