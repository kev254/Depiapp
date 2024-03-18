import 'package:depi/screens/login_screen.dart';
import 'package:depi/screens/propert_by_user_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/shared_preference_service.dart';
import '../constants/colors.dart';
import '../models/user_model.dart';
import '../screens/my_profile_screen.dart';
import '../utils/screen_utils.dart';
import '../widgets/image_container.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Depi Help and Support"),),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16.0),
            ),
            child: Column(
              children: [

        

                Text(
                  "Having an issue? You can direct all your issue to the following chanels",
                  style: TextStyle(fontSize: 14),

                ),
                SizedBox(height: 20,),
                Divider(
                  height: getProportionateScreenHeight(32.0),
                ),
                ProfileCard(
                  image: 'assets/images/mail_icon.png',
                  color: kAccentGreen,
                  title: 'info@depi.co.ke',
                  tapHandler: () async {
                    await launch('mailto:'+"info@depi.co.ke");

                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ProfileCard(
                  image: 'assets/images/whatsapp_icon.png',
                  color: kAccentTosca,
                  title: '+254-724-945176',
                  tapHandler: () async {
                    String phoneNumber = "+254724945176";
                    String whatsappUrl = "whatsapp://send?phone=$phoneNumber";

                    try {
                      bool launched = await launch(whatsappUrl);
                      if (!launched) {
                        // Handle error: WhatsApp is not installed
                        print("Error: WhatsApp is not installed.");
                      }
                    } catch (e) {
                      // Handle error: unable to launch WhatsApp
                      print("Error: Unable to launch WhatsApp. $e");
                    }
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ProfileCard(
                  image: 'assets/images/call_icon.png',
                  color: kAccentYellow,
                  title: '+254-724-945176',
                  tapHandler: () async {
                    await launch('tel:'+"+254724945176");
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ProfileCard(
                  image: 'assets/images/meta_icon.png',
                  color: kAccentPurple,
                  title: '@depi_real_estate',
                  tapHandler: () async {
                    await launch("https://www.facebook.com/");
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ProfileCard(
                  image: 'assets/images/map_icon.png',
                  color: kAccentRed,
                  title: 'Visit our office',
                  tapHandler: () async {
                    await launch('https://maps.app.goo.gl/eT9NM4fT31vqESmC6');
        
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
              child: Image.asset(image), height: 45, width: 45,
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
