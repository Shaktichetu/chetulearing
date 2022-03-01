import 'dart:convert';
/// message : "specialization fetched"
/// data : [{"_id":"S9EJMoY7MS4BZ4z2d","specialisation_id":"Subject_1620292374997","specialisation":"CSS","created_at":1620292374997,"is_active":true},{"_id":"Y7JYmmxh7tF7kSmd7","specialisation_id":"Subject_1621574390132","specialisation":"Networkings","created_at":1621574390132,"is_active":true},{"_id":"95hjTYuf93E2WMnbc","specialisation_id":"Subject_1628061164646","specialisation":"Electronics Engineering","created_at":1628061164646,"is_active":true},{"_id":"BiAkTqDDzZodLeQeL","specialisation_id":"Subject_1630994581074","specialisation":"Electrical Engineering","created_at":1630994581074,"is_active":true},{"_id":"Mn64iSCyxdq8Rqd2R","specialisation_id":"Subject_1631083900567","specialisation":"Aerospace Engineering","created_at":1631083900567,"is_active":true},{"_id":"o9ZjMbWCF78QR7vb6","specialisation_id":"Subject_1631083909126","specialisation":"Agriculture & Food Engineering","created_at":1631083909126,"is_active":true},{"_id":"ZoeyQCKNbiouDNh5b","specialisation_id":"Subject_1631083957046","specialisation":"Civil Engineering","created_at":1631083957046,"is_active":true},{"_id":"mmaNR2sdsaMwwKNns","specialisation_id":"Subject_1631084543878","specialisation":"Automobile Engineering","created_at":1631084543878,"is_active":true},{"_id":"nvx7xwm8ko3n2442Y","specialisation_id":"Subject_1631084567354","specialisation":"Biotechnology Engineering","created_at":1631084567354,"is_active":true},{"_id":"vyNWov46f72K9kGuk","specialisation_id":"Subject_1631084579239","specialisation":"Ceramic Engineering","created_at":1631084579239,"is_active":true},{"_id":"28fjwgZCeSm6vzzY2","specialisation_id":"Subject_1631084596564","specialisation":"Chemical Engineering","created_at":1631084596564,"is_active":true},{"_id":"3TnnEiccqZehsvf9j","specialisation_id":"Subject_1631084610006","specialisation":"Computer Engineering","created_at":1631084610006,"is_active":true},{"_id":"tWF8XiLBxL32CEfoy","specialisation_id":"Subject_1631084622522","specialisation":"Engineering Physics","created_at":1631084622522,"is_active":true},{"_id":"uCjzioagu6sCpLqoF","specialisation_id":"Subject_1631084635292","specialisation":"Environmental Engineering","created_at":1631084635292,"is_active":true},{"_id":"zuKz99FR4Qkja4ah2","specialisation_id":"Subject_1631084648718","specialisation":"Industrial and Production Engineering","created_at":1631084648718,"is_active":true},{"_id":"cCvqTpq5PZr89YbEW","specialisation_id":"Subject_1631084658278","specialisation":"Industrial Engineering","created_at":1631084658279,"is_active":true},{"_id":"R949ceEvxXo7FzyDN","specialisation_id":"Subject_1631084667953","specialisation":"Information Technology Engineering","created_at":1631084667953,"is_active":true},{"_id":"3t3uf4raNie2dYfbY","specialisation_id":"Subject_1631084678238","specialisation":"Instrumentation Engineering","created_at":1631084678238,"is_active":true},{"_id":"nAApBcXtkBierr2no","specialisation_id":"Subject_1631084690324","specialisation":"Marine Engineering","created_at":1631084690324,"is_active":true},{"_id":"DkrcbbK6YHK64wyiR","specialisation_id":"Subject_1631084699229","specialisation":"Mechanical Engineering","created_at":1631084699229,"is_active":true},{"_id":"kgQ8Lmo8k7afFyZM5","specialisation_id":"Subject_1631084708437","specialisation":"Metallurgical Engineering","created_at":1631084708437,"is_active":true},{"_id":"ZDb2LjEwHTuEcXQH6","specialisation_id":"Subject_1631084715196","specialisation":"Naval Architecture and Ocean Engineering","created_at":1631084715196,"is_active":true},{"_id":"Cf6pcTvn3iKoucTJP","specialisation_id":"Subject_1631084725052","specialisation":"Petroleum Engineering","created_at":1631084725052,"is_active":true},{"_id":"EwEEFvMMgF4wT3SpD","specialisation_id":"Subject_1631084732070","specialisation":"Textile Engineering","created_at":1631084732070,"is_active":true},{"_id":"HLe4SfNKndPFoNctT","specialisation_id":"Subject_1631171722187","specialisation":"Mathematics","created_at":1631171722187,"is_active":true},{"_id":"NP2x7yR3Xz7CHrzLj","specialisation_id":"Subject_1631441948543","specialisation":"X, XI ,XII","created_at":1631441948543,"is_active":true},{"_id":"egWZfyRriAJxC9n5o","specialisation_id":"Subject_1632551773913","specialisation":"testing ","created_at":1632551773913,"is_active":true},{"_id":"SKrLQJzJ8ATBBQvM2","specialisation_id":"Subject_1632635178001","specialisation":"test manas ","created_at":1632635178001,"is_active":true},{"_id":"qutRgcG5BisoMCFuG","specialisation_id":"Subject_1632813182886","specialisation":"Test Rama","created_at":1632813182886,"is_active":true},{"_id":"XC6zNt3EnWRDq3ZkF","specialisation_id":"Subject_1632813429565","specialisation":"Test Chanchal new","created_at":1632813429565,"is_active":true}]
/// code : 200

SpecialisationModel specialisationModelFromJson(String str) => SpecialisationModel.fromJson(json.decode(str));
String specialisationModelToJson(SpecialisationModel data) => json.encode(data.toJson());

class SpecialisationModel {
  SpecialisationModel({
      String? message, 
      List<Data>? data, 
      int? code,}){
    _message = message;
    _data = data;
    _code = code;
}

  SpecialisationModel.fromJson(dynamic json) {
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _code = json['code'];
  }
  String? _message;
  List<Data>? _data;
  int? _code;

  String? get message => _message;
  List<Data>? get data => _data;
  int? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['code'] = _code;
    return map;
  }

}

/// _id : "S9EJMoY7MS4BZ4z2d"
/// specialisation_id : "Subject_1620292374997"
/// specialisation : "CSS"
/// created_at : 1620292374997
/// is_active : true

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? specialisationId, 
      String? specialisation, 
      int? createdAt, 
      bool? isActive,}){
    _id = id;
    _specialisationId = specialisationId;
    _specialisation = specialisation;
    _createdAt = createdAt;
    _isActive = isActive;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _specialisationId = json['specialisation_id'];
    _specialisation = json['specialisation'];
    _createdAt = json['created_at'];
    _isActive = json['is_active'];
  }
  String? _id;
  String? _specialisationId;
  String? _specialisation;
  int? _createdAt;
  bool? _isActive;

  String? get id => _id;
  String? get specialisationId => _specialisationId;
  String? get specialisation => _specialisation;
  int? get createdAt => _createdAt;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['specialisation_id'] = _specialisationId;
    map['specialisation'] = _specialisation;
    map['created_at'] = _createdAt;
    map['is_active'] = _isActive;
    return map;
  }

}