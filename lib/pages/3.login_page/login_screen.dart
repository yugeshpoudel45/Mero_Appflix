import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/components/checkbox/app_checkbox.dart';
import 'package:netflix/components/local_storage/login_checker.dart';
import 'package:netflix/components/urls/url_launcher.dart';
import 'package:netflix/cubit/guest_session_cubit.dart';
import 'package:netflix/cubit/network_cubit.dart';
import 'package:netflix/cubit/network_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/Error/error_page.dart';
import '../../config/app_local_assets.dart';
import '../../cubit/login_session_cubit.dart';
import '../../routes/app_route_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _checkBox = false;
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onPressedCheckBox() {
    setState(() {
      _checkBox = !_checkBox;
    });
  }

  @override
  void initState() {
    getRememberMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (state == NetworkState.disconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'PLEASE CONNECT TO THE INTERNET',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                backgroundColor: Colors.red[400],
                duration: const Duration(days: 1),
                behavior: SnackBarBehavior.fixed,
                dismissDirection: DismissDirection.none,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  height: mySize.height / 6,
                ),
                SizedBox(height: mySize.height / 64),
                Text(
                  "Login to Your Account",
                  style: myTextTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: mySize.height / 64),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: myColorScheme.onInverseSurface,
                    hintText: "Username",
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
                    prefixIcon: const Icon(Icons.email_rounded),
                  ),
                ),
                SizedBox(height: mySize.height / 32),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: myColorScheme.onInverseSurface,
                    hintText: "Password",
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
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _togglePassword();
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
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
                SizedBox(
                  height: mySize.height / 14,
                  width: mySize.width,
                  child: Material(
                    type: MaterialType.button,
                    elevation: 2,
                    shadowColor: myColorScheme.onBackground,
                    color: myColorScheme.onTertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<LoginSessionCubit>()
                            .onGeneratingLoginSession(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            );
                        if (_checkBox) {
                          saveRememberMe(
                            _usernameController.text,
                            _passwordController.text,
                          );
                        } else {
                          deleteRememberMe();
                        }
                      },
                      child: Text("Login",
                          style: myTextTheme.labelLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
                SizedBox(height: mySize.height / 40),
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
                        launchURL("https://www.themoviedb.org/signup");
                      },
                      child: Text(
                        "Register",
                        style: myTextTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
                BlocBuilder<LoginSessionCubit, LoginSessionState>(
                  builder: (context, state) {
                    if (state is LoginSessionInitial) {
                      return SizedBox(height: mySize.height / 12);
                    }
                    if (state is LoginSessionLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoginSessionErrorState) {
                      Fluttertoast.showToast(
                        msg: 'Login Failed!',
                        backgroundColor: Colors.green,
                      );
                      return SizedBox(
                        height: mySize.height / 12,
                        child: const Center(
                          child: Text(
                            "Invalid username or password",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    } else if (state is LoginSessionLoadedState) {
                      _storeLoginSessionId(
                        state.loginSessionModel.sessionId.toString(),
                      );
                      Fluttertoast.showToast(
                        msg: 'Login Successful!',
                        backgroundColor: Colors.green,
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        MyLogin.isLoggedIn(true);
                        GoRouter.of(context).pushReplacementNamed(
                          MyAppRouteConstants.mainPage,
                        );
                      });
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
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
                SizedBox(height: mySize.height / 40),
                SizedBox(
                  height: mySize.height / 14,
                  width: double.maxFinite,
                  child: OutlinedButton(
                    onPressed: () async {
                      context
                          .read<GuestSessionCubit>()
                          .onGeneratingGuestSession();
                      MyLogin.isLoggedIn(true);
                      Fluttertoast.showToast(
                        msg: 'Login Successful!',
                        backgroundColor: Colors.green,
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        GoRouter.of(context).pushReplacementNamed(
                          MyAppRouteConstants.mainPage,
                        );
                      });
                    },
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
                    child: BlocBuilder<GuestSessionCubit, GuestSessionState>(
                      builder: (context, state) {
                        if (state is GuestSessionInitial) {
                          return Text(
                            "Continue as Guest",
                            style: myTextTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        if (state is GuestSessionLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GuestSessionErrorState) {
                          Fluttertoast.showToast(
                            msg: "Login Failed!",
                            backgroundColor: Colors.red,
                          );
                          return ShowErrorMessage(
                            errorMessage: state.errorMessage,
                            extraInfo: "😞",
                          );
                        } else if (state is GuestSessionLoadedState) {
                          _storeGuestSessionId(
                            state.guestSessionModel.guestSessionId.toString(),
                          );
                          return Text(
                            "Continue as Guest",
                            style: myTextTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _storeGuestSessionId(String guestSessionId) async {
    SharedPreferences guestSp = await SharedPreferences.getInstance();
    guestSp.setString("guestSessionId", guestSessionId);
    guestSp.setBool("isGuest", true);
  }

  void _storeLoginSessionId(String sessionId) async {
    SharedPreferences loginSp = await SharedPreferences.getInstance();
    loginSp.setString("sessionId", sessionId);
    loginSp.setBool("isGuest", false);
  }

  Future<void> saveRememberMe(String userName, String password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("username", userName);
    sp.setString("password", password);
  }

  Future<void> getRememberMe() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _usernameController.text = sp.getString("username") ?? "";
    _passwordController.text = sp.getString("password") ?? "";
  }

  Future<void> deleteRememberMe() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('username');
    sp.remove('password');
  }
}
