import 'package:dio/dio.dart';

class DioHelper {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://thimar.amr.aait-d.com/api/",
    ),
  );
  Future<CustomResponse> sendData(
      {required String endPoint, Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(endPoint, data: data);
      print('$endPoint is Success ${response.data}');
      print('state code is ${response.statusCode}');
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: "Success",
      );
    } on DioException catch (e) {
      print('$endPoint is Error ${e.response?.data}');
      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message']??'Network Error',
      );
    }
  }

  Future<CustomResponse> getData(
      {required String endPoint, Map<String, dynamic>? data}) async {
    try {
      final response = await dio.get(endPoint, queryParameters: data);
      print('$endPoint is Success ${response.data}');
      print('*' * 50);
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: "Success",
      );
    } on DioException catch (e) {
      print('$endPoint is Error ${e.response?.data}');
      print('*' * 50);
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
