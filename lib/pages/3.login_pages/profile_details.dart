// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:netflix/components/textfields/app_textfield.dart';
// import 'package:netflix/config/app_local_assets.dart';

// import '../../components/buttons/other_buttons/bottom_sheet_buttons.dart';

// class ProfileDetails extends StatefulWidget {
//   const ProfileDetails({super.key});

//   @override
//   State<ProfileDetails> createState() => _ProfileDetailsState();
// }

// class _ProfileDetailsState extends State<ProfileDetails> {
//   Uint8List? image;

//   @override
//   Widget build(BuildContext context) {
//     TextTheme myTextTheme = Theme.of(context).textTheme;
//     Size mySize = MediaQuery.sizeOf(context);
//     ColorScheme myColorScheme = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Fill Your Profile",
//           style: myTextTheme.headlineSmall,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 // selectImage();
//                 //!Choose image from local Storage
//               },
//               child: image != null
//                   ? CircleAvatar(
//                       backgroundImage: MemoryImage(image!),
//                       radius: 48,
//                     )
//                   : Stack(
//                       children: [
//                         const CircleAvatar(
//                           radius: 48,
//                           // backgroundColor: Colors.blueAccent,
//                           backgroundImage: AssetImage(AppAssets.onBoard1),
//                         ),
//                         Positioned(
//                           bottom: 4,
//                           right: 4,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               const CircleAvatar(
//                                 radius: 12,
//                                 backgroundColor: Colors.white,
//                               ),
//                               CircleAvatar(
//                                 radius: 10,
//                                 backgroundColor: myColorScheme.primary,
//                                 child: const Icon(
//                                   Icons.add,
//                                   size: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//             SizedBox(height: mySize.height / 40),
//             const AppTextField(hintText: "FullName"),
//             SizedBox(height: mySize.height / 40),
//             const AppTextField(hintText: "Email"),
//             SizedBox(height: mySize.height / 40),
//             const AppTextField(hintText: "Address"),
//             SizedBox(height: mySize.height / 40),
//             const AppTextField(hintText: "Phone Number"),
//             SizedBox(height: mySize.height / 40),
//             const AppTextField(hintText: "Gender"),
//             SizedBox(height: mySize.height / 40),
//           ],
//         ),
//       ),
//       bottomSheet: BottomSheetButtons(
//         buttonText1: "Skip",
//         buttonText2: "Continue",
//         func1: () {},
//         func2: () {
//           onTapShowDialog(
//             context,
//             mySize,
//             myColorScheme,
//             myTextTheme,
//           );
//         },
//       ),
//     );
//   }

//   Future<dynamic> onTapShowDialog(
//     BuildContext context,
//     Size mySize,
//     ColorScheme myColorScheme,
//     TextTheme myTextTheme,
//   ) {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         icon: Icon(
//           Icons.person,
//           size: mySize.height / 16,
//         ),
//         iconColor: myColorScheme.primary,
//         title: const Text("Congratulations!"),
//         titleTextStyle: myTextTheme.headlineMedium!.copyWith(
//           color: myColorScheme.onTertiary,
//           fontWeight: FontWeight.bold,
//         ),
//         content: const Text(
//           "Your account is ready to use. You will be redirected to the Home page in a few seconds.",
//           textAlign: TextAlign.center,
//         ),
//         actions: [
//           SizedBox(
//             height: mySize.height / 8,
//             child: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
