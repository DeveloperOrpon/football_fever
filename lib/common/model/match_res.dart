// To parse this JSON data, do
//
//     final matchRes = matchResFromJson(jsonString);
// subType//
import 'dart:convert';
import 'dart:developer';

import 'package:football_fever/common/model/season_match_res.dart';
import 'package:football_fever/utils/helper/log.dart';

MatchRes matchResFromJson(String str) => MatchRes.fromJson(json.decode(str));

String matchResToJson(MatchRes data) => json.encode(data.toJson());

class MatchRes {
  List<MatchModel>? data;
  Pagination? pagination;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  MatchRes({
    this.data,
    this.pagination,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory MatchRes.fromJson(Map<String, dynamic> json) {
    try {
      return MatchRes(
        data: json["data"] == null
            ? []
            : List<MatchModel>.from(
                json["data"]!.map((x) => MatchModel.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
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
      logPrint('MatchRes:$e');
      throw FormatException(e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "subscription": subscription == null
            ? []
            : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "rate_limit": rateLimit?.toJson(),
        "timezone": timezone,
      };
}

class MatchModel {
  int? id;
  int? sportId;
  int? leagueId;
  int? seasonId;
  int? stageId;
  dynamic groupId;
  dynamic aggregateId;
  int? roundId;
  int? stateId;
  int? venueId;
  String? name;
  DateTime? startingAt;
  String? resultInfo;
  dynamic leg;
  dynamic details;
  int? length;
  bool? placeholder;
  bool? hasOdds;
  int? startingAtTimestamp;
  List<Participant>? participants;
  final List<Period>? periods;

  ///NEW
  ///Participant
  List<ScoreElement>? scores;
  League? league;
  List<Lineup>? lineups;
  List<Formation>? formations;
  List<Statistic>? statistics;
  List<Event>? events;
  List<DataCoach>? coaches;

  MatchModel({
    this.id,
    this.sportId,
    this.leagueId,
    this.seasonId,
    this.stageId,
    this.groupId,
    this.aggregateId,
    this.roundId,
    this.stateId,
    this.venueId,
    this.name,
    this.startingAt,
    this.resultInfo,
    this.leg,
    this.periods,
    this.details,
    this.length,
    this.placeholder,
    this.hasOdds,
    this.startingAtTimestamp,
    this.participants,
    this.scores,
    this.league,
    this.lineups,
    this.formations,
    this.statistics,
    this.coaches,
    this.events,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    try {
      return MatchModel(
        id: json["id"],
        sportId: json["sport_id"],
        leagueId: json["league_id"],
        seasonId: json["season_id"],
        stageId: json["stage_id"],
        groupId: json["group_id"],
        aggregateId: json["aggregate_id"],
        roundId: json["round_id"],
        stateId: json["state_id"],
        venueId: json["venue_id"],
        name: json["name"],
        startingAt: json["starting_at"] == null
            ? null
            : DateTime.parse(json["starting_at"]),
        resultInfo: json["result_info"],
        // leg: legValues.map[json["leg"]]!,
        details: json["details"],
        length: json["length"],
        placeholder: json["placeholder"],
        hasOdds: json["has_odds"],
        startingAtTimestamp: json["starting_at_timestamp"],
        participants: json["participants"] == null
            ? []
            : List<Participant>.from(
                json["participants"]!.map((x) => Participant.fromJson(x))),
        scores: json["scores"] == null
            ? []
            : List<ScoreElement>.from(
                json["scores"]!.map((x) => ScoreElement.fromJson(x))),
        league: json["league"] == null ? null : League.fromJson(json["league"]),
        lineups: json["lineups"] == null
            ? []
            : List<Lineup>.from(
                json["lineups"]!.map((x) => Lineup.fromJson(x))),
        formations: json["formations"] == null
            ? []
            : List<Formation>.from(
                json["formations"]!.map((x) => Formation.fromJson(x))),
        statistics: json["statistics"] == null
            ? []
            : List<Statistic>.from(
                json["statistics"]!.map((x) => Statistic.fromJson(x))),
        events: json["events"] == null
            ? []
            : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
        coaches: json["coaches"] == null
            ? []
            : List<DataCoach>.from(
                json["coaches"]!.map((x) => DataCoach.fromJson(x))),
        periods: json["periods"] == null
            ? []
            : List<Period>.from(
                json["periods"]!.map((x) => Period.fromJson(x))),
      );
    } catch (e) {
      log("MatchRes Error :$e ");
      throw FormatException("Failed to parse MatchRes from JSON: $e");
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "league_id": leagueId,
        "season_id": seasonId,
        "stage_id": stageId,
        "group_id": groupId,
        "aggregate_id": aggregateId,
        "round_id": roundId,
        "state_id": stateId,
        "venue_id": venueId,
        "name": name,
        "starting_at": startingAt?.toIso8601String(),
        "result_info": resultInfo,
        "leg": leg,
        "details": details,
        "length": length,
        "placeholder": placeholder,
        "has_odds": hasOdds,
        "starting_at_timestamp": startingAtTimestamp,
        "participants": participants == null
            ? []
            : List<dynamic>.from(participants!.map((x) => x.toJson())),
        "scores": scores == null
            ? []
            : List<dynamic>.from(scores!.map((x) => x.toJson())),
        "league": league?.toJson(),
        "lineups": lineups == null
            ? []
            : List<dynamic>.from(lineups!.map((x) => x.toJson())),
        "coaches": coaches == null
            ? []
            : List<dynamic>.from(coaches!.map((x) => x.toJson())),
        "periods": periods == null
            ? []
            : List<dynamic>.from(periods!.map((x) => x.toJson())),
      };
}

class Period {
  final int? id;
  final int? fixtureId;
  final int? typeId;
  final int? started;
  final int? ended;
  final int? countsFrom;
  final bool? ticking;
  final int? sortOrder;
  // final Description? description;
  final int? timeAdded;
  final int? periodLength;
  final int? minutes;
  final int? seconds;
  final bool? hasTimer;

  Period({
    this.id,
    this.fixtureId,
    this.typeId,
    this.started,
    this.ended,
    this.countsFrom,
    this.ticking,
    this.sortOrder,
    // this.description,
    this.timeAdded,
    this.periodLength,
    this.minutes,
    this.seconds,
    this.hasTimer,
  });

  Period copyWith({
    int? id,
    int? fixtureId,
    int? typeId,
    int? started,
    int? ended,
    int? countsFrom,
    bool? ticking,
    int? sortOrder,
    // Description? description,
    int? timeAdded,
    int? periodLength,
    int? minutes,
    int? seconds,
    bool? hasTimer,
  }) =>
      Period(
        id: id ?? this.id,
        fixtureId: fixtureId ?? this.fixtureId,
        typeId: typeId ?? this.typeId,
        started: started ?? this.started,
        ended: ended ?? this.ended,
        countsFrom: countsFrom ?? this.countsFrom,
        ticking: ticking ?? this.ticking,
        sortOrder: sortOrder ?? this.sortOrder,
        // description: description ?? this.description,
        timeAdded: timeAdded ?? this.timeAdded,
        periodLength: periodLength ?? this.periodLength,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds,
        hasTimer: hasTimer ?? this.hasTimer,
      );

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        id: json["id"],
        fixtureId: json["fixture_id"],
        typeId: json["type_id"],
        started: json["started"],
        ended: json["ended"],
        countsFrom: json["counts_from"],
        ticking: json["ticking"],
        sortOrder: json["sort_order"],
        // description: descriptionValues.map[json["description"]]!,
        timeAdded: json["time_added"],
        periodLength: json["period_length"],
        minutes: json["minutes"],
        seconds: json["seconds"],
        hasTimer: json["has_timer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "type_id": typeId,
        "started": started,
        "ended": ended,
        "counts_from": countsFrom,
        "ticking": ticking,
        "sort_order": sortOrder,
        // "description": descriptionValues.reverse[description],
        "time_added": timeAdded,
        "period_length": periodLength,
        "minutes": minutes,
        "seconds": seconds,
        "has_timer": hasTimer,
      };
}

class DataCoach {
  num? id;
  num? playerId;
  num? sportId;
  num? countryId;
  num? nationalityId;
  dynamic cityId;
  String? commonName;
  String? firstname;
  String? lastname;
  String? name;
  String? displayName;
  String? imagePath;
  num? height;
  dynamic weight;
  DateTime? dateOfBirth;
  String? gender;

  DataCoach({
    this.id,
    this.playerId,
    this.sportId,
    this.countryId,
    this.nationalityId,
    this.cityId,
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
  });

  factory DataCoach.fromJson(Map<String, dynamic> json) => DataCoach(
        id: json["id"],
        playerId: json["player_id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        nationalityId: json["nationality_id"],
        cityId: json["city_id"],
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
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "player_id": playerId,
        "sport_id": sportId,
        "country_id": countryId,
        "nationality_id": nationalityId,
        "city_id": cityId,
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

class League {
  num? id;
  num? sportId;
  num? countryId;
  String? name;
  bool? active;
  String? shortCode;
  String? imagePath;
  dynamic type;
  dynamic subType;
  DateTime? lastPlayedAt;
  num? category;
  bool? hasJerseys;
  List<Season>? seasons;
  Country? country;

  League({
    this.id,
    this.sportId,
    this.countryId,
    this.name,
    this.active,
    this.shortCode,
    this.imagePath,
    this.type,
    this.subType,
    this.lastPlayedAt,
    this.category,
    this.hasJerseys,
    this.seasons,
    this.country,
  });

  factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        name: json["name"],
        active: json["active"],
        shortCode: json["short_code"],
        imagePath: json["image_path"],
        type: json["type"],
        // subType: subTypeEnumValues.map[json["sub_type"]]!,
        lastPlayedAt: json["last_played_at"] == null
            ? null
            : DateTime.parse(json["last_played_at"]),
        category: json["category"],
        hasJerseys: json["has_jerseys"],
        seasons: json["seasons"] == null
            ? []
            : List<Season>.from(
                json["seasons"]!.map((x) => Season.fromJson(x))),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "name": name,
        "active": active,
        "short_code": shortCode,
        "image_path": imagePath,
        "type": type,
        "sub_type": subType,
        "last_played_at": lastPlayedAt?.toIso8601String(),
        "category": category,
        "has_jerseys": hasJerseys,
        "seasons": seasons == null
            ? []
            : List<dynamic>.from(seasons!.map((x) => x.toJson())),
        "country": country?.toJson(),
      };
}

class Season {
  num? id;
  num? sportId;
  num? leagueId;
  num? tieBreakerRuleId;
  String? name;
  bool? finished;
  bool? pending;
  bool? isCurrent;
  DateTime? startingAt;
  DateTime? endingAt;
  DateTime? standingsRecalculatedAt;
  bool? gamesInCurrentWeek;

  Season({
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
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
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
        "starting_at": startingAt == null
            ? null
            : "${startingAt!.year.toString().padLeft(4, '0')}-${startingAt!.month.toString().padLeft(2, '0')}-${startingAt!.day.toString().padLeft(2, '0')}",
        "ending_at": endingAt == null
            ? null
            : "${endingAt!.year.toString().padLeft(4, '0')}-${endingAt!.month.toString().padLeft(2, '0')}-${endingAt!.day.toString().padLeft(2, '0')}",
        "standings_recalculated_at": standingsRecalculatedAt?.toIso8601String(),
        "games_in_current_week": gamesInCurrentWeek,
      };
}

class Lineup {
  num? id;
  num? sportId;
  num? fixtureId;
  num? playerId;
  num? teamId;
  num? positionId;
  String? formationField;
  num? typeId;
  num? formationPosition;
  String? playerName;
  num? jerseyNumber;

  Lineup({
    this.id,
    this.sportId,
    this.fixtureId,
    this.playerId,
    this.teamId,
    this.positionId,
    this.formationField,
    this.typeId,
    this.formationPosition,
    this.playerName,
    this.jerseyNumber,
  });

  factory Lineup.fromJson(Map<String, dynamic> json) => Lineup(
        id: json["id"],
        sportId: json["sport_id"],
        fixtureId: json["fixture_id"],
        playerId: json["player_id"],
        teamId: json["team_id"],
        positionId: json["position_id"],
        formationField: json["formation_field"],
        typeId: json["type_id"],
        formationPosition: json["formation_position"],
        playerName: json["player_name"],
        jerseyNumber: json["jersey_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "fixture_id": fixtureId,
        "player_id": playerId,
        "team_id": teamId,
        "position_id": positionId,
        "formation_field": [formationField],
        "type_id": typeId,
        "formation_position": formationPosition,
        "player_name": playerName,
        "jersey_number": jerseyNumber,
      };
}

class Participant {
  num? id;
  num? sportId;
  num? countryId;
  num? venueId;
  String? gender;
  String? name;
  String? shortCode;
  String? imagePath;
  num? founded;
  dynamic type;
  bool? placeholder;
  DateTime? lastPlayedAt;
  ParticipantMeta? meta;

  Participant({
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
    this.meta,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    try {
      return Participant(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        venueId: json["venue_id"],
        name: json["name"],
        shortCode: json["short_code"],
        imagePath: json["image_path"],
        founded: json["founded"],
        type: json["type"],
        placeholder: json["placeholder"],
        lastPlayedAt: json["last_played_at"] == null
            ? null
            : DateTime.parse(json["last_played_at"]),
        meta: json["meta"] == null
            ? null
            : ParticipantMeta.fromJson(json["meta"]),
      );
    } catch (e) {
      log("Participant Error :$e ${json["type"]}");
      throw FormatException("Failed to parse MatchRes from JSON: $e");
    }
  }

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
        "meta": meta?.toJson(),
      };
}

class ParticipantMeta {
  Location? location;
  bool? winner;
  num? position;

  ParticipantMeta({
    this.location,
    this.winner,
    this.position,
  });

  factory ParticipantMeta.fromJson(Map<String, dynamic> json) =>
      ParticipantMeta(
        location: locationValues.map[json["location"]]!,
        winner: json["winner"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "location": locationValues.reverse[location],
        "winner": winner,
        "position": position,
      };
}

enum Location { AWAY, HOME }

final locationValues =
    EnumValues({"away": Location.AWAY, "home": Location.HOME});

class ScoreElement {
  num? id;
  num? fixtureId;
  num? typeId;
  num? participantId;
  ScoreScore? score;
  Description? description;

  ScoreElement({
    this.id,
    this.fixtureId,
    this.typeId,
    this.participantId,
    this.score,
    this.description,
  });

  factory ScoreElement.fromJson(Map<String, dynamic> json) => ScoreElement(
        id: json["id"],
        fixtureId: json["fixture_id"],
        typeId: json["type_id"],
        participantId: json["participant_id"],
        score:
            json["score"] == null ? null : ScoreScore.fromJson(json["score"]),
        description: descriptionValues.map[json["description"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "type_id": typeId,
        "participant_id": participantId,
        "score": score?.toJson(),
        "description": descriptionValues.reverse[description],
      };
}

enum Description { CURRENT, THE_1_ST_HALF, THE_2_ND_HALF }

final descriptionValues = EnumValues({
  "CURRENT": Description.CURRENT,
  "1ST_HALF": Description.THE_1_ST_HALF,
  "2ND_HALF": Description.THE_2_ND_HALF
});

class ScoreScore {
  int? goals;
  Location? participant;

  ScoreScore({
    this.goals,
    this.participant,
  });

  factory ScoreScore.fromJson(Map<String, dynamic> json) => ScoreScore(
        goals: json["goals"],
        participant: locationValues.map[json["participant"]]!,
      );

  Map<String, dynamic> toJson() => {
        "goals": goals,
        "participant": locationValues.reverse[participant],
      };
}

class Pagination {
  int? count;
  int? perPage;
  int? currentPage;
  dynamic nextPage;
  bool? hasMore;

  Pagination({
    this.count,
    this.perPage,
    this.currentPage,
    this.nextPage,
    this.hasMore,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        hasMore: json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "next_page": nextPage,
        "has_more": hasMore,
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
  SubscriptionMeta? meta;
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
        meta: json["meta"] == null
            ? null
            : SubscriptionMeta.fromJson(json["meta"]),
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

class SubscriptionMeta {
  dynamic trialEndsAt;
  DateTime? endsAt;
  int? currentTimestamp;

  SubscriptionMeta({
    this.trialEndsAt,
    this.endsAt,
    this.currentTimestamp,
  });

  factory SubscriptionMeta.fromJson(Map<String, dynamic> json) =>
      SubscriptionMeta(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class Formation {
  int? id;
  int? fixtureId;
  int? participantId;
  String? formation;
  Location? location;

  Formation({
    this.id,
    this.fixtureId,
    this.participantId,
    this.formation,
    this.location,
  });

  factory Formation.fromJson(Map<String, dynamic> json) => Formation(
        id: json["id"],
        fixtureId: json["fixture_id"],
        participantId: json["participant_id"],
        formation: json["formation"],
        location: locationValues.map[json["location"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "participant_id": participantId,
        "formation": formation,
        "location": locationValues.reverse[location],
      };
}

class Statistic {
  int? id;
  int? fixtureId;
  int? typeId;
  int? participantId;
  Data? data;
  Location? location;

  Statistic({
    this.id,
    this.fixtureId,
    this.typeId,
    this.participantId,
    this.data,
    this.location,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        id: json["id"],
        fixtureId: json["fixture_id"],
        typeId: json["type_id"],
        participantId: json["participant_id"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        location: locationValues.map[json["location"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "type_id": typeId,
        "participant_id": participantId,
        "data": data?.toJson(),
        "location": locationValues.reverse[location],
      };
}

class Data {
  num? value;

  Data({
    this.value,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Event {
  int? id;
  int? fixtureId;
  int? periodId;
  int? participantId;
  int? typeId;
  Section? section;
  int? playerId;
  int? relatedPlayerId;
  String? playerName;
  String? relatedPlayerName;
  String? result;
  String? info;
  String? addition;
  num? minute;
  num? extraMinute;
  bool? injured;
  bool? onBench;
  num? coachId;
  num? subTypeId;
  Type? type;
  Participant? participant;

  Event({
    this.id,
    this.fixtureId,
    this.periodId,
    this.participantId,
    this.typeId,
    this.section,
    this.playerId,
    this.relatedPlayerId,
    this.playerName,
    this.relatedPlayerName,
    this.result,
    this.info,
    this.addition,
    this.minute,
    this.extraMinute,
    this.injured,
    this.onBench,
    this.coachId,
    this.subTypeId,
    this.type,
    this.participant,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    try {
      return Event(
        id: json["id"],
        fixtureId: json["fixture_id"],
        periodId: json["period_id"],
        participantId: json["participant_id"],
        typeId: json["type_id"],
        section: sectionValues.map[json["section"]],
        playerId: json["player_id"],
        relatedPlayerId: json["related_player_id"],
        playerName: json["player_name"],
        relatedPlayerName: json["related_player_name"],
        result: json["result"],
        info: json["info"],
        addition: json["addition"],
        minute: json["minute"],
        extraMinute: json["extra_minute"],
        injured: json["injured"],
        onBench: json["on_bench"],
        coachId: json["coach_id"],
        subTypeId: json["sub_type_id"],
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        participant: json["participant"] == null
            ? null
            : Participant.fromJson(json["participant"]),
      );
    } catch (e) {
      throw FormatException("Failed to parse MatchRes from JSON: $e");
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "period_id": periodId,
        "participant_id": participantId,
        "type_id": typeId,
        "section": sectionValues.reverse[section],
        "player_id": playerId,
        "related_player_id": relatedPlayerId,
        "player_name": playerName,
        "related_player_name": relatedPlayerName,
        "result": result,
        "info": info,
        "addition": addition,
        "minute": minute,
        "extra_minute": extraMinute,
        "injured": injured,
        "on_bench": onBench,
        "coach_id": coachId,
        "sub_type_id": subTypeId,
        "type": type?.toJson(),
        "participant": participant?.toJson(),
      };
}

enum Section { EVENT }

final sectionValues = EnumValues({"event": Section.EVENT});

class Type {
  int? id;
  TypeName? name;
  TypeCode? code;
  DeveloperName? developerName;
  Section? modelType;
  dynamic statGroup;

  Type({
    this.id,
    this.name,
    this.code,
    this.developerName,
    this.modelType,
    this.statGroup,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    try {
      return Type(
        id: json["id"],
        name: typeNameValues.map[json["name"]],
        code: typeCodeValues.map[json["code"]],
        developerName: developerNameValues.map[json["developer_name"]],
        modelType: sectionValues.map[json["model_type"]],
        // statGroup: json["stat_group"],
      );
    } catch (e) {
      log("TypeJsonMap: ${json["code"]}--${typeNameValues.map[json["code"]]}");
      throw const FormatException('');
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": typeNameValues.reverse[name],
        "code": typeCodeValues.reverse[code],
        "developer_name": developerNameValues.reverse[developerName],
        "model_type": sectionValues.reverse[modelType],
        "stat_group": statGroup,
      };
}

enum TypeCode {
  GOAL,
  MISSED_PENALTY,
  OWNGOAL,
  PENALTY,
  REDCARD,
  SUBSTITUTION,
  VAR,
  VAR_CARD,
  YELLOWCARD,
  YELLOWREDCARD,
  CORNER,
}

final typeCodeValues = EnumValues({
  "goal": TypeCode.GOAL,
  "missed_penalty": TypeCode.MISSED_PENALTY,
  "owngoal": TypeCode.OWNGOAL,
  "penalty": TypeCode.PENALTY,
  "redcard": TypeCode.REDCARD,
  "substitution": TypeCode.SUBSTITUTION,
  "VAR": TypeCode.VAR,
  "VAR_CARD": TypeCode.VAR_CARD,
  "yellowcard": TypeCode.YELLOWCARD,
  "yellowredcard": TypeCode.YELLOWREDCARD,
  "corner": TypeCode.CORNER,
});

enum DeveloperName {
  GOAL,
  MISSED_PENALTY,
  OWNGOAL,
  PENALTY,
  REDCARD,
  SUBSTITUTION,
  VAR,
  VAR_CARD,
  YELLOWCARD,
  YELLOWREDCARD,
  CORNER
}

final developerNameValues = EnumValues({
  "GOAL": DeveloperName.GOAL,
  "MISSED_PENALTY": DeveloperName.MISSED_PENALTY,
  "OWNGOAL": DeveloperName.OWNGOAL,
  "PENALTY": DeveloperName.PENALTY,
  "REDCARD": DeveloperName.REDCARD,
  "SUBSTITUTION": DeveloperName.SUBSTITUTION,
  "VAR": DeveloperName.VAR,
  "VAR_CARD": DeveloperName.VAR_CARD,
  "YELLOWCARD": DeveloperName.YELLOWCARD,
  "YELLOWREDCARD": DeveloperName.YELLOWREDCARD,
  "CORNER": DeveloperName.CORNER,
});

enum TypeName {
  CORNER,
  GOAL,
  MISSED_PENALTY,
  PENALTY,
  REDCARD,
  SUBSTITUTION,
  VAR,
  VAR_CARD,
  OWN_GOAL,
  YELLOWCARD,
  YELLOW_RED_CARD,
}

final typeNameValues = EnumValues({
  "Corner": TypeName.CORNER,
  "Goal": TypeName.GOAL,
  "Missed Penalty": TypeName.MISSED_PENALTY,
  "Penalty": TypeName.PENALTY,
  "Redcard": TypeName.REDCARD,
  "Substitution": TypeName.SUBSTITUTION,
  "VAR": TypeName.VAR,
  "VAR_CARD": TypeName.VAR_CARD,
  "Yellowcard": TypeName.YELLOWCARD,
  "Own Goal": TypeName.OWN_GOAL,
  "Yellow/Red card": TypeName.YELLOW_RED_CARD,
});
