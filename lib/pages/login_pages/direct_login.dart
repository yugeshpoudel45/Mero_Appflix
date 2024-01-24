import 'package:flutter/material.dart';
import 'package:netflix/components/buttons/primary_long_button.dart';
import 'package:netflix/config/app_local_assets.dart';

import '../../components/buttons/direct_login_button.dart';

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
            SizedBox(height: mySize.height / 48),
            Text(
              "Let's you in",
              style: myTextTheme.displayMedium,
            ),
            SizedBox(height: mySize.height / 24),
            DirectLoginButton(
              haveText: true,
              text: "Facebook",
              func: () {},
              logo: AppAssets.facebook,
            ),
            SizedBox(height: mySize.height / 32),
            DirectLoginButton(
              haveText: true,
              text: "Google",
              func: () {},
              logo: AppAssets.google,
            ),
            SizedBox(height: mySize.height / 32),
            DirectLoginButton(
              haveText: true,
              text: "Apple",
              func: () {},
              logo: AppAssets.apple,
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
            SizedBox(height: mySize.height / 32),
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
            SizedBox(height: mySize.height / 80),
          ],
        ),
      ),
    );
  }
}
