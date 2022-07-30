class BarrierCodeResponse {
  List<BarrierCode>? barrierCode;

  BarrierCodeResponse({this.barrierCode});

  BarrierCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['barrierCode'] != null) {
      barrierCode = <BarrierCode>[];
      json['barrierCode'].forEach((v) {
        barrierCode!.add(new BarrierCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.barrierCode != null) {
      data['barrierCode'] = this.barrierCode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BarrierCode {
  int? id;
  String? shortCode;
  String? code;
  String? codeDescription;

  BarrierCode({this.id, this.shortCode, this.code, this.codeDescription});

  BarrierCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortCode = json['shortCode'];
    code = json['code'];
    codeDescription = json['codeDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shortCode'] = this.shortCode;
    data['code'] = this.code;
    data['codeDescription'] = this.codeDescription;
    return data;
  }
}