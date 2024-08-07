// To parse this JSON data, do
//
//     final matchPredictionRes = matchPredictionResFromJson(jsonString);

import 'dart:convert';

MatchPredictionRes matchPredictionResFromJson(String str) =>
    MatchPredictionRes.fromJson(json.decode(str));

String matchPredictionResToJson(MatchPredictionRes data) =>
    json.encode(data.toJson());

class MatchPredictionRes {
  final List<Datum>? data;

  MatchPredictionRes({
    this.data,
  });

  MatchPredictionRes copyWith({
    List<Datum>? data,
    String? timezone,
  }) =>
      MatchPredictionRes(
        data: data ?? this.data,
      );

  factory MatchPredictionRes.fromJson(Map<String, dynamic> json) =>
      MatchPredictionRes(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final int? id;
  final int? fixtureId;
  final int? marketId;
  final int? bookmakerId;
  final String? label;
  final String? value;
  final String? name;
  final int? sortOrder;
  final String? marketDescription;
  final String? probability;
  final String? dp3;
  final String? fractional;
  final String? american;
  final bool? winning;
  final bool? stopped;
  final String? total;
  final String? handicap;
  final dynamic participants;
  final DateTime? createdAt;
  final dynamic originalLabel;
  final DateTime? latestBookmakerUpdate;

  Datum({
    this.id,
    this.fixtureId,
    this.marketId,
    this.bookmakerId,
    this.label,
    this.value,
    this.name,
    this.sortOrder,
    this.marketDescription,
    this.probability,
    this.dp3,
    this.fractional,
    this.american,
    this.winning,
    this.stopped,
    this.total,
    this.handicap,
    this.participants,
    this.createdAt,
    this.originalLabel,
    this.latestBookmakerUpdate,
  });

  Datum copyWith({
    int? id,
    int? fixtureId,
    int? marketId,
    int? bookmakerId,
    String? label,
    String? value,
    String? name,
    int? sortOrder,
    String? marketDescription,
    String? probability,
    String? dp3,
    String? fractional,
    String? american,
    bool? winning,
    bool? stopped,
    String? total,
    String? handicap,
    dynamic participants,
    DateTime? createdAt,
    dynamic originalLabel,
    DateTime? latestBookmakerUpdate,
  }) =>
      Datum(
        id: id ?? this.id,
        fixtureId: fixtureId ?? this.fixtureId,
        marketId: marketId ?? this.marketId,
        bookmakerId: bookmakerId ?? this.bookmakerId,
        label: label ?? this.label,
        value: value ?? this.value,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
        marketDescription: marketDescription ?? this.marketDescription,
        probability: probability ?? this.probability,
        dp3: dp3 ?? this.dp3,
        fractional: fractional ?? this.fractional,
        american: american ?? this.american,
        winning: winning ?? this.winning,
        stopped: stopped ?? this.stopped,
        total: total ?? this.total,
        handicap: handicap ?? this.handicap,
        participants: participants ?? this.participants,
        createdAt: createdAt ?? this.createdAt,
        originalLabel: originalLabel ?? this.originalLabel,
        latestBookmakerUpdate:
            latestBookmakerUpdate ?? this.latestBookmakerUpdate,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fixtureId: json["fixture_id"],
        marketId: json["market_id"],
        bookmakerId: json["bookmaker_id"],
        label: json["label"],
        value: json["value"],
        name: json["name"],
        sortOrder: json["sort_order"],
        marketDescription: json["market_description"],
        probability: json["probability"],
        dp3: json["dp3"],
        fractional: json["fractional"],
        american: json["american"],
        winning: json["winning"],
        stopped: json["stopped"],
        total: json["total"],
        handicap: json["handicap"],
        participants: json["participants"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        originalLabel: json["original_label"],
        latestBookmakerUpdate: json["latest_bookmaker_update"] == null
            ? null
            : DateTime.parse(json["latest_bookmaker_update"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "market_id": marketId,
        "bookmaker_id": bookmakerId,
        "label": label,
        "value": value,
        "name": name,
        "sort_order": sortOrder,
        "market_description": marketDescription,
        "probability": probability,
        "dp3": dp3,
        "fractional": fractional,
        "american": american,
        "winning": winning,
        "stopped": stopped,
        "total": total,
        "handicap": handicap,
        "participants": participants,
        "created_at": createdAt?.toIso8601String(),
        "original_label": originalLabel,
        "latest_bookmaker_update": latestBookmakerUpdate?.toIso8601String(),
      };
}
