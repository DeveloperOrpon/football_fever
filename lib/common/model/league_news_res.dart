import 'dart:convert';
import 'dart:developer';

import 'news_res.dart';

LeagueWaysNewsRes leagueWaysNewsResFromJson(String str) =>
    LeagueWaysNewsRes.fromJson(json.decode(str));

String leagueWaysNewsResToJson(LeagueWaysNewsRes data) =>
    json.encode(data.toJson());

class LeagueWaysNewsRes {
  bool? status;
  Data? data;

  LeagueWaysNewsRes({
    this.status,
    this.data,
  });

  factory LeagueWaysNewsRes.fromJson(Map<String, dynamic> json) =>
      LeagueWaysNewsRes(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  List<LeagueWaysNewsModel>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  Data({
    this.docs,
    this.totalDocs,
    this.limit,
    this.page,
    this.totalPages,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        docs: json["docs"] == null
            ? []
            : List<LeagueWaysNewsModel>.from(
                json["docs"]!.map((x) => LeagueWaysNewsModel.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        page: json["page"],
        totalPages: json["totalPages"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": docs == null
            ? []
            : List<dynamic>.from(docs!.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "page": page,
        "totalPages": totalPages,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class LeagueWaysNewsModel {
  Id? id;
  List<NewsModel>? documents;

  LeagueWaysNewsModel({
    this.id,
    this.documents,
  });

  factory LeagueWaysNewsModel.fromJson(Map<String, dynamic> json) {
    try {
      log("LeagueWaysNewsModel: ${json["documents"]}");
      return LeagueWaysNewsModel(
        id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
        documents: json["documents"] == null
            ? []
            : List<NewsModel>.from(
                json["documents"]!.map((x) => NewsModel.fromJson(x))),
      );
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id?.toJson(),
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
      };
}

class Id {
  String? type;
  int? id;

  Id({
    this.type,
    this.id,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
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
