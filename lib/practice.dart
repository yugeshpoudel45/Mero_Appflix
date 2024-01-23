import 'package:flutter/material.dart';
import 'package:netflix/components/buttons/primary_long_button.dart';
import 'package:netflix/components/buttons/primary_short_button.dart';
import 'package:netflix/components/buttons/secondary_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color red = Colors.red;

  //!----------------CheckBox part here-------------
  bool checkBox = false;
  void onPressedCheckBox() {
    setState(() {
      checkBox = !checkBox;
    });
    //!--------------CheckBox part here--------------
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello World ',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: myColorScheme.tertiary,
                    fontSize: mySize.width / 8,
                  ),
            ),
            //!----------TextField------------------
            // const AppTextField(hintText: "Email"),
            //!-----------CheckBox----------------
            // AppCheckBox(
            //   checkBox: checkBox,
            //   func: onPressedCheckBox,
            // ),
            //!-----------One Button--------------
            // PrimaryLongButton(text: "Sign in", func: () {}),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SecondaryButton(text: "Sign in", func: () {}),
            //     PrimaryShortButton(text: "Sign in", func: () {}),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: AppButton(
            //     isFilled: true,
            //     text: "Sign in with password",
            //     height: mySize.height / 14,
            //     width: mySize.width,
            //     func: () {},
            //   ),
            // ),
            //!-----------------Two Buttons-------------
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       AppButton(
            //         isFilled: false,
            //         text: "Skip",
            //         height: mySize.height / 14,
            //         width: mySize.width / 2.2,
            //         func: () {},
            //       ),
            //       AppButton(
            //         isFilled: true,
            //         text: "Continue",
            //         height: mySize.height / 14,
            //         width: mySize.width / 2.2,
            //         func: () {},
            //       ),
            //     ],
            //   ),
            // ),
            //!-----------------------------------------
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   // tooltip: 'Increment',
      //   child: Icon(
      //     Icons.add,
      //     size: mySize.height,
      //   ),
      // ),
    );
  }
}
