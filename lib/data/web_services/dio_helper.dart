import 'package:dio/dio.dart';

import '../../presentation/constants/strings.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoints.baseURl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? '',
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
