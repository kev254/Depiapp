import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/add_address_screen.dart';
import '../screens/login_screen.dart';

import '../utils/screen_utils.dart';
import '../widgets/back_button_ls.dart';
import '../widgets/custom_radio_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custome_drop_down.dart';
import '../widgets/option_button.dart';
import '../widgets/or_row.dart';
import '../widgets/social_media.dart';
import '../widgets/upload_media_button.dart';
import 'add_house_details.dart';
import 'add_land_documents.dart';

class CreatAddPage extends StatefulWidget {
  static const routeName = '/signupScreen';

  @override
  State<CreatAddPage> createState() => _CreatAddPageState();
}

class _CreatAddPageState extends State<CreatAddPage> {
  String? landUsage;
  String? amenitiesType;
  String? property_type;
  File? image;

  TextEditingController radioButtonController = TextEditingController();
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
                          'Create add',
                          style:
                              Theme.of(context).textTheme.headline3?.copyWith(
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
                      hint: 'Title',
                    ),
                    Spacer(),
                    CustomDropdown(
                      hint: 'Property type',
                      options: ['Land', 'House'],
                      selectedValue: property_type,
                      onChanged: (value) {
                        setState(() {
                          property_type = value;
                        });
                      },
                    ),
                    Spacer(),
                    CustomTextField(hint: 'Description'),
                    Spacer(),

                    CustomDropdown(
                      hint: 'Property for',
                      options: ['Sale', 'Leasing'],
                      selectedValue: landUsage,
                      onChanged: (value) {
                        setState(() {
                          landUsage = value;
                        });
                      },
                    ),
                    Spacer(),
                    CustomDropdown(
                      hint: 'Facilities',
                      options: ['Water', 'Electricity', ' Road', "School", "Church", "Hospital"],
                      selectedValue: amenitiesType,
                      onChanged: (value) {
                        setState(() {
                          amenitiesType = value;
                        });
                      },
                    ),
                    Spacer(),

                    CustomTextField(hint: 'Price'),
                    Spacer(),
                    CustomTextField(hint: 'Land area (ac)'),

                    Spacer(),
                    CustomTextField(hint: 'Geolocation'),
                    Spacer(),

                    // Row(
                    //   children: [
                    //     UploadMediaButton(
                    //       onMediaSelected: (mediaItem) {
                    //         setState(() {
                    //           image = mediaItem;
                    //         });
                    //       }, label: 'Add photos', icon: Icons.image,
                    //     ),
                    //     if (image != null)
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: CircleAvatar(
                    //           backgroundImage: FileImage(image!),
                    //           radius: 40,
                    //         ),
                    //       ),
                    //   ],
                    // ),
                    // Spacer(),
                    // Spacer(),
                    // Row(
                    //   children: [
                    //     UploadMediaButton(
                    //       onMediaSelected: (mediaItem) {
                    //         setState(() {
                    //           image = mediaItem;
                    //         });
                    //       }, label: 'Add files', icon: Icons.file_copy,
                    //     ),
                    //     if (image != null)
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: CircleAvatar(
                    //           backgroundImage: FileImage(image!),
                    //           radius: 40,
                    //         ),
                    //       ),
                    //   ],
                    // ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        print(property_type);
                        if(property_type=="House"){
                          Get.to(AddHouseDetailsPage());
                        }
                        else{
                          Get.to(AddPostDocumentsPage());
                        }

                      },
                      child: Text('Next'),
                    ),
                    Spacer(),
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
