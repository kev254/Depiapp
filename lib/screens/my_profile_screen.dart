import 'package:flutter/material.dart';
import '../api/shared_preference_service.dart';
import '../constants/colors.dart';
import '../models/user_model.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/image_container.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = 'myProfile';

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late User _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserDetails();
  }
  Future<void> _getUserDetails() async {
    User? user = await SharedPreferencesService.getUser();
    setState(() {
      _user = user ?? User(id: '', name: '', phone: '', email: '', idNumber: '', referralCode: '', password: '', otp: '', verified: '', createdAt: '', userCategory: ''); // If user is null, assign a default User object
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            ImageContainer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16.0),
              ),
              child: Column(
                children: [
                  Divider(
                    height: getProportionateScreenHeight(64.0),
                  ),
                  InputFormCard(
                    title: 'Name',
                    value: _user.name ??"",
                    editable: false,
                  ),
                  InputFormCard(
                    title: 'Joined on',
                    value: _user.createdAt??"",
                  ),
                  InputFormCard(
                    title: 'Category',
                    value: _user.userCategory??"",
                    editable: false,
                  ),
                  InputFormCard(
                    title: 'Email',
                    editable: false,
                    value: _user.email??"",
                  ),
                  InputFormCard(
                    title: 'Phone number',
                    value: _user.phone??"",
                    editable: false,
                  ),
                  InputFormCard(
                    title: 'Referal Code',
                    value: _user.referralCode??"",
                    editable: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputFormCard extends StatelessWidget {
  const InputFormCard({
    Key? key,
    required this.title,
    required this.value,
    this.editable,
  }) : super(key: key);

  final String title;
  final bool? editable;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(17),
            ),
          ),
        ),
        Flexible(
          child: TextFormField(
            initialValue: value,
            readOnly: true,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(17),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
