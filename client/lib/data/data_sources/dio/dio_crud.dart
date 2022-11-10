import 'package:client/data/data_sources/interfaces/I_crud.dart';
import 'package:client/data/utils/remote_utils.dart';
import 'package:client/domain/constants/connectivity_constants.dart';
import 'package:dio/dio.dart';

class DioCrud implements ICrud {
  final _dio = Dio();

  DioCrud() {
    _dio.options.baseUrl = ConnectivityStrings.baseUrl;
  }

  @override
  Future<Response> post(path, data) async {
    try {
      return await _dio.post(path, data: data.toJson());
    } on DioError catch (e) {
      throw _getExceptionByStatusCode(e);
    }
  }

  @override
  Future<Response> delete(path) async {
    try {
      return await _dio.delete(path);
    } on DioError catch (e) {
      throw _getExceptionByStatusCode(e);
    }
  }

  @override
  Future<Response> get(path) async {
    try {
      return await _dio.get(path);
    } on DioError catch (e) {
      throw _getExceptionByStatusCode(e);
    }
  }

  @override
  Future<Response> put(path, data) async {
    try {
      return await _dio.put(path, data: data.toJson());
    } on DioError catch (e) {
      throw _getExceptionByStatusCode(e);
    }
  }

  Exception _getExceptionByStatusCode(DioError e) {
    return e.response?.statusCode == 401 || e.response?.statusCode == 409
        ? WrongUserDataException()
        : Exception('Error: ${e.response?.statusMessage} \n Error code: ${e.response?.statusCode}');
  }
}
