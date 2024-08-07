class APIEndpoints {
  // static String apiBaseUrl = Get.find<SplashController>().sportsApiBaseUrl;
  // static String apiBaseToken = Get.find<SplashController>().sportsApiToken;
  // // static const apiBaseUrl = 'http://192.168.66.109:4000/api/cb-cricket/v1/';
  static String sportsBaseUrl = "https://api.cnfzone.com/api/sm-football/v3/";
  static String cacheServerApiToken = 'HSC9mDQJjstIkdmlsrwDhcx8msWlg';
  static const String fixturesUrl = "fixtures/";
  static const String liveScoresUrl = "livescores";
  static const String teamUrl = "teams";
  static const String leagueUrl = "leagues";
  static const String searchTeamUrl = "teams/search/";
  static const String getMatchPredictionUrl = "odds/pre-match/fixtures/";
  static const String getFixtureSeasonIdsUrl = "seasons/";

  ///news
  static const String newsTodayURL = "news";
  static const String leagueWaysURL = "news/by-category";
  static const String leagueNewsByIdURL = "news/category";
}
