class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://10.0.0.14/STOLogix-ENRG-api/api/";
  // static const String baseUrl = "http://stocommapi.stologix.com/api/";
  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;
  static const String login_api = baseUrl+"AccountLogin/Login";
  static const String forgot_api = baseUrl+"AccountLogin/ForgotPassword";
  static const String reset_api = baseUrl+"AccountLogin/ResetPassword";
  static const String otp_api = baseUrl+"AccountLogin/VerifyOTP";
  static const String refresh_token_api = baseUrl+"AccountLogin/RefreshToken";
  static const String activity_api = baseUrl+"UserData/GetActivityCount";
  static const String event_api = baseUrl+"UserData/EventList";
  static const String progress_update_api = baseUrl+"UserData/GetActivityList";
  static const String activity_list_filter = baseUrl+"UserData/ActivityListFilter";
  static const String group_list_filter = baseUrl+"UserData/GetActivityGroupedColumn";
  static const String barrier_code_api = baseUrl+"UserData/GetBarrierCode";
  static const String add_barrier_code_api = baseUrl+"UserData/AddActivityBarrierCode";
  static const String avilable_barrier_list_api = baseUrl+"UserData/GetActivityBarrierCodeList";
  static const String update_task_api = baseUrl+"UserData/UpdateTaskActivityList";
  static const String update_barrier_code_api = baseUrl+"UserData/UpdateActivityBarrierCode";
  static const String delete_barrier_api = baseUrl+"UserData/DeleteActivityBarrier";
}