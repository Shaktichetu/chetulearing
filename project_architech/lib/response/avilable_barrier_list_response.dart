class AvilableBarrierListResponse {
  List<BarrierCodeList>? barrierCodeList;

  AvilableBarrierListResponse({this.barrierCodeList});

  AvilableBarrierListResponse.fromJson(Map<String, dynamic> json) {
    if (json['barrierCodeList'] != null) {
      barrierCodeList = <BarrierCodeList>[];
      json['barrierCodeList'].forEach((v) {
        barrierCodeList!.add(new BarrierCodeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.barrierCodeList != null) {
      data['barrierCodeList'] =
          this.barrierCodeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BarrierCodeList {
  int? id;
  String? activityId;
  int? userId;
  String? barrierCode;
  String? delayTime;
  String? barrierDescription;
  String? wbscode;
  String? timeStamp;
  bool? isDelete;
  bool? isEditable;

  BarrierCodeList(
      {this.id,
        this.activityId,
        this.userId,
        this.barrierCode,
        this.delayTime,
        this.barrierDescription,
        this.wbscode,
        this.timeStamp,
        this.isDelete,
        this.isEditable});

  BarrierCodeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityId = json['activityId'];
    userId = json['userId'];
    barrierCode = json['barrierCode'];
    delayTime = json['delayTime'];
    barrierDescription = json['barrierDescription'];
    wbscode = json['wbscode'];
    timeStamp = json['timeStamp'];
    isDelete = json['isDelete'];
    isEditable = json['isEditable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activityId'] = this.activityId;
    data['userId'] = this.userId;
    data['barrierCode'] = this.barrierCode;
    data['delayTime'] = this.delayTime;
    data['barrierDescription'] = this.barrierDescription;
    data['wbscode'] = this.wbscode;
    data['timeStamp'] = this.timeStamp;
    data['isDelete'] = this.isDelete;
    data['isEditable'] = this.isEditable;
    return data;
  }
}