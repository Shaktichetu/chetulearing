class AllEventsModel {
  Embedded? eEmbedded;

  AllEventsModel({this.eEmbedded});

  AllEventsModel.fromJson(Map<String, dynamic> json) {
    eEmbedded = json['_embedded'] != null
        ? new Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eEmbedded != null) {
      data['_embedded'] = this.eEmbedded!.toJson();
    }
    return data;
  }
}

class Embedded {
  List<SportingEventContracts>? sportingEventContracts;

  Embedded({this.sportingEventContracts});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['sportingEventContracts'] != null) {
      sportingEventContracts = <SportingEventContracts>[];
      json['sportingEventContracts'].forEach((v) {
        sportingEventContracts!.add(new SportingEventContracts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sportingEventContracts != null) {
      data['sportingEventContracts'] =
          this.sportingEventContracts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SportingEventContracts {
  String? id;
  Participants? participants;
  List<Propositions>? propositions;
  String? timeOfEvent;
  Links? lLinks;

  SportingEventContracts(
      {this.id,
      this.participants,
      this.propositions,
      this.timeOfEvent,
      this.lLinks});

  SportingEventContracts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    participants = json['participants'] != null
        ? new Participants.fromJson(json['participants'])
        : null;
    if (json['propositions'] != null) {
      propositions = <Propositions>[];
      json['propositions'].forEach((v) {
        propositions!.add(new Propositions.fromJson(v));
      });
    }
    timeOfEvent = json['timeOfEvent'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.participants != null) {
      data['participants'] = this.participants!.toJson();
    }
    if (this.propositions != null) {
      data['propositions'] = this.propositions!.map((v) => v.toJson()).toList();
    }
    data['timeOfEvent'] = this.timeOfEvent;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Participants {
  String? awayTeam;
  String? homeTeam;

  Participants({this.awayTeam, this.homeTeam});

  Participants.fromJson(Map<String, dynamic> json) {
    awayTeam = json['awayTeam'];
    homeTeam = json['homeTeam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['awayTeam'] = this.awayTeam;
    data['homeTeam'] = this.homeTeam;
    return data;
  }
}

class Propositions {
  String? type;
  String? id;
  int? favoriteMoney;
  String? favoriteTeam;
  String? favoritePropId;
  int? underdogMoney;
  String? underdogTeam;
  String? underdogPropId;
  String? wageringOpened;
  int? favoritePayout;
  double? points;
  int? underdogPayout;
  int? overPayout;
  String? overPropId;
  int? total;
  int? underPayout;
  String? underPropId;

  Propositions(
      {this.type,
      this.id,
      this.favoriteMoney,
      this.favoriteTeam,
      this.favoritePropId,
      this.underdogMoney,
      this.underdogTeam,
      this.underdogPropId,
      this.wageringOpened,
      this.favoritePayout,
      this.points,
      this.underdogPayout,
      this.overPayout,
      this.overPropId,
      this.total,
      this.underPayout,
      this.underPropId});

  Propositions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    favoriteMoney = json['favoriteMoney'];
    favoriteTeam = json['favoriteTeam'];
    favoritePropId = json['favoritePropId'];
    underdogMoney = json['underdogMoney'];
    underdogTeam = json['underdogTeam'];
    underdogPropId = json['underdogPropId'];
    wageringOpened = json['wageringOpened'];
    favoritePayout = json['favoritePayout'];
    points = json['points'];
    underdogPayout = json['underdogPayout'];
    overPayout = json['overPayout'];
    overPropId = json['overPropId'];
    total = json['total'];
    underPayout = json['underPayout'];
    underPropId = json['underPropId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['favoriteMoney'] = this.favoriteMoney;
    data['favoriteTeam'] = this.favoriteTeam;
    data['favoritePropId'] = this.favoritePropId;
    data['underdogMoney'] = this.underdogMoney;
    data['underdogTeam'] = this.underdogTeam;
    data['underdogPropId'] = this.underdogPropId;
    data['wageringOpened'] = this.wageringOpened;
    data['favoritePayout'] = this.favoritePayout;
    data['points'] = this.points;
    data['underdogPayout'] = this.underdogPayout;
    data['overPayout'] = this.overPayout;
    data['overPropId'] = this.overPropId;
    data['total'] = this.total;
    data['underPayout'] = this.underPayout;
    data['underPropId'] = this.underPropId;
    return data;
  }
}

class Links {
  Add? add;
  Add? complete;

  Links({this.add, this.complete});

  Links.fromJson(Map<String, dynamic> json) {
    add = json['add'] != null ? new Add.fromJson(json['add']) : null;
    complete =
        json['complete'] != null ? new Add.fromJson(json['complete']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.add != null) {
      data['add'] = this.add!.toJson();
    }
    if (this.complete != null) {
      data['complete'] = this.complete!.toJson();
    }
    return data;
  }
}

class Add {
  String? href;

  Add({this.href});

  Add.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
