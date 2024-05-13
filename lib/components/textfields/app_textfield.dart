// import 'package:flutter/material.dart';

// class AppTextField extends StatelessWidget {
//   final String hintText;
//   const AppTextField({super.key, required this.hintText});

//   @override
//   Widget build(BuildContext context) {
//     ColorScheme myColorScheme = Theme.of(context).colorScheme;
//     return TextFormField(
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: myColorScheme.onInverseSurface,
//         hintText: hintText,
//         hintStyle: TextStyle( 
//           fontSize: 14,
//           color: Colors.grey.shade400,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red, width: 1.5),
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//         focusedErrorBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red, width: 1.5),
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//         errorBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red, width: 1.5),
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//         // prefixIconColor: _firstName.text.isEmpty ? Colors.grey : Colors.black,
//         prefixIcon: const Icon(Icons.email_rounded),
//       ),
//     );
//   }
// }

// //!-----------Add these things in the text field--------------
//key
//focusNode
//InputFormatters
//Validators
//keyboardType
// //?----------Take help from EV driver project/ Chatting App----------