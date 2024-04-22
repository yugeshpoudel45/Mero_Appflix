import 'package:flutter/material.dart';
import 'package:netflix/pages/4.choose_Interest_page/data.dart';

import '../../components/buttons/other_buttons/bottom_sheet_buttons.dart';
import '../../components/buttons/other_buttons/choosing_button.dart';

class ChooseInterestScreen extends StatelessWidget {
  const ChooseInterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Your Interest",
          style: myTextTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              "Chooose your interest and get the best movie recommendations. Don't worry, you can always change it later.",
            ),
            SizedBox(
              height: mySize.height / 16,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 12.0,
              children: severalCategories.map((data) {
                return ChoosingItemButton(text: data, buttonPressed: () {
                  
                }, isFilled: false,);
              }).toList(),
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheetButtons(
        buttonText1: "Skip",
        buttonText2: "Continue",
        func1: () {},
        func2: () {},
        
      ),
    );
  }
}
