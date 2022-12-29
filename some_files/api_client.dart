import "package:dio/dio.dart";
import 'package:flutter/foundation.dart';
import '../storage/storage.dart';
import '../utils/constants/constants.dart';


class Client {

  static Dio provideDio() {
     final dio = Dio();

    dio
      ..options.baseUrl = EndPoints.baseUrl
      ..options.connectTimeout = Constants.connectionTimeout
      ..options.receiveTimeout = Constants.receiveTimeout
      ..options.headers = {Constants.contentType: Constants.contentTypeValue}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            // getting token
            if (Storage.hasData("token")) {
              var token = Storage.getValue("token");
              if (kDebugMode) {
                debugPrint('token_value :' + token!);
              }
              if (token != null) {
                options.headers["Authorization"] = "Bearer " + token;
                //  .putIfAbsent('Authorization', () => "Bearer " + token);
              } else {
                if (kDebugMode) {
                  print('Auth token is not required');
                }
              }
            }

            return handler.next(options);
          },
        ),
      );

    return dio;
  }
}

class Logging extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
