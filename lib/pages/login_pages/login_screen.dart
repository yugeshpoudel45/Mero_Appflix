import 'package:flutter/material.dart';
import 'package:netflix/components/app_checkbox.dart';
import 'package:netflix/components/app_textfield.dart';
import 'package:netflix/components/buttons/direct_login_button.dart';
import 'package:netflix/components/buttons/primary_long_button.dart';

import '../../config/app_local_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _checkBox = false;
  void _onPressedCheckBox() {
    setState(() {
      _checkBox = !_checkBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: mySize.height / 20),
              Image.asset(
                AppAssets.appLogo,
                height: mySize.height / 6,
              ),
              SizedBox(height: mySize.height / 64),
              Text(
                "Login to Your Account",
                style: myTextTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: mySize.height / 24),
              const AppTextField(hintText: "Email"),
              SizedBox(height: mySize.height / 32),
              const AppTextField(hintText: "Password"),
              SizedBox(height: mySize.height / 80),
              Row(
                children: [
                  AppCheckBox(
                    checkBox: _checkBox,
                    func: _onPressedCheckBox,
                  ),
                  const Text("Remember me"),
                ],
              ),
              SizedBox(height: mySize.height / 80),
              PrimaryLongButton(text: "Sign in", func: () {}),
              SizedBox(height: mySize.height / 40),
              Text(
                "Forgot the password?",
                style: myTextTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: mySize.height / 48),
              Row(children: <Widget>[
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    "or continue with",
                    style: myTextTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ]),
              SizedBox(height: mySize.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DirectLoginButton(
                    func: () {},
                    logo: AppAssets.facebook,
                    haveText: false,
                    text: "Facebook",
                  ),
                  SizedBox(width: mySize.width / 12),
                  DirectLoginButton(
                    func: () {},
                    logo: AppAssets.google,
                    haveText: false,
                    text: "Google",
                  ),
                  SizedBox(width: mySize.width / 12),
                  DirectLoginButton(
                    func: () {},
                    logo: AppAssets.apple,
                    haveText: false,
                    text: "Apple",
                  ),
                ],
              ),
              SizedBox(height: mySize.height / 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: myTextTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //TODO Add your button logic here
                    },
                    child: Text(
                      "Sign up",
                      style: myTextTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
