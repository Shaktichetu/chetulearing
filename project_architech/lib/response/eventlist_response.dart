class EventListResponse {
  List<EventList>? data;
  int? code;
  String? message;

  EventListResponse({this.data, this.code, this.message});

  EventListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EventList>[];
      json['data'].forEach((v) {
        data!.add(new EventList.fromJson(v));
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

class EventList {
  int? id;
  String? name;

  EventList({this.id, this.name});

  EventList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}