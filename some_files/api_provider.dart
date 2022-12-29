import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../storage/storage.dart';

/*
 * 
 */
class ApiProvider {
  late Dio _dio;
  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: false,
        baseUrl: EndPoints.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        
      ),
    );
    _dio.interceptors.add(LogInterceptor( request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        
        ));
       _dio.interceptors.add(InterceptorsWrapper(
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
        ),);
  }

//Below method is used to get data from API.
  Future<Map<String, dynamic>> get(
      {required String url, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.get(url, queryParameters: queryParameters);
      final Map<String, dynamic> responseData = classifyResponse(response);
      if (responseData is List) {
        return {"result": responseData};
      }
      return responseData;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

//Below method is used to post data.
  Future<Map<String, dynamic>> post(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body}) async {
    try {
      Response response =
          await _dio.post(url, queryParameters: queryParameters, data: body);
      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Map<String, dynamic> classifyResponse(Response response) {
    final Map<String, dynamic> responseData = response.data is List
        ? {"result": response.data}
        : response.data as Map<String, dynamic>;
    return responseData;
    // switch (response.statusCode) {
    //   case HttpStatusCode.ok:
    //     return responseData;
    //   case HttpStatusCode.badRequest:
    //     throw Exception(responseData["message"].toString());
    //   case HttpStatusCode.unauthorized:
    //     throw Exception(responseData["message"].toString());
    //   case HttpStatusCode.notFound:
    //     throw Exception(responseData["message"].toString());
    //   case HttpStatusCode.methodNotAllowed:
    //     throw Exception(responseData["message"].toString());
    //   case HttpStatusCode.serverError:
    //     throw Exception(responseData["message"].toString());
    //   default:
    //     throw Exception(
    //       'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
    //     );
    // }
  }
}
