import 'dart:convert';

import 'package:client/domain/constants/connectivity_constants.dart';
import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class WrongUserDataException implements Exception {}

class RestResponseWrapper {
  final dynamic data;
  final int status;
  final Type _type =
      ConnectivityStrings.networkModule == NetworkModule.http.name ? http.Response : dio.Response;

  RestResponseWrapper({required this.data, this.status = 200});

  bool isSuccessful() => status >= 200 && status < 400;

  bool wrongUserData() => status >= 400 && status < 500;

  T? retrieveResult<T>() {
    if (isSuccessful()) {
      if (data.isNotEmpty && data != 'OK') {
        if (_type == http.Response) {
          return _createFromJSON<T>(json.decode(data.toString()))!;
        } else {
          return _createFromJSON<T>(data)!;
        }
      } else {
        return null;
      }
    } else if (wrongUserData()) {
      throw WrongUserDataException();
    } else {
      throw Exception();
    }
  }

  List<T> retrieveResultAsList<T>() {
    if (isSuccessful()) {
      if (_type == http.Response) {
        return (json.decode(data.toString()) as List).map((e) => (_createFromJSON<T>(e)!)).toList();
      } else {
        return (data as List).map((e) => (_createFromJSON<T>(e)!)).toList();
      }
    } else {
      throw Exception();
    }
  }
}

//Extension for GraphQL response
extension ResponseTo on QueryResult {
  T? retrieveResult<T>({String? tag}) {
    T? result;
    if (exception != null) {
      throw Exception('Error: ${exception.toString()}');
    } else {
      if (tag != null) {
        result = data![tag] == null
            ? null
            : data![tag]['error'] != null
                ? throw WrongUserDataException()
                : _createFromJSON<T>(data![tag]);
      }
      return result;
    }
  }

  List<T> retrieveResultAsList<T>({required String tag}) {
    List<T> result;
    if (exception != null) {
      throw Exception('Error: ${exception.toString()}');
    } else {
      result = (data![tag] as List).map((e) => (_createFromJSON<T>(e)!)).toList();
      return result;
    }
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
