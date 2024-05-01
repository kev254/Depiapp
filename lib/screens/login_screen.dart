import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../screens/tab_screen.dart';
import '../screens/home_screen.dart';

import '../widgets/password_text_field.dart';
import './signup_screen.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/back_button_ls.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/option_button.dart';
import '../widgets/or_row.dart';
import '../widgets/social_media.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BackButtonLS(),
          SizedBox(height: 30,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Log In Continue!',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // SocialMediaLogin(
                  //   method: 'Login',
                  // ),
                  Spacer(),
                  // OrRow(),
                  Spacer(),
                  Column(
                    children: [
                      CustomTextField(
                        controller: emailController,
                        hint: 'Email Address',
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ),
                      PasswordTextField(
                        hint: 'Password',
                        controller: passwordController,
                        icon: Image.asset('assets/images/hide_icon.png'),
                      ),
                    ],
                  ),
                  Spacer(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       'Forgot Password?',
                  //       style: TextStyle(
                  //         color: kPrimaryGreen,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      login();
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text('Login'),
                  ),

                  Spacer(
                    flex: 4,
                  ),
                  OptionButton(
                    desc: 'Don\'t have an account? ',
                    method: 'Sign Up',
                    onPressHandler: () {
                      Navigator.of(context).pushNamed(SignupScreen.routeName);
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void login() {

    String email = emailController.text;
    String password = passwordController.text;

    ApiService.login(context,email,  password);
  }
}


