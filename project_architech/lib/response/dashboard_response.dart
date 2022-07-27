class DashboardResponse {
  Data? data;
  int? code;
  String? message;

  DashboardResponse({this.data, this.code, this.message});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? totalActivity;
  int? totalUpdated;
  int? incompleteActivity;
  String? dataDate;

  Data(
      {this.totalActivity,
        this.totalUpdated,
        this.incompleteActivity,
        this.dataDate});

  Data.fromJson(Map<String, dynamic> json) {
    totalActivity = json['totalActivity'];
    totalUpdated = json['totalUpdated'];
    incompleteActivity = json['incompleteActivity'];
    dataDate = json['dataDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalActivity'] = this.totalActivity;
    data['totalUpdated'] = this.totalUpdated;
    data['incompleteActivity'] = this.incompleteActivity;
    data['dataDate'] = this.dataDate;
    return data;
  }
}