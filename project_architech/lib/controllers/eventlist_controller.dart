import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';

import '../common/strings.dart';
import '../network/user_api_provider.dart';
import '../network/user_repository.dart';
import '../response/eventlist_response.dart';


class EventListController extends GetxController {
  RxList<EventList?> eventListRespnse = <EventList>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // method is used for eventApi
  Future<EventListResponse?> eventAPi(int? id) async {
    print(id.toString());
    UserApiProvider().isConnected().then((internet) async {
      UserRepository userRepository = UserRepository();
      EasyLoading.show();
      if (internet) {
        await userRepository.event(id!).then((value) async {
          if(value!.code ==200){
            setEventData(value);
          }
          return value;

        });
      } else {
        // method is used whene user is offline than getData method is call and get the data from local storage

        EventListResponse response = await getData();
        setEventData(response);
        return response;
      }
      update();
    });
  }

  Future<EventListResponse> getData() async {
    final  eventList =
    await Hive.box(Strings.event_data_local).get(Strings.event_data_local, defaultValue: []);
    return EventListResponse.fromJson(eventList);

  }

  void setEventData(EventListResponse value) {
    eventListRespnse.value = value.data!;
    EasyLoading.dismiss();
    update();
  }
}
