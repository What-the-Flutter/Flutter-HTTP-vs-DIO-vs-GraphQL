import 'dart:convert';

import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

extension DioResponseTo on dio.Response {
  T? retrieveResult<T>() {
    return data.isNotEmpty ? _createFromJSON<T>(data)! : null;
  }

  List<T> retrieveResultAsList<T>() {
    return (data as List).map((e) => (_createFromJSON<T>(e)!)).toList();
  }
}

extension HttpResponseTo on http.Response {
  bool isSuccessful() => statusCode == 200 || statusCode == 201 || statusCode == 204;

  T? retrieveResult<T>() {
    T? result;
    if (isSuccessful()) {
      return body == 'OK'
          ? result
          : body.isNotEmpty
              ? _createFromJSON<T>(json.decode(body.toString()))!
              : null;
    } else {
      throw Exception('Error: $reasonPhrase \n Error code: $statusCode');
    }
  }

  List<T> retrieveResultAsList<T>() {
    List<T> result;
    if (isSuccessful()) {
      result = (json.decode(body.toString()) as List).map((e) => (_createFromJSON<T>(e)!)).toList();
      return result;
    }
    throw Exception('Error: $reasonPhrase \n Error code: $statusCode');
  }
}

T? _createFromJSON<T>(Map<String, dynamic> json) {
  Type typeOf<V>() => V;
  final type = typeOf<T>();
  if (type == typeOf<User>()) {
    return User.fromJson(json) as T;
  } else if (type == typeOf<Post>()) {
    return Post.fromJson(json) as T;
  } else if (type == typeOf<Comment>()) {
    return Comment.fromJson(json) as T;
  } else if (typeOf<dynamic>() == type || typeOf<void>() == type) {
    return null;
  }
  throw ArgumentError('Looks like you forgot to add processing for type ${type.toString()}');
}
