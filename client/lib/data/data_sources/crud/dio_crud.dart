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
  Future<RestResponseWrapper> post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data.toJson());
      return RestResponseWrapper(data: response.data);
    } on DioError catch (e) {
      throw _getExceptionByStatusCode(e);
    }
  }

  @override
  Future<RestResponseWrapper> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return RestResponseWrapper(data: response.data);
    } on DioError catch (e) {
      throw _getExceptionByStatusCode(e);
    }
  }

  @override
  Future<RestResponseWrapper> get(String path) async {
    try {
      final response = await _dio.get(path);
      return RestResponseWrapper(data: response.data);
    } on DioError catch (e) {
      throw _getExceptionByStatusCode(e);
    }
  }

  @override
  Future<RestResponseWrapper> put(String path, dynamic data) async {
    try {
      final response = await _dio.put(path, data: data.toJson());
      return RestResponseWrapper(data: response.data);
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
