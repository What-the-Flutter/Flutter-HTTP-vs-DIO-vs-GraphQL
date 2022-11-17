import 'package:client/data/utils/remote_utils.dart';

abstract class ICrud<T> {
  Future<RestResponseWrapper> post(String path, dynamic data);
  Future<RestResponseWrapper> get(String path);
  Future<RestResponseWrapper> put(String path, dynamic data);
  Future<RestResponseWrapper> delete(String path);
}
