import 'package:client/domain/entities/comment/comment.dart';
import 'package:client/domain/entities/post/post.dart';
import 'package:client/domain/entities/user/user.dart';
import 'package:dio/dio.dart';

extension ResponseTo on Response {
  bool isSuccessful() => statusCode == 200 || statusCode == 201 || statusCode == 204;

  T? retrieveResult<T>() {
    T? result;
    if (isSuccessful()) {
      result = data.isNotEmpty ? _createFromJSON<T>(data)! : null;
      return result;
    } else {
      throw Exception('Ошибка: $statusCode \n Код ошибки: $statusCode');
    }
  }

  List<T> retrieveResultAsList<T>() {
    List<T> result;
    if (isSuccessful()) {
      var a = (data as List).map((e) => (_createFromJSON<T>(e)!)).toList();
      result = a;
      return result;
    }
    //TODO: replace code to message
    throw Exception('Ошибка: $statusCode \n Код ошибки: $statusCode');
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
  } else {
    final parseTypes = [int, String, double];
    if (json.isNotEmpty && json.length == 1) {
      for (var parseType in parseTypes) {
        if (parseType == type) {
          return json[json.keys.first];
        }
      }
    }
    if (typeOf<dynamic>() == type || typeOf<void>() == type) {
      return null;
    }
  }
  throw ArgumentError('Looks like you forgot to add processing for type ${type.toString()}');
}
