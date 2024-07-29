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
        "Our Go-To App For Everything Football. Live Scores, News, Highlights, And More.",
  ),
  OnBoardingModel(
    imageUrl: 'assets/images/onboardingTwo.png',
    bgImage: 'assets/images/onboardingBGTwo.png',
    title: 'Feel The Rush!',
    detail:
        "Stay Updated On Your Favorite Teams And Players With Real-Time Stats And Insights",
  ),
];
