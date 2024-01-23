import 'package:flutter/material.dart';
import 'package:netflix/components/app_textfield.dart';
import 'package:netflix/components/buttons/primary_long_button.dart';
import 'package:netflix/config/app_local_assets.dart';

class DirectLoginScreen extends StatelessWidget {
  const DirectLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              AppAssets.appLogo,
              height: mySize.height / 6,
            ),
            SizedBox(height: mySize.height / 16),
            Text(
              "Let's you in",
              style: myTextTheme.displayMedium,
            ),
            SizedBox(height: mySize.height / 24),
            DirectLoginButton(
              text: "Facebook",
              func: () {},
              logo: AppAssets.facebook,
            ),
            SizedBox(height: mySize.height / 32),
            DirectLoginButton(
              text: "Google",
              func: () {},
              logo: AppAssets.google,
            ),
            SizedBox(height: mySize.height / 24),
            Row(children: <Widget>[
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  "or",
                  style: myTextTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ]),
            SizedBox(height: mySize.height / 24),
            PrimaryLongButton(
              text: "Sign in with Email",
              func: () {},
            ),
            SizedBox(height: mySize.height / 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: myTextTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
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
            SizedBox(height: mySize.height / 32),
          ],
        ),
      ),
    );
  }
}

class DirectLoginButton extends StatelessWidget {
  final String logo;
  final String text;
  final VoidCallback func;
  const DirectLoginButton(
      {super.key, required this.text, required this.func, required this.logo});

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: mySize.height / 12,
      width: mySize.width,
      child: OutlinedButton(
          onPressed: func,
          style: OutlinedButton.styleFrom(
            backgroundColor: myColorScheme.onInverseSurface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            side: BorderSide(
              width: 0.1,
              color: myColorScheme.inverseSurface,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logo,
                height: 32,
                width: 32,
              ),
              SizedBox(
                width: mySize.width / 32,
              ),
              Text(
                "Continue with $text",
                style: myTextTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}
