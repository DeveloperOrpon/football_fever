// To parse this JSON data, do
//
//     final seasonMatchRes = seasonMatchResFromJson(jsonString);

import 'dart:convert';

import 'package:football_fever/common/model/match_res.dart';

SeasonMatchRes seasonMatchResFromJson(String str) =>
    SeasonMatchRes.fromJson(json.decode(str));

String seasonMatchResToJson(SeasonMatchRes data) => json.encode(data.toJson());

class SeasonMatchRes {
  Data? data;
  String? timezone;

  SeasonMatchRes({
    this.data,
    this.timezone,
  });

  factory SeasonMatchRes.fromJson(Map<String, dynamic> json) => SeasonMatchRes(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "timezone": timezone,
      };
}

class Data {
  int? id;
  int? sportId;
  int? leagueId;
  int? tieBreakerRuleId;
  String? name;
  bool? finished;
  bool? pending;
  bool? isCurrent;
  DateTime? startingAt;
  DateTime? endingAt;
  DateTime? standingsRecalculatedAt;
  bool? gamesInCurrentWeek;
  List<MatchModel>? fixtures;
  List<TopScorer>? topscorers;

  Data({
    this.id,
    this.sportId,
    this.leagueId,
    this.tieBreakerRuleId,
    this.name,
    this.finished,
    this.pending,
    this.isCurrent,
    this.startingAt,
    this.endingAt,
    this.standingsRecalculatedAt,
    this.gamesInCurrentWeek,
    this.fixtures,
    this.topscorers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        sportId: json["sport_id"],
        leagueId: json["league_id"],
        tieBreakerRuleId: json["tie_breaker_rule_id"],
        name: json["name"],
        finished: json["finished"],
        pending: json["pending"],
        isCurrent: json["is_current"],
        startingAt: json["starting_at"] == null
            ? null
            : DateTime.parse(json["starting_at"]),
        endingAt: json["ending_at"] == null
            ? null
            : DateTime.parse(json["ending_at"]),
        standingsRecalculatedAt: json["standings_recalculated_at"] == null
            ? null
            : DateTime.parse(json["standings_recalculated_at"]),
        gamesInCurrentWeek: json["games_in_current_week"],
        fixtures: json["fixtures"] == null
            ? []
            : List<MatchModel>.from(
                json["fixtures"]!.map((x) => MatchModel.fromJson(x))),
        topscorers: json["topscorers"] == null
            ? []
            : List<TopScorer>.from(
                json["topscorers"]!.map((x) => TopScorer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "league_id": leagueId,
        "tie_breaker_rule_id": tieBreakerRuleId,
        "name": name,
        "finished": finished,
        "pending": pending,
        "is_current": isCurrent,
        "starting_at":
            "${startingAt!.year.toString().padLeft(4, '0')}-${startingAt!.month.toString().padLeft(2, '0')}-${startingAt!.day.toString().padLeft(2, '0')}",
        "ending_at":
            "${endingAt!.year.toString().padLeft(4, '0')}-${endingAt!.month.toString().padLeft(2, '0')}-${endingAt!.day.toString().padLeft(2, '0')}",
        "standings_recalculated_at": standingsRecalculatedAt?.toIso8601String(),
        "games_in_current_week": gamesInCurrentWeek,
        "fixtures": fixtures == null
            ? []
            : List<dynamic>.from(fixtures!.map((x) => x.toJson())),
      };
}

class TopScorer {
  int? id;
  int? seasonId;
  int? playerId;
  int? typeId;
  int? position;
  int? total;
  int? participantId;
  PlayerModel? player;
  Type? type;
  Participant? participant;

  TopScorer({
    this.id,
    this.seasonId,
    this.playerId,
    this.typeId,
    this.position,
    this.total,
    this.participantId,
    this.player,
    this.type,
    this.participant,
  });

  factory TopScorer.fromJson(Map<String, dynamic> json) => TopScorer(
        id: json["id"],
        seasonId: json["season_id"],
        playerId: json["player_id"],
        typeId: json["type_id"],
        position: json["position"],
        total: json["total"],
        participantId: json["participant_id"],
        player: json["player"] == null
            ? null
            : PlayerModel.fromJson(json["player"]),
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        participant: json["participant"] == null
            ? null
            : Participant.fromJson(json["participant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_id": seasonId,
        "player_id": playerId,
        "type_id": typeId,
        "position": position,
        "total": total,
        "participant_id": participantId,
        "player": player?.toJson(),
        "type": type?.toJson(),
      };
}

class PlayerModel {
  int? id;
  int? sportId;
  int? countryId;
  int? nationalityId;
  int? cityId;
  int? positionId;
  int? detailedPositionId;
  int? typeId;
  String? commonName;
  String? firstname;
  String? lastname;
  String? name;
  String? displayName;
  String? imagePath;
  int? height;
  int? weight;
  DateTime? dateOfBirth;
  String? gender;
  Country? country;

  PlayerModel({
    this.id,
    this.sportId,
    this.countryId,
    this.nationalityId,
    this.cityId,
    this.positionId,
    this.detailedPositionId,
    this.typeId,
    this.commonName,
    this.firstname,
    this.lastname,
    this.name,
    this.displayName,
    this.imagePath,
    this.height,
    this.weight,
    this.dateOfBirth,
    this.gender,
    this.country,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        nationalityId: json["nationality_id"],
        cityId: json["city_id"],
        positionId: json["position_id"],
        detailedPositionId: json["detailed_position_id"],
        typeId: json["type_id"],
        commonName: json["common_name"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        name: json["name"],
        displayName: json["display_name"],
        imagePath: json["image_path"],
        height: json["height"],
        weight: json["weight"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "nationality_id": nationalityId,
        "city_id": cityId,
        "position_id": positionId,
        "detailed_position_id": detailedPositionId,
        "type_id": typeId,
        "common_name": commonName,
        "firstname": firstname,
        "lastname": lastname,
        "name": name,
        "display_name": displayName,
        "image_path": imagePath,
        "height": height,
        "weight": weight,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
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

class Type {
  int? id;
  Name? name;
  Code? code;
  DeveloperName? developerName;
  ModelType? modelType;
  StatGroup? statGroup;

  Type({
    this.id,
    this.name,
    this.code,
    this.developerName,
    this.modelType,
    this.statGroup,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        code: codeValues.map[json["code"]]!,
        developerName: developerNameValues.map[json["developer_name"]]!,
        modelType: modelTypeValues.map[json["model_type"]]!,
        // statGroup: statGroupValues.map[json["stat_group"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "code": codeValues.reverse[code],
        "developer_name": developerNameValues.reverse[developerName],
        "model_type": modelTypeValues.reverse[modelType],
        "stat_group": statGroupValues.reverse[statGroup],
      };
}

enum Code {
  ASSIST_TOPSCORER,
  GOAL_TOPSCORER,
  MISSED_PENALTY_TOPSCORER,
  PENALTY_TOPSCORER,
  REDCARDS,
  YELLOWCARDS
}

final codeValues = EnumValues({
  "assist-topscorer": Code.ASSIST_TOPSCORER,
  "goal-topscorer": Code.GOAL_TOPSCORER,
  "missed-penalty-topscorer": Code.MISSED_PENALTY_TOPSCORER,
  "penalty-topscorer": Code.PENALTY_TOPSCORER,
  "redcards": Code.REDCARDS,
  "yellowcards": Code.YELLOWCARDS
});

enum DeveloperName {
  ASSIST_TOPSCORER,
  GOAL_TOPSCORER,
  MISSED_PENALTY_TOPSCORER,
  PENALTY_TOPSCORER,
  REDCARDS,
  YELLOWCARDS
}

final developerNameValues = EnumValues({
  "ASSIST_TOPSCORER": DeveloperName.ASSIST_TOPSCORER,
  "GOAL_TOPSCORER": DeveloperName.GOAL_TOPSCORER,
  "MISSED_PENALTY_TOPSCORER": DeveloperName.MISSED_PENALTY_TOPSCORER,
  "PENALTY_TOPSCORER": DeveloperName.PENALTY_TOPSCORER,
  "REDCARDS": DeveloperName.REDCARDS,
  "YELLOWCARDS": DeveloperName.YELLOWCARDS
});

enum ModelType { STATISTIC }

final modelTypeValues = EnumValues({"statistic": ModelType.STATISTIC});

enum Name {
  ASSIST_TOPSCORER,
  GOAL_TOPSCORER,
  MISSED_PENALTY_TOPSCORER,
  PENALTY_TOPSCORER,
  REDCARDS,
  YELLOWCARDS
}

final nameValues = EnumValues({
  "Assist Topscorer": Name.ASSIST_TOPSCORER,
  "Goal Topscorer": Name.GOAL_TOPSCORER,
  "Missed Penalty Topscorer": Name.MISSED_PENALTY_TOPSCORER,
  "Penalty Topscorer": Name.PENALTY_TOPSCORER,
  "Redcards": Name.REDCARDS,
  "Yellowcards": Name.YELLOWCARDS
});

enum StatGroup { OFFENSIVE, OVERALL }

final statGroupValues = EnumValues(
    {"offensive": StatGroup.OFFENSIVE, "overall": StatGroup.OVERALL});
