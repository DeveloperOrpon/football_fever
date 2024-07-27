class OnBoardingModel {
  String imageUrl;
  String bgImage;
  String title;
  String detail;

  OnBoardingModel({
    required this.imageUrl,
    required this.title,
    required this.detail,
    required this.bgImage,
  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    imageUrl: 'assets/images/onboardingOne.png',
    bgImage: 'assets/images/onboardingBGOne.png',
    title: 'Football Fever, Catch It!',
    detail:
        "Our Go-To App For \nEverything Football. Live Scores, News,\nHighlights, And More.",
  ),
  OnBoardingModel(
    imageUrl: 'assets/images/onboardingTwo.png',
    bgImage: 'assets/images/onboardingBGTwo.png',
    title: 'Feel The Rush!',
    detail:
        "Stay Updated On Your \nFavorite Teams And Players With \nReal-Time Stats And Insights",
  ),
];
