import 'dart:convert';

import 'package:client/data/data_sources/interfaces/I_crud.dart';
import 'package:client/domain/constants/connectivity_constants.dart';
import 'package:client/domain/entities/api_object.dart';
import 'package:http/http.dart' as http;

class HttpCrud implements ICrud {
  final Map<String, String> _header = {'Content-Type': 'application/json'};

  @override
  Future<http.Response> delete(String path) {
    return http.delete(
      Uri.parse('${ConnectivityStrings.baseUrl}$path'),
      headers: _header,
    );
  }

  @override
  Future<http.Response> get(String path) {
    return http.get(
      Uri.parse('${ConnectivityStrings.baseUrl}$path'),
      headers: _header,
    );
  }

  @override
  Future<http.Response> post(String path, ApiObject data) {
    return http.post(
      Uri.parse('${ConnectivityStrings.baseUrl}$path'),
      headers: _header,
      body: jsonEncode(data),
    );
  }

  @override
  Future<http.Response> put(String path, ApiObject data) {
    return http.put(
      Uri.parse('${ConnectivityStrings.baseUrl}$path'),
      headers: _header,
      body: jsonEncode(data),
    );
  }
}
