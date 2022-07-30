import 'package:project_architech/network/user_api_provider.dart';
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


class UserRepository{
  UserApiProvider _apiProvider = UserApiProvider();


  // method is used for login api
  Future<LoginResponse?>loginAPI(String userName,String password){
    return _apiProvider.login(userName,password);
    }
  // method is used for forgot api
  Future<ForgotResponse?> forgotApi(String email) async{
   return _apiProvider.forgotApi(email);
  }

  // method is used for getBarrierList api
  Future<AvilableBarrierListResponse?> getBarrierList(int userId,String activityId) async{
   return _apiProvider.getBarrierList(userId,activityId);
  }
  // method is used for addUpdate barrier api
  Future<dynamic?> addUpdateBarrier(String activityId,int userId,String barrierCode,String delayTime,String barrierDescription,
      String wbscode,String timeStamp,bool isDelete,bool isEditable) async{
   return _apiProvider.addUpdateBarrier(activityId,userId,barrierCode,delayTime,barrierDescription,wbscode,
       timeStamp, isDelete,isEditable);
  }
  // method is used for delete barrier api
  Future<dynamic?> deleteBarrierActivity(String activityId) async{
   return _apiProvider.deleteBarrierActivity(activityId);
  }

  // method is used for Update barrier api
  Future<dynamic?> UpdateBarrier(int barrierCodeId,String activityId,int userId,String barrierCode,String delayTime,String barrierDescription,
      String wbscode,String timeStamp,bool isDelete,bool isEditable) async{
   return _apiProvider.UpdateBarrier(barrierCodeId,activityId,userId,barrierCode,delayTime,barrierDescription,wbscode,
       timeStamp, isDelete,isEditable);
  }

  Future<dynamic?> updateTask(String id,int activityInPercentComplete,String actualStartDate,String? actualFinishDate) async{
   return _apiProvider.updateTask(id,activityInPercentComplete,actualStartDate,actualFinishDate);
  }

  // method is used tp getBarrier code API
  Future<BarrierCodeResponse?> getBarrierCodeApi() async{
   return _apiProvider.getBarrierCodeApi();
  }
  // method is used tp getToken API
  Future<RefreshTokenResponse?> getToken() async{
   return _apiProvider.refreshToken();
  }
  Future<OTPResponse?> otpApi(String email,String otp) async{
   return _apiProvider.otpApi(email,otp);
  }
  // method is used for reset api
  Future<ResetPasswordResponse?> resetApi(String email,String password,String repassword) async{
   return _apiProvider.resetApi(email,password,repassword);
  }

  // method is used to get activity count number
  Future<DashboardResponse?> activityApi(String userId,int idEvent) async{
    return _apiProvider.activityApi(userId,idEvent);
  }
  Future<EventListResponse?> event(int id) async{
    return _apiProvider.event(id);
  }

  // method is used for get progress update response
  Future<ProgressUpdateResponse?> progressUpdate(String userId,int eventId, String statusActivity) async{
    return _apiProvider.progressUpdateAPI(userId,eventId,statusActivity);
  }



  Future<ProgressUpdateResponse?> filterList(int eventId, String userId, String activityStatus, int range, String startDate, String endDate) async{
    return _apiProvider.filterList(eventId,userId,activityStatus,range,startDate,endDate);

  }
 Future<GroupBySearch?> groupByListAPI() async{
    return _apiProvider.groupByListAPI();

  }






}