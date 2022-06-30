import 'dart:io';

import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:dio/dio.dart';

class NetworkApiService {
  final Dio _dio = Dio();
  final String baseUrl = "https://jsonplaceholder.typicode.com/posts";
  Future<Object> getRequest(
      {String subUrl = "", Map<String, dynamic> params = const {}}) async {
    var responseJson;

    String url = "$baseUrl$subUrl";
    print(url);
    try {
      Response response = await _dio.get(url, queryParameters: params);
      responseJson = _returnResponse(response);
    } on DioError catch (e) {
      print(e.error);
      if (e is SocketException) {
        throw Failure("Network Error .Please Check Your Internet Connection");
      } else {
        throw Failure(e.toString());
      }
    } catch (e) {
      throw Failure(e.toString());
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 400:
        throw Failure("BadRequestException : ${response.data?.toString()}");
      case 401:
      case 403:
        throw Failure("UnauthorisedException : ${response.data?.toString()} ");
      case 500:
      default:
        throw Failure(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
