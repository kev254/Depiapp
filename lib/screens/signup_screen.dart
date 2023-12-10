import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../screens/add_address_screen.dart';
import '../screens/login_screen.dart';

import '../utils/screen_utils.dart';
import '../widgets/back_button_ls.dart';
import '../widgets/custom_radio_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/option_button.dart';
import '../widgets/or_row.dart';
import '../widgets/social_media.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signupScreen';
  TextEditingController radioButtonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonLS(),
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
                          'Sign Up!',
                          style: Theme.of(context).textTheme.headline3?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // SocialMediaLogin(
                    //   method: 'Sign Up',
                    // ),
                    Spacer(),
                    // OrRow(),
                    Spacer(),
                    CustomTextField(
                      hint: 'Name',
                    ),

                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            hint: '+254',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomTextField(
                            hint: 'Phone Number',
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomTextField(hint: 'Email Address'),
                    Spacer(),
                    CustomTextField(hint: 'Id number'),
                    Spacer(),
                    CustomTextField(hint: 'Referal code'),
                    Spacer(),
                    CustomTextField(
                      hint: 'Password',
                      icon: Image.asset('assets/images/hide_icon.png'),
                    ),
                    Spacer(),
                    CustomTextField(
                      hint: 'Confirm password',
                      icon: Image.asset('assets/images/hide_icon.png'),
                    ),
                    Spacer(),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRadioButton(
                          label: 'Owner',
                          isSelected: true, // or false based on your logic
                          onSelect: (isSelected) {
                            // Handle radio button selection logic here
                          },
                          controller: radioButtonController,
                        ),
                        CustomRadioButton(
                          label: 'Agent',
                          isSelected: false, // or false based on your logic
                          onSelect: (isSelected) {
                            // Handle radio button selection logic here
                          },
                          controller: radioButtonController,
                        ),
                        CustomRadioButton(
                          label: 'Buyer',
                          isSelected: false, // or false based on your logic
                          onSelect: (isSelected) {
                            // Handle radio button selection logic here
                          },
                          controller: radioButtonController,
                        ),
                        CustomRadioButton(
                          label: 'Auctioner',
                          isSelected: false, // or false based on your logic
                          onSelect: (isSelected) {
                            // Handle radio button selection logic here
                          },
                          controller: radioButtonController,
                        ),
                      ],
                    ),
                    Spacer(),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      child: Text('Sign Up'),
                    ),
                    Spacer(),
                    OptionButton(
                      desc: 'Have an account? ',
                      method: 'Login',
                      onPressHandler: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
