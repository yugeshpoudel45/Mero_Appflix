import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color red = Colors.red;

  //!----------------CheckBox part here-------------
  // bool checkBox = false;
  // void _onPressedCheckBox() {
  //   setState(() {
  //     checkBox = !checkBox;
  //   });
  // }
    //!--------------CheckBox part here--------------

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
            //!-----------Buttons--------------
            // PrimaryLongButton(text: "Sign in", func: () {}),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SecondaryButton(text: "Sign in", func: () {}),
            //     PrimaryShortButton(text: "Sign in", func: () {}),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
