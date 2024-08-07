import 'dart:developer';

import 'package:football_fever/backend/api_header.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../backend/api_client.dart';
import '../../../backend/api_endpoints.dart';
import '../../../common/model/league_news_res.dart';
import '../../../common/model/news_res.dart';

class NewsController extends GetxController {
  RxInt topNewsSliderCurrentIndex = RxInt(0);
  @override
  onInit() {
    getTodayNews();
    getLeagueWaysNews();
    super.onInit();
  }

  //today news
  RxBool isLiveTodayNews = RxBool(false);
  Rxn<NewsRes> todayNewsRes = Rxn<NewsRes>();
  RxList<NewsModel> todayNewsList = RxList<NewsModel>([]);
  int newsPage = 1;
  RxList<NewsModel> todayNewsPageNewsList = RxList<NewsModel>([]);

  getTodayNews() async {
    ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.newsTodayURL}?page=$newsPage',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      ifLoading: () {
        isLiveTodayNews.value = true;
      },
      ifSucceed: (response) {
        Map<String, dynamic> serverMap = response.data;
        todayNewsRes.value = NewsRes.fromJson(serverMap);
        if (newsPage == 1) {
          todayNewsList.value = todayNewsRes.value!.data!.docs ?? [];
          todayNewsPageNewsList.value = todayNewsRes.value!.data!.docs ?? [];
        } else {
          List<NewsModel> tempData = todayNewsPageNewsList.value;
          tempData.addAll(todayNewsRes.value!.data!.docs ?? []);
          todayNewsPageNewsList.value = [];
          todayNewsPageNewsList.value = tempData;
        }
      },
      ifFailed: (error) {
        isLiveTodayNews.value = false;
      },
    );
  }

  ///refresh today news
  RefreshController refreshControllerTodayNews =
      RefreshController(initialRefresh: false);

  void onRefreshTodayNews() async {
    newsPage = 1;
    todayNewsPageNewsList.value = [];
    await getTodayNews();
    refreshControllerTodayNews.refreshCompleted();
  }

  void onLoadingTodayNews() async {
    newsPage++;
    await getTodayNews();
    refreshControllerTodayNews.loadComplete();
  }

  ///get league by news
  Rxn<LeagueWaysNewsRes> leagueWaysNewsRes = Rxn<LeagueWaysNewsRes>();
  RxList<LeagueWaysNewsModel> leagueWaysNews = RxList<LeagueWaysNewsModel>([]);
  int leagueWaysNewsPage = 1;
  RxBool isLeagueWaysNews = RxBool(false);

  getLeagueWaysNews() async {
    ApiClient.remoteApiCall(
      apiUrl:
          '${APIEndpoints.sportsBaseUrl}${APIEndpoints.leagueWaysURL}?page=$leagueWaysNewsPage',
      reqType: ApiRequestType.get,
      headers: APIHeader.sportsApiHeader,
      ifLoading: () {
        isLeagueWaysNews.value = true;
      },
      ifSucceed: (response) {
        Map<String, dynamic> newsServerRes = response.data;
        leagueWaysNewsRes.value = LeagueWaysNewsRes.fromJson(newsServerRes);
        if (leagueWaysNewsPage == 1) {
          leagueWaysNews.value = leagueWaysNewsRes.value!.data!.docs ?? [];
        } else {
          List<LeagueWaysNewsModel> tempData = leagueWaysNews.value;
          tempData.addAll(leagueWaysNewsRes.value!.data!.docs ?? []);
          leagueWaysNews.value = [];
          leagueWaysNews.value = tempData;
        }
        isLeagueWaysNews.value = false;
      },
      ifFailed: (error) {
        isLeagueWaysNews.value = false;
      },
    );
  }

  ///refresh news page
  RefreshController refreshControllerNewsPage =
      RefreshController(initialRefresh: false);

  void onRefreshNewsPage() async {
    leagueWaysNewsPage = 1;
    leagueWaysNewsRes.value = null;
    leagueWaysNews.value = [];
    await getLeagueWaysNews();
    refreshControllerNewsPage.refreshCompleted();
  }

  void onLoadingNewsPage() async {
    leagueWaysNewsPage++;
    await getLeagueWaysNews();
    refreshControllerNewsPage.loadComplete();
  }

  // //league ways news
  // Future<NewsRes> getNewsByLeagueId(String id, String type, int page) async {
  //   Map<String, dynamic> newsServerRes = await connectivityController.userGet(
  //       url: "${APIEndpoints.leagueNewsByIdURL}/$type/$id?page=$page");
  //   return NewsRes.fromJson(newsServerRes);
  // }
  //
  // //get bes by id
  // Future<NewsModel> getNewsById(String id) async {
  //   Map<String, dynamic> newsServerRes = await connectivityController.userGet(
  //     url: "${APIEndpoints.newsTodayURL}/$id",
  //   );
  //   return NewsModel.fromJson(newsServerRes['data']);
  // }
}
