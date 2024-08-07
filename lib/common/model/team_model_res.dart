// To parse this JSON data, do
//
//     final teamModelRes = teamModelResFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'match_res.dart';

TeamModelRes teamModelResFromJson(String str) =>
    TeamModelRes.fromJson(json.decode(str));

String teamModelResToJson(TeamModelRes data) => json.encode(data.toJson());

class TeamModelRes {
  TeamModel? data;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  TeamModelRes({
    this.data,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory TeamModelRes.fromJson(Map<String, dynamic> json, {String? matchKey}) {
    try {
      return TeamModelRes(
        data: json["data"] == null
            ? null
            : TeamModel.fromJson(json["data"], matchKey: matchKey),
        subscription: json["subscription"] == null
            ? []
            : List<Subscription>.from(
                json["subscription"]!.map((x) => Subscription.fromJson(x))),
        rateLimit: json["rate_limit"] == null
            ? null
            : RateLimit.fromJson(json["rate_limit"]),
        timezone: json["timezone"],
      );
    } catch (e) {
      log("TeamModelRes: ${e.toString()}");
      throw FormatException(e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "subscription": subscription == null
            ? []
            : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "rate_limit": rateLimit?.toJson(),
        "timezone": timezone,
      };
}

class TeamModel {
  num? id;
  num? sportId;
  num? countryId;
  num? venueId;
  String? gender;
  String? name;
  String? shortCode;
  String? imagePath;
  num? founded;
  String? type;
  bool? placeholder;
  DateTime? lastPlayedAt;
  Country? country;
  List<Coach>? coaches;
  List<Player>? players;
  List<MatchModel>? data;

  TeamModel({
    this.id,
    this.sportId,
    this.countryId,
    this.venueId,
    this.gender,
    this.name,
    this.shortCode,
    this.imagePath,
    this.founded,
    this.type,
    this.placeholder,
    this.lastPlayedAt,
    this.country,
    this.coaches,
    this.players,
    this.data,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json, {String? matchKey}) =>
      TeamModel(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        venueId: json["venue_id"],
        gender: json["gender"],
        name: json["name"],
        shortCode: json["short_code"],
        imagePath: json["image_path"],
        founded: json["founded"],
        type: json["type"],
        placeholder: json["placeholder"],
        lastPlayedAt: json["last_played_at"] == null
            ? null
            : DateTime.parse(json["last_played_at"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        coaches: json["coaches"] == null
            ? []
            : List<Coach>.from(json["coaches"]!.map((x) => Coach.fromJson(x))),
        players: json["players"] == null
            ? []
            : List<Player>.from(
                json["players"]!.map((x) => Player.fromJson(x))),
        data: json[matchKey ?? "latest"] == null
            ? []
            : List<MatchModel>.from(
                json[matchKey ?? "latest"]!.map((x) => MatchModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "venue_id": venueId,
        "gender": gender,
        "name": name,
        "short_code": shortCode,
        "image_path": imagePath,
        "founded": founded,
        "type": type,
        "placeholder": placeholder,
        "last_played_at": lastPlayedAt?.toIso8601String(),
        "country": country?.toJson(),
        "coaches": coaches == null
            ? []
            : List<dynamic>.from(coaches!.map((x) => x.toJson())),
        "players": players == null
            ? []
            : List<dynamic>.from(players!.map((x) => x.toJson())),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Coach {
  int? id;
  int? teamId;
  int? coachId;
  int? positionId;
  bool? active;
  DateTime? start;
  DateTime? end;
  bool? temporary;

  Coach({
    this.id,
    this.teamId,
    this.coachId,
    this.positionId,
    this.active,
    this.start,
    this.end,
    this.temporary,
  });

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        id: json["id"],
        teamId: json["team_id"],
        coachId: json["coach_id"],
        positionId: json["position_id"],
        active: json["active"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        temporary: json["temporary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "team_id": teamId,
        "coach_id": coachId,
        "position_id": positionId,
        "active": active,
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "end":
            "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
        "temporary": temporary,
      };
}

class Country {
  int? id;
  int? continentId;
  String? name;
  String? officialName;
  String? fifaName;
  String? iso2;
  String? iso3;
  String? latitude;
  String? longitude;
  List<String>? borders;
  String? imagePath;

  Country({
    this.id,
    this.continentId,
    this.name,
    this.officialName,
    this.fifaName,
    this.iso2,
    this.iso3,
    this.latitude,
    this.longitude,
    this.borders,
    this.imagePath,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        continentId: json["continent_id"],
        name: json["name"],
        officialName: json["official_name"],
        fifaName: json["fifa_name"],
        iso2: json["iso2"],
        iso3: json["iso3"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        borders: json["borders"] == null
            ? []
            : List<String>.from(json["borders"]!.map((x) => x)),
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "continent_id": continentId,
        "name": name,
        "official_name": officialName,
        "fifa_name": fifaName,
        "iso2": iso2,
        "iso3": iso3,
        "latitude": latitude,
        "longitude": longitude,
        "borders":
            borders == null ? [] : List<dynamic>.from(borders!.map((x) => x)),
        "image_path": imagePath,
      };
}

class Player {
  int? id;
  int? transferId;
  int? playerId;
  int? teamId;
  int? positionId;
  int? detailedPositionId;
  DateTime? start;
  DateTime? end;
  bool? captain;
  int? jerseyNumber;

  Player({
    this.id,
    this.transferId,
    this.playerId,
    this.teamId,
    this.positionId,
    this.detailedPositionId,
    this.start,
    this.end,
    this.captain,
    this.jerseyNumber,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        transferId: json["transfer_id"],
        playerId: json["player_id"],
        teamId: json["team_id"],
        positionId: json["position_id"],
        detailedPositionId: json["detailed_position_id"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        captain: json["captain"],
        jerseyNumber: json["jersey_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transfer_id": transferId,
        "player_id": playerId,
        "team_id": teamId,
        "position_id": positionId,
        "detailed_position_id": detailedPositionId,
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "end":
            "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
        "captain": captain,
        "jersey_number": jerseyNumber,
      };
}

class RateLimit {
  num? resetsInSeconds;
  num? remaining;
  String? requestedEntity;

  RateLimit({
    this.resetsInSeconds,
    this.remaining,
    this.requestedEntity,
  });

  factory RateLimit.fromJson(Map<String, dynamic> json) => RateLimit(
        resetsInSeconds: json["resets_in_seconds"],
        remaining: json["remaining"],
        requestedEntity: json["requested_entity"],
      );

  Map<String, dynamic> toJson() => {
        "resets_in_seconds": resetsInSeconds,
        "remaining": remaining,
        "requested_entity": requestedEntity,
      };
}

class Subscription {
  Meta? meta;
  List<Plan>? plans;
  List<dynamic>? addOns;
  List<dynamic>? widgets;

  Subscription({
    this.meta,
    this.plans,
    this.addOns,
    this.widgets,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        plans: json["plans"] == null
            ? []
            : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
        addOns: json["add_ons"] == null
            ? []
            : List<dynamic>.from(json["add_ons"]!.map((x) => x)),
        widgets: json["widgets"] == null
            ? []
            : List<dynamic>.from(json["widgets"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "plans": plans == null
            ? []
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "add_ons":
            addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x)),
        "widgets":
            widgets == null ? [] : List<dynamic>.from(widgets!.map((x) => x)),
      };
}

class Meta {
  dynamic trialEndsAt;
  DateTime? endsAt;
  num? currentTimestamp;

  Meta({
    this.trialEndsAt,
    this.endsAt,
    this.currentTimestamp,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        trialEndsAt: json["trial_ends_at"],
        endsAt:
            json["ends_at"] == null ? null : DateTime.parse(json["ends_at"]),
        currentTimestamp: json["current_timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "trial_ends_at": trialEndsAt,
        "ends_at": endsAt?.toIso8601String(),
        "current_timestamp": currentTimestamp,
      };
}

class Plan {
  String? plan;
  String? sport;
  String? category;

  Plan({
    this.plan,
    this.sport,
    this.category,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        plan: json["plan"],
        sport: json["sport"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "plan": plan,
        "sport": sport,
        "category": category,
      };
}
