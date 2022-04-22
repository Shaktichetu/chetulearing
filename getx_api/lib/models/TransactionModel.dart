import 'dart:convert';
/// _embedded : {"transactionContracts":[{"time":"2022-03-16T04:10:24.904893Z","amount":-50,"transactionId":"d6148cce-413c-405b-a5c8-525587cbaa91"}]}

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));
String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
      Embedded? embedded,}){
    _embedded = embedded;
}

  TransactionModel.fromJson(dynamic json) {
    _embedded = json['_embedded'] != null ? Embedded.fromJson(json['_embedded']) : null;
  }
  Embedded? _embedded;
TransactionModel copyWith({  Embedded? embedded,
}) => TransactionModel(  embedded: embedded ?? _embedded,
);
  Embedded? get embedded => _embedded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_embedded != null) {
      map['_embedded'] = _embedded?.toJson();
    }
    return map;
  }

}

/// transactionContracts : [{"time":"2022-03-16T04:10:24.904893Z","amount":-50,"transactionId":"d6148cce-413c-405b-a5c8-525587cbaa91"}]

Embedded embeddedFromJson(String str) => Embedded.fromJson(json.decode(str));
String embeddedToJson(Embedded data) => json.encode(data.toJson());
class Embedded {
  Embedded({
      List<TransactionContracts>? transactionContracts,}){
    _transactionContracts = transactionContracts;
}

  Embedded.fromJson(dynamic json) {
    if (json['transactionContracts'] != null) {
      _transactionContracts = [];
      json['transactionContracts'].forEach((v) {
        _transactionContracts?.add(TransactionContracts.fromJson(v));
      });
    }
  }
  List<TransactionContracts>? _transactionContracts;
Embedded copyWith({  List<TransactionContracts>? transactionContracts,
}) => Embedded(  transactionContracts: transactionContracts ?? _transactionContracts,
);
  List<TransactionContracts>? get transactionContracts => _transactionContracts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transactionContracts != null) {
      map['transactionContracts'] = _transactionContracts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// time : "2022-03-16T04:10:24.904893Z"
/// amount : -50
/// transactionId : "d6148cce-413c-405b-a5c8-525587cbaa91"

TransactionContracts transactionContractsFromJson(String str) => TransactionContracts.fromJson(json.decode(str));
String transactionContractsToJson(TransactionContracts data) => json.encode(data.toJson());
class TransactionContracts {
  TransactionContracts({
      String? time, 
      int? amount, 
      String? transactionId,}){
    _time = time;
    _amount = amount;
    _transactionId = transactionId;
}

  TransactionContracts.fromJson(dynamic json) {
    _time = json['time'];
    _amount = json['amount'];
    _transactionId = json['transactionId'];
  }
  String? _time;
  int? _amount;
  String? _transactionId;
TransactionContracts copyWith({  String? time,
  int? amount,
  String? transactionId,
}) => TransactionContracts(  time: time ?? _time,
  amount: amount ?? _amount,
  transactionId: transactionId ?? _transactionId,
);
  String? get time => _time;
  int? get amount => _amount;
  String? get transactionId => _transactionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['amount'] = _amount;
    map['transactionId'] = _transactionId;
    return map;
  }

}