import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'cashed_helper.dart';

class DioHelper {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://thimar.amr.aait-d.com/api/",
    ),
  );
  Future<CustomResponse> sendData(
      {required String endPoint, Map<String, dynamic>? data,bool haveToken=false}) async {
    Map<String, dynamic>? headers={
      "Accept":"application/json",
      "Accept-Language":    CachedHelper. getCachedLanguageCode()

    };
    if(haveToken){
      headers.addAll({
        "Authorization": "Bearer ${CachedHelper.getToken()}",
      });
    }
    try {
      final response = await dio.post(endPoint, data: data,
        options: Options(
          headers: headers,
        )
      );
      debugPrint('$endPoint is Success ${response.data}');
      debugPrint(' ${response.data?['message']}');
      debugPrint('state code is ${response.statusCode}');
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: response.data['message'] ?? 'Success',
      );
    } on DioException catch (e) {
      debugPrint('*' * 50);
      debugPrint('$endPoint is Error ${e.response?.data}');
      debugPrint('*' * 50);

      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message'].toString()??'Network Error',
      );
    }
  }
  Future<CustomResponse> upDateData(
      {required String endPoint, Map<String, dynamic>? data,bool haveToken=false}) async {
    Map<String, dynamic>? headers={
      "Accept":"application/json",
      "Accept-Language":    CachedHelper. getCachedLanguageCode()

    };
    if(haveToken){
      headers.addAll({
        "Authorization": "Bearer ${CachedHelper.getToken()}",
      });
    }
    try {
      final response = await dio.put(endPoint, data: data,
        options: Options(
          headers: headers,
        )
      );
      debugPrint('$endPoint is Success ${response.data}');
      debugPrint(' ${response.data?['message']}');
      debugPrint('state code is ${response.statusCode}');
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: response.data['message'] ?? 'Success',
      );
    } on DioException catch (e) {
      debugPrint('*' * 50);
      debugPrint('$endPoint is Error ${e.response?.data}');
      debugPrint('*' * 50);

      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message'].toString()??'Network Error',
      );
    }
  }

  Future<CustomResponse> getData(
      {required String endPoint, Map<String, dynamic>? data,bool haveToken=false}) async {
    Map<String, dynamic>? headers=
    {
      "Accept":"application/json",
      "Accept-Language":    CachedHelper. getCachedLanguageCode()

    };
    if(haveToken){
      headers.addAll({
        "Authorization": "Bearer ${CachedHelper.getToken()}",
      });
    }
    try {
      final response = await dio.get(endPoint, queryParameters: data,
        options: Options(
          headers: headers,
        ),);
      debugPrint('$endPoint is Success ${response.data}');
      debugPrint('*' * 50);
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: response.data['message'] ?? 'Success',
      );
    } on DioException catch (e) {
      debugPrint('$endPoint is Error ${e.response?.data}');
      debugPrint('*' * 50);
      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message'] ?? 'Error',
      );
    }
  }

  Future<CustomResponse> deleteData(
      {required String endPoint, Map<String, dynamic>? data,bool haveToken=false}) async {
    Map<String, dynamic>? headers={
      "Accept":"application/json",
      "Accept-Language":    CachedHelper. getCachedLanguageCode()

    };
    if(haveToken){
      headers.addAll({
        "Authorization": "Bearer ${CachedHelper.getToken()}",
      });
    }
    try {
      final response = await dio.delete(endPoint, queryParameters: data,
        options: Options(
          headers: headers,
        ),);
      debugPrint('$endPoint is Success ${response.data}');
      debugPrint('*' * 50);
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: response.data['message'] ?? 'Success',
      );
    } on DioException catch (e) {
      debugPrint('$endPoint is Error ${e.response?.data}');
      debugPrint('*' * 50);
      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message'] ?? 'Error',
      );
    }
  }


}

class CustomResponse {
  final Response? response;
  final String message;
  final bool isSuccess;

  CustomResponse({
    this.response,
    required this.isSuccess,
    required this.message,
  });
}
