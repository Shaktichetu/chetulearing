import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:project_architech/network/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/strings.dart';
import '../common/utility.dart';
import '../response/avilable_barrier_list_response.dart';
import '../response/barrier_code_response.dart';
import '../response/dashboard_response.dart';
import '../response/eventlist_response.dart';
import '../response/forgot_response.dart';
import '../response/group_by_response.dart';
import '../response/login_response.dart';
import '../response/otp_response.dart';
import '../response/progress_update_response.dart';
import '../response/reset_password_response.dart';
import '../response/token_response.dart';
import '../sharedpref/constants/preferences.dart';
import 'dio_error_util.dart';
import 'package:flutter/material.dart';

class UserApiProvider {
  Dio _dio = Dio();

  UserApiProvider() {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          // getting token
          var accessToken = preferences.getString(Preferences.auth_token);
          var token = "Bearer " + accessToken!;

          if (token != null) {
            options.headers.putIfAbsent('Authorization', () => token);
          } else {
            print('Auth token is null');
          }

          return handler.next(options);
        },
      ));
  }

  // Dio without header
  final Dio _dioWithOutHeader = Dio()
    ..options.baseUrl = Endpoints.baseUrl
    ..options.connectTimeout = Endpoints.connectionTimeout
    ..options.receiveTimeout = Endpoints.receiveTimeout
    ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
    ..interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));

  // method defined to check internet connectivity
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  // method is used for login purpose
  Future<LoginResponse?> login(String userName, String password) async {
    Response? response;
    try {
      response = await _dioWithOutHeader.post(Endpoints.login_api,
          data: {"UserName": userName, "Password": password});

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        var data = response.data;
        Hive.box(Strings.API_BOX).put('posts', data);
        return LoginResponse.fromJson(response.data);
      }
      return null;
    } catch (error, stacktrace) {
      EasyLoading.dismiss();

      print("Exception occured: $error stackTrace: $stacktrace");

      String msg = DioErrorUtil.handleError(error as DioError);
      Utility.showToast(msg);

      // }
    }
  }

  // method is used for forgot api
  Future<ForgotResponse?> forgotApi(String email) async {
    try {
      Response response = await _dioWithOutHeader
          .post(Endpoints.forgot_api, data: {"UserName": email});
      return ForgotResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  // method is used for add update api
  Future<dynamic?> addUpdateBarrier(
      String activityId,
      int userId,
      String barrierCode,
      String delayTime,
      String barrierDescription,
      String wbscode,
      String timeStamp,
      bool isDelete,
      bool isEditable) async {
    try {
      Response response =
          await _dio.post(Endpoints.add_barrier_code_api, data: {
        "activityId": activityId,
        "userId": userId,
        "barrierCode": barrierCode,
        "delayTime": delayTime,
        "barrierDescription": barrierDescription,
        "wbscode": wbscode,
        "timeStamp": timeStamp,
        "isDelete": isDelete,
        "isEditable": isEditable
      });


      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401) {
        Utility.showLoaderForError(Strings.session_expire);
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }
  // method is used for delete api
  Future<dynamic?> deleteBarrierActivity(
      String activityId,
     ) async {
    try {
      Response response =
          await _dio.post(Endpoints.delete_barrier_api, queryParameters: {
        "activityId": activityId,
      });
      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401) {
       Utility.showLoaderForError(Strings.session_expire);
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  // method is used for update barrier code api
  Future<dynamic?> UpdateBarrier(
      int id,
      String activityId,
      int userId,
      String barrierCode,
      String delayTime,
      String barrierDescription,
      String wbscode,
      String timeStamp,
      bool isDelete,
      bool isEditable) async {
    try {
      Response response =
          await _dio.post(Endpoints.update_barrier_code_api, data: {
        "id": id,
        "activityId": activityId,
        "userId": userId,
        "barrierCode": barrierCode,
        "delayTime": delayTime,
        "barrierDescription": barrierDescription,
        "wbscode": wbscode,
        "timeStamp": timeStamp,
        "isDelete": isDelete,
        "isEditable": isEditable
      });
      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401) {
         Utility.showLoaderForError(Strings.session_expire);
       // Utility.getRefreshToken();
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }
  // method is used for  update api
  Future<dynamic?> updateTask(
      String id,int activityInPercentComplete,String actualStartDate,String? actualFinishDate) async {
    try {
      Response response =
          await _dio.post(Endpoints.update_task_api, data: {
        "activityId": id,
        "activityInPercentComplete": activityInPercentComplete,
        "actualStartDate": actualStartDate,
        "actualFinishDate": actualFinishDate,

      });
      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      // Utility.getRefreshToken();
      if (error.response!.statusCode == 401) {
        Utility.showLoaderForError(Strings.session_expire);
        // Utility.getRefreshToken();
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  // method is used for getBarrierCodeApi api
  Future<BarrierCodeResponse?> getBarrierCodeApi() async {
    try {
      Response response = await _dio.get(Endpoints.barrier_code_api);
      return BarrierCodeResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401) {
         Utility.showLoaderForError(Strings.session_expire);
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  // method is used for Otp api
  Future<OTPResponse?> otpApi(String email, String otp) async {
    try {
      Response response = await _dioWithOutHeader
          .post(Endpoints.otp_api, data: {"userName": email, "otp": otp});
      return OTPResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  // method is used for Otp api
  Future<ResetPasswordResponse?> resetApi(
      String email, String password, String repassword) async {
    try {
      Response response = await _dioWithOutHeader.post(Endpoints.reset_api,
          data: {
            "userName": email,
            "password": password,
            "confirmPassword": repassword
          });
      return ResetPasswordResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  Future<DashboardResponse?> activityApi(String userId,int idEvent) async {
    try {
      Response response = await _dio
          .post(Endpoints.activity_api, data: {"userId": int.parse(userId),"eventId": idEvent});
      var data = response.data;
      Hive.box(Strings.dashboard_data_local).put('DashboardData', data);
      return DashboardResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401 || error.response!.statusCode == 500 ) {
        Utility.showLoaderForError(Strings.session_expire);
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  Future<EventListResponse?> event(int id) async {
    try {
      Response response =
          await _dio.post(Endpoints.event_api, queryParameters: {"UserId": id});
      var data = response.data;
      Hive.box(Strings.event_data_local).put('EventData', data);
      return EventListResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401 || error.response!.statusCode == 500) {


        Utility.showLoaderForError(Strings.session_expire);

      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  Future<ProgressUpdateResponse?> progressUpdateAPI(
      String userId,int eventId, String statusActivity) async {
    try {
      print(eventId);
      print(statusActivity);

      Response response = await _dio.post(Endpoints.progress_update_api,
          data: {"userId":int.parse(userId),"eventId": eventId, "activityStatus": statusActivity});
      if (response.statusCode == 200) {
        var data = response.data;
        Hive.box(Strings.progress_data_local).put('ProgressUpdateData', data);
        return ProgressUpdateResponse.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401 || error.response!.statusCode == 500) {
        Utility.showLoaderForError(Strings.session_expire);
        // Utility.getRefreshToken();
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }


 Future<ProgressUpdateResponse?> filterList(
     int eventId, String userId, String activityStatus, int range, String startDate, String endDate) async {
    try {

      Response response = await _dio.post(Endpoints.activity_list_filter,
          data: {"eventId": eventId,"userId":int.parse(userId), "activityStatus": activityStatus,"range":range,"startRange":int.parse(startDate),"endRange":int.parse(endDate),});
      if (response.statusCode == 200) {
        return ProgressUpdateResponse.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401 || error.response!.statusCode == 500) {
        Utility.showLoaderForError(Strings.session_expire);
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  Future<GroupBySearch?> groupByListAPI() async {
    try {

      Response response = await _dio.post(Endpoints.group_list_filter);
      if (response.statusCode == 200) {
        return GroupBySearch.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401 || error.response!.statusCode == 500) {
        Utility.showLoaderForError(Strings.session_expire);
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }


  Future<AvilableBarrierListResponse?> getBarrierList(
      int userId, String activityId) async {
    try {


      Response response = await _dio.post(Endpoints.avilable_barrier_list_api,
          data: {"userId": userId, "activityId": activityId});
      if (response.statusCode == 200) {
        return AvilableBarrierListResponse.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      if (error.response!.statusCode == 401 || error.response!.statusCode == 500) {
        Utility.showLoaderForError(Strings.session_expire);
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

  Future<RefreshTokenResponse?> refreshToken() async {
    try {
      Response response = await _dioWithOutHeader.post(Endpoints.refresh_token_api);
      if (response.statusCode == 200) {
        print("Exception occured: ${response.data.toString()}");

        return RefreshTokenResponse.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      String msg = DioErrorUtil.handleError(error as DioError);
      print("error.response!.statusCode");
      print(error.response!.statusCode);
      if (error.response!.statusCode == 401 || error.response!.statusCode == 500) {

        Utility.showLoaderForError(Strings.session_expire);
      }
      Utility.showToast(msg);
      EasyLoading.dismiss();
    }
  }

}
