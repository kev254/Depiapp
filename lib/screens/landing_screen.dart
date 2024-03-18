import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

///best practices
import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../screens/intro_screen.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  // Widget build(BuildContext context) {
  //   ScreenUtils().init(context);
  //   return AnimatedSplashScreen(
  //     splash: Center(
  //       child: Column(
  //         children: [
  //           Image.asset("assets/images/logo.png"),
  //           const Text("Depi Real Estate")
  //         ],
  //       ),
  //     ),
  //     nextScreen: LoginScreen() ,
  //     backgroundColor: Colors.white,
  //     duration: 3000,
  //     splashIconSize: 300,
  //     splashTransition: SplashTransition.scaleTransition,
  //     animationDuration: const Duration(seconds: 1),
  //
  //
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SplashScreenView(
            navigateRoute: LoginScreen(),
            duration: 2000,
            imageSize: 180,
            imageSrc: "assets/images/logo.png",
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class IntroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
            20,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Welcome to Depi',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Text(
              'We have more than 10,000+ plots available for sale and leasing',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(IntroScreen.routeName);
              },
              child: Text('Get Started'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
