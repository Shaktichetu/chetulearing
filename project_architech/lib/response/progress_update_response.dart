class ProgressUpdateResponse {
  List<ProgressUpdateList>? data;
  int? code;
  String? message;

  ProgressUpdateResponse({this.data, this.code, this.message});

  ProgressUpdateResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProgressUpdateList>[];
      json['data'].forEach((v) {
        data!.add(new ProgressUpdateList.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class ProgressUpdateList {
  int? id;
  String? area;
  String? activityCode;
  String? activityDescription;
  String? equipmentNumber;
  String? equipmentDescription;
  String? targetStartDate;
  String? targetEndDate;
  int? currentPercentComplete;
  int? activityBarrierCount;
  String? actualFinishDate;
  String? actualStartDate;
  String? wbscode;
  String? dataDate;

  ProgressUpdateList(
      {this.id,
        this.area,
        this.activityCode,
        this.activityDescription,
        this.equipmentNumber,
        this.equipmentDescription,
        this.targetStartDate,
        this.targetEndDate,
        this.currentPercentComplete,
        this.activityBarrierCount,
        this.actualFinishDate,
        this.actualStartDate,
        this.wbscode,
        this.dataDate});

  ProgressUpdateList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'];
    activityCode = json['activityCode'];
    activityDescription = json['activityDescription'];
    equipmentNumber = json['equipmentNumber'];
    equipmentDescription = json['equipmentDescription'];
    targetStartDate = json['targetStartDate'];
    targetEndDate = json['targetEndDate'];
    currentPercentComplete = json['currentPercentComplete'];
    activityBarrierCount = json['activityBarrierCount'];
    actualFinishDate = json['actualFinishDate'];
    actualStartDate = json['actualStartDate'];
    wbscode = json['wbscode'];
    dataDate = json['dataDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area'] = this.area;
    data['activityCode'] = this.activityCode;
    data['activityDescription'] = this.activityDescription;
    data['equipmentNumber'] = this.equipmentNumber;
    data['equipmentDescription'] = this.equipmentDescription;
    data['targetStartDate'] = this.targetStartDate;
    data['targetEndDate'] = this.targetEndDate;
    data['currentPercentComplete'] = this.currentPercentComplete;
    data['activityBarrierCount'] = this.activityBarrierCount;
    data['actualFinishDate'] = this.actualFinishDate;
    data['actualStartDate'] = this.actualStartDate;
    data['wbscode'] = this.wbscode;
    data['dataDate'] = this.dataDate;
    return data;
  }
}