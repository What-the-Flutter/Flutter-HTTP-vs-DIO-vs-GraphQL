import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@freezed
class CreateUserModel with _$CreateUserModel {
  const factory CreateUserModel({
    required String name,
    required String password,
  }) = _CreateUserModel;

  factory CreateUserModel.fromJson(Map<String, Object?> json) => _$CreateUserModelFromJson(json);
}
