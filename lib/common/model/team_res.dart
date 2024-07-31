import 'dart:convert';

import 'package:football_fever/common/model/match_res.dart';

TeamRes teamResFromJson(String str) => TeamRes.fromJson(json.decode(str));

String teamResToJson(TeamRes data) => json.encode(data.toJson());

class TeamRes {
  final List<Participant>? data;
  final Pagination? pagination;

  TeamRes({
    this.data,
    this.pagination,
  });

  TeamRes copyWith({
    List<Participant>? data,
    Pagination? pagination,
  }) =>
      TeamRes(
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
      );

  factory TeamRes.fromJson(Map<String, dynamic> json) => TeamRes(
        data: json["data"] == null
            ? []
            : List<Participant>.from(
                json["data"]!.map((x) => Participant.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  final bool? hasMore;

  Pagination({
    this.hasMore,
  });

  Pagination copyWith({
    bool? hasMore,
  }) =>
      Pagination(
        hasMore: hasMore ?? this.hasMore,
      );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        hasMore: json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "has_more": hasMore,
      };
}
