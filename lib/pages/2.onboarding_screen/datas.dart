import 'package:netflix/config/app_constants.dart';
import 'package:netflix/pages/2.onboarding_screen/model.dart';

import '../../config/app_local_assets.dart';

final List<OnBoardingModel> onBoardingpages = [
  OnBoardingModel(
    title: "Welcome to ${AppConstants.appName}",
    description:
        "Dive into the best movie app, where every click unlocks thrilling stories and endless joy!",
    imagePath: AppAssets.onBoard1,
  ),
  OnBoardingModel(
    title: "Your Ultimate Movie Companion",
    description:
        " Explore, discover, and enjoy endless cinematic adventures with ease!",
    imagePath: AppAssets.onBoard1,
  ),
  OnBoardingModel(
    title: "Dive into the Magic of Cinema",
    description:
        "Unveil the magic of movies effortlessly with ${AppConstants.appName}.",
    imagePath: AppAssets.onBoard1,
  ),
];
