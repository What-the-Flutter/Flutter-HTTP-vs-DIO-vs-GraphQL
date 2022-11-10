import 'package:client/domain/entities/api_object.dart';

abstract class ICrud<T extends ApiObject> {
  Future<dynamic> post(String path, T data);
  Future<dynamic> get(String path);
  Future<dynamic> put(String path, T data);
  Future<dynamic> delete(String path);
}