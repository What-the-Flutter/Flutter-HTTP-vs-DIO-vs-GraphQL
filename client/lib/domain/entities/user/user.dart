import 'package:client/domain/entities/api_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User implements ApiObject {
  const factory User({
    required String id,
    required String name,
    String? password,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
