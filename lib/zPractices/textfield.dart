import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget firstName() {
  return TextFormField(
    // key: _firstNameKey,
    // inputFormatters: <TextInputFormatter>[
    //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
    // ],
    // focusNode: _firstNameFocusNode,
    // validator: (value) {
    //   if (value!.isEmpty) {
    //     return "First Name is required";
    //   } else if (value.length > 20) {
    //     return "First Name should be lesser than 20 characters";
    //   } else {
    //     return null;
    //   }
    // },

    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade200,
      hintText: "Email",
      hintStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade400,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      // prefixIconColor: _firstName.text.isEmpty ? Colors.grey : Colors.black,
      prefixIcon: const Icon(Icons.email_rounded),
    ),
  );
}

//!-----------Add these things in the text field--------------
//key
//focusNode
//InputFormatters
//Validators
//?----------Take help from EV driver project----------
