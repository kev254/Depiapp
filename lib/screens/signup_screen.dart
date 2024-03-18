import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../api/api_service.dart';
import '../screens/add_address_screen.dart';
import '../screens/login_screen.dart';

import '../utils/screen_utils.dart';
import '../widgets/back_button_ls.dart';
import '../widgets/custom_radio_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/option_button.dart';
import '../widgets/or_row.dart';
import '../widgets/snackbar.dart';
import '../widgets/social_media.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController ownerradioButtonController = TextEditingController();
  TextEditingController agentradioButtonController = TextEditingController();
  TextEditingController buyerradioButtonController = TextEditingController();
  TextEditingController auctionierradioButtonController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController idController = TextEditingController();

  TextEditingController referalCodeController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading=false;
  String selectedCategory='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void handleSelectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    print(selectedCategory);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    idController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            // BackButtonLS(),
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
                    Spacer(),
                    CustomTextField(
                      hint: 'Name',
                      controller: nameController,
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
                            controller: phoneController,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomTextField(hint: 'Email Address', controller: emailController,),
                    Spacer(),
                    CustomTextField(hint: 'Id number', controller: idController,),
                    Spacer(),
                    CustomTextField(hint: 'Referal code', controller: referalCodeController,),
                    Spacer(),
                    CustomTextField(
                      hint: 'Password',
                      icon: Image.asset('assets/images/hide_icon.png'),
                      controller: passwordController,
                    ),
                    Spacer(),
                    CustomTextField(
                      hint: 'Confirm password',
                      icon: Image.asset('assets/images/hide_icon.png'),
                      controller: confirmPasswordController,
                    ),
                    Spacer(),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRadioButton(
                          label: 'Owner',
                          isSelected: selectedCategory == 'Owner',
                          onSelect: () => handleSelectCategory('Owner'),
                        ),
                        CustomRadioButton(
                          label: 'Agent',
                          isSelected: selectedCategory == 'Agent',
                          onSelect: () => handleSelectCategory('Agent'),
                        ),
                        CustomRadioButton(
                          label: 'Buyer',
                          isSelected: selectedCategory == 'Buyer',
                          onSelect: () => handleSelectCategory('Buyer'),
                        ),
                        CustomRadioButton(
                          label: 'Auctioneer',
                          isSelected: selectedCategory == 'Auctioneer',
                          onSelect: () => handleSelectCategory('Auctioneer'),
                        ),
                      ],
                    ),
                    Spacer(),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        print(selectedCategory);
                        // signUp();
                        if(selectedCategory=="Buyer"){
                          signUp();
                        }
                        else if(selectedCategory==null || selectedCategory==""){
                          showSnackbar(title: 'Error !', subtitle: "At lease choose one user category  ");
                        }
                        else{
                          if(referalCodeController.text==null || referalCodeController.text==""){
                            showSnackbar(title: 'Error !', subtitle: "For Owner, Agent or Auctienier you need referal code ");
                          }
                          else{
                            signUp();
                          }
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text('Signup'),
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

  void signUp() {
    // Get form data from controllers
    String name = nameController.text;
    String phone = "254"+phoneController.text;
    String email = emailController.text;
    String idNumber = idController.text;
    String referralCode = referalCodeController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String selectedCat=selectedCategory;

    // Make API call to submit data
    // Here you would make your HTTP request to the REST API endpoint with the form data
    // Example:
    ApiService.signUp(name, phone, email, idNumber, referralCode, password,selectedCat);
  }
}

