// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      id: json['id'] as String,
      userId: json['userId'] as String,
      authorName: json['authorName'] as String,
      text: json['text'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      commentCount: json['commentCount'] as int? ?? 0,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'authorName': instance.authorName,
      'text': instance.text,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'commentCount': instance.commentCount,
    };
