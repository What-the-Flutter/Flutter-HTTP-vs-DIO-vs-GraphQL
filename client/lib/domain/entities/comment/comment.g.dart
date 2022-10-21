// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      authorName: json['authorName'] as String,
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'postId': instance.postId,
      'authorName': instance.authorName,
      'text': instance.text,
      'date': instance.date.toIso8601String(),
    };

_$_CreateCommentModel _$$_CreateCommentModelFromJson(
        Map<String, dynamic> json) =>
    _$_CreateCommentModel(
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      authorName: json['authorName'] as String,
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$_CreateCommentModelToJson(
        _$_CreateCommentModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'postId': instance.postId,
      'authorName': instance.authorName,
      'text': instance.text,
      'date': instance.date.toIso8601String(),
    };
