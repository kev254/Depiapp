import 'package:depi/screens/login_screen.dart';
import 'package:depi/screens/propert_by_user_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:share/share.dart';
import '../api/shared_preference_service.dart';
import '../constants/colors.dart';
import '../models/user_model.dart';
import '../screens/my_profile_screen.dart';
import '../utils/screen_utils.dart';
import '../widgets/image_container.dart';
import 'help_page.dart';
import 'notification_center.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            ImageContainer(),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            Text(
              _user.name ?? "",
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              _user.email ?? "",
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Refercal Code",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: kTextColorAccent,
                  ),
                ),
                SizedBox(width: 10,),

                GestureDetector(
                  onTap: () {
                    // Copy logic here
                    Clipboard.setData(ClipboardData(text: _user.referralCode ??""));
                    // Optionally, you can provide feedback to the user, e.g., show a toast
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Referral code copied to clipboard'),
                      ),
                    );
                  },

                  child: Text(
                    _user.referralCode ??"",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Share.share("Join Depi Real Estate using the link https://depi.co.ke/api.php?code="+_user.referralCode ?? "");
                  },
                  icon: Icon(Icons.share),
                ),
              ],
            ),

            Divider(
              height: getProportionateScreenHeight(32.0),
            ),
            ProfileCard(
              image: 'assets/images/profile_user.png',
              color: kAccentGreen,
              title: 'My profile',
              tapHandler: () {
                Navigator.of(context).pushNamed(MyProfileScreen.routeName);
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            ProfileCard(
              image: 'assets/images/map_user.png',
              color: kAccentTosca,
              title: 'My posts',
              tapHandler: (){
                Get.to(UserPostScreen());
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            ProfileCard(
              image: 'assets/images/noti_user.png',
              color: kAccentYellow,
              title: 'Notification',
              tapHandler: (){
                Get.to(NotificationScreen());
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            ProfileCard(
              image: 'assets/images/check_user.png',
              color: kAccentPurple,
              title: 'Help Center',
              tapHandler: (){
                Get.to(HelpScreen());
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            ProfileCard(
              image: 'assets/images/arrow_user.png',
              color: kAccentRed,
              title: 'Log out',
              tapHandler: () {
                PanaraConfirmDialog.show(
                  context,
                  title: "Confirm",
                  message: "Do you want to logout?",
                  confirmButtonText: "Yes",
                  cancelButtonText: "No",
                  onTapCancel: () {
                    Navigator.pop(context);
                  },
                  onTapConfirm: () async {
                    Navigator.pop(context);
                    await SharedPreferencesService.clearUser();
                    Get.to(LoginScreen());
                  },
                  panaraDialogType: PanaraDialogType.normal,
                  barrierDismissible: false, // optional parameter (default is true)
                );

              },
            ),
            Spacer(),
            Text(
              'version 1.0.0',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.image,
    required this.title,
    this.tapHandler,
    required this.color,
  }) : super(key: key);

  final String image;
  final String title;
  final Function()? tapHandler;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(8.0),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              color: kShadowColor.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(8.0),
              ),
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(8.0),
                  ),
                ),
              ),
              child: Image.asset(image),
            ),
            SizedBox(
              width: getProportionateScreenWidth(8.0),
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
