class GroupBySearch {
  List<Data>? data;
  int? code;
  String? message;

  GroupBySearch({this.data, this.code, this.message});

  GroupBySearch.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? progressUpdateColumnName;
  String? displayColumn;
  bool checked = false;
  Data({this.id, this.progressUpdateColumnName, this.displayColumn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    progressUpdateColumnName = json['progressUpdateColumnName'];
    displayColumn = json['displayColumn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['progressUpdateColumnName'] = this.progressUpdateColumnName;
    data['displayColumn'] = this.displayColumn;
    return data;
  }
}