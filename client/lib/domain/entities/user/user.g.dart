// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$_CreateUserModel _$$_CreateUserModelFromJson(Map<String, dynamic> json) =>
    _$_CreateUserModel(
      name: json['name'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$_CreateUserModelToJson(_$_CreateUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
    };
