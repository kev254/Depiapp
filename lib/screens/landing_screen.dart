import 'package:flutter/material.dart';

///best practices
import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../screens/intro_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/landing.png',
                fit: BoxFit.contain,
              ),
            ),
            IntroWidget()
          ],
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
