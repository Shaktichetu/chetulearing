class ProgressUpdateModel {
  int? idEvent;
  String? statusActivity;
  ProgressUpdateModel({this.idEvent, this.statusActivity});
  set setIdEvent(int? idEvent) {
    idEvent = idEvent;
  }

  int? get getidEvent {
    return idEvent;
  }

  set setstatusActivity(String statusActivity) {
    statusActivity = statusActivity;
  }

  String get getstatusActivity {
    return statusActivity!;
  }

}
