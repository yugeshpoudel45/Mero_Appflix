import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:netflix/components/textfields/app_textfield.dart';
import 'package:netflix/config/app_local_assets.dart';

import '../../components/buttons/other_buttons/bottom_sheet_buttons.dart';

class FillYourProfile extends StatefulWidget {
  const FillYourProfile({super.key});

  @override
  State<FillYourProfile> createState() => _FillYourProfileState();
}

class _FillYourProfileState extends State<FillYourProfile> {
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fill Your Profile",
          style: myTextTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // selectImage();
                //!Choose image from local Storage
              },
              child: image != null
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(image!),
                      radius: 48,
                    )
                  : Stack(
                      children: [
                        const CircleAvatar(
                          radius: 48,
                          // backgroundColor: Colors.blueAccent,
                          backgroundImage: AssetImage(AppAssets.onBoard1),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: myColorScheme.primary,
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: mySize.height / 40),
            const AppTextField(hintText: "FullName"),
            SizedBox(height: mySize.height / 40),
            const AppTextField(hintText: "Email"),
            SizedBox(height: mySize.height / 40),
            const AppTextField(hintText: "Address"),
            SizedBox(height: mySize.height / 40),
            const AppTextField(hintText: "Phone Number"),
            SizedBox(height: mySize.height / 40),
            const AppTextField(hintText: "Gender"),
            SizedBox(height: mySize.height / 40),
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
