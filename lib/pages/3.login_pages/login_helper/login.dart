// import 'package:flutter/material.dart';
// import 'package:netflix/components/checkbox/app_checkbox.dart';
// import 'package:netflix/components/textfields/app_textfield.dart';
// import 'package:netflix/components/buttons/direct_login_button/direct_login_button.dart';
// import 'package:netflix/components/buttons/primary_buttons/primary_long_button.dart';

// import '../../../config/app_local_assets.dart';

// class MeroLogin extends StatefulWidget {
//   const MeroLogin({super.key});

//   @override
//   State<MeroLogin> createState() => _MeroLoginState();
// }

// class _MeroLoginState extends State<MeroLogin> {
//   bool _checkBox = false;
//   void _onPressedCheckBox() {
//     setState(() {
//       _checkBox = !_checkBox;
//     }); 
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size mySize = MediaQuery.sizeOf(context);
//     TextTheme myTextTheme = Theme.of(context).textTheme;
//     ColorScheme myColorScheme = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               Image.asset(
//                 AppAssets.appLogo,
//                 height: mySize.height / 6,
//               ),
//               SizedBox(height: mySize.height / 64),
//               Text(
//                 "Login to Your Account",
//                 style: myTextTheme.headlineLarge!.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: mySize.height / 64),
//               const AppTextField(hintText: "Email"),
//               SizedBox(height: mySize.height / 32),
//               const AppTextField(hintText: "Password"),
//               Row(
//                 children: [
//                   AppCheckBox(
//                     checkBox: _checkBox,
//                     func: _onPressedCheckBox,
//                   ),
//                   const Text("Remember me"),
//                 ],
//               ),
//               SizedBox(height: mySize.height / 80),
//               PrimaryLongButton(text: "Sign in", func: () {}),
//               SizedBox(height: mySize.height / 40),
//               Text(
//                 "Forgot the password?",
//                 style: myTextTheme.bodyMedium!.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//               SizedBox(height: mySize.height / 48),
//               Row(children: <Widget>[
//                 const Expanded(child: Divider()),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                   ),
//                   child: Text(
//                     "or continue with",
//                     style: myTextTheme.bodyMedium!.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const Expanded(child: Divider()),
//               ]),
//               SizedBox(height: mySize.height / 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   DirectLoginButton(
//                     func: () {},
//                     myicon: Icons.facebook,
//                     iconColor: Colors.lightBlue,
//                   ),
//                   SizedBox(width: mySize.width / 12),
//                   DirectLoginButton(
//                     func: () {},
//                     isImage: true,
//                     logo: AppAssets.google,
//                   ),
//                   SizedBox(width: mySize.width / 12),
//                   DirectLoginButton(
//                     func: () {},
//                     myicon: Icons.apple,
//                     iconColor: myColorScheme.onSurface,
//                   ),
//                 ],
//               ),
//               SizedBox(height: mySize.height / 48),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don't have an account? ",
//                     style: myTextTheme.bodyMedium!.copyWith(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       //TODO Add your button logic here
//                     },
//                     child: Text(
//                       "Sign up",
//                       style: myTextTheme.bodyMedium!.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.red,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
