// To parse this JSON data, do
//
//     final allSpecialisation = allSpecialisationFromJson(jsonString);

import 'dart:convert';

AllSpecialisation allSpecialisationFromJson(String str) => AllSpecialisation.fromJson(json.decode(str));

String allSpecialisationToJson(AllSpecialisation data) => json.encode(data.toJson());

class AllSpecialisation {
    AllSpecialisation({
        this.message,
        this.data,
        this.code,
    });

    String? message;
    List<Datum>? data;
    int? code;

    factory AllSpecialisation.fromJson(Map<String, dynamic> json) => AllSpecialisation(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
    };
}

class Datum {
    Datum({
        this.id,
        this.specialisationId,
        this.specialisation,
        this.createdAt,
        this.isActive,
    });

    String? id;
    String? specialisationId;
    String? specialisation;
    int? createdAt;
    bool? isActive;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        specialisationId: json["specialisation_id"],
        specialisation: json["specialisation"],
        createdAt: json["created_at"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "specialisation_id": specialisationId,
        "specialisation": specialisation,
        "created_at": createdAt,
        "is_active": isActive,
    };
}
