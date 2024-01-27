import 'package:flutter/material.dart';
import 'package:netflix/components/buttons/primary_buttons/primary_long_button.dart';
import 'package:netflix/pages/2.onboarding_screen/datas.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(onBoardingpages[_currentPage].imagePath),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: Colors.black,
        //TODO Add the background image later on
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onBoardingpages.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Text(
                          onBoardingpages[index].title,
                          textAlign: TextAlign.center,
                          style: myTextTheme.displaySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: mySize.height / 64),
                        Text(
                          onBoardingpages[index].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: mySize.height / 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onBoardingpages.length,
                  (index) => buildDot(index, context),
                ),
              ),
              SizedBox(height: mySize.height / 32),
              PrimaryLongButton(
                  text: "Get Started",
                  func: () {
                    //TODO add functionality here
                  }),
              SizedBox(height: mySize.height / 64),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 12.0,
      width: 12.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _currentPage == index ? myColorScheme.onTertiary : Colors.white,
      ),
    );
  }
}
