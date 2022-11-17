import 'dart:convert';

import 'package:client/data/data_sources/interfaces/I_crud.dart';
import 'package:client/data/utils/remote_utils.dart';
import 'package:client/domain/constants/connectivity_constants.dart';
import 'package:http/http.dart' as http;

class HttpCrud implements ICrud {
  final Map<String, String> _header = {'Content-Type': 'application/json'};

  @override
  Future<RestResponseWrapper> delete(String path) async {
    final response = await http.delete(
      Uri.parse('${ConnectivityStrings.baseUrl}$path'),
      headers: _header,
    );
    return RestResponseWrapper(data: response.body, status: response.statusCode);
  }

  @override
  Future<RestResponseWrapper> get(String path) async {
    final response = await http.get(
      Uri.parse('${ConnectivityStrings.baseUrl}$path'),
      headers: _header,
    );
    return RestResponseWrapper(data: response.body, status: response.statusCode);
  }

  @override
  Future<RestResponseWrapper> post(String path, dynamic data) async {
    final response = await http.post(
      Uri.parse('${ConnectivityStrings.baseUrl}$path'),
      headers: _header,
      body: jsonEncode(data),
    );
    return RestResponseWrapper(data: response.body, status: response.statusCode);
  }

  @override
  Future<RestResponseWrapper> put(String path, dynamic data) async {
    final response = await http.put(
      Uri.parse('${ConnectivityStrings.baseUrl}$path'),
      headers: _header,
      body: jsonEncode(data),
    );
    return RestResponseWrapper(data: response.body, status: response.statusCode);
  }
}
