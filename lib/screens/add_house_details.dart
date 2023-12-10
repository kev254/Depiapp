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
import 'add_land_documents.dart';

class AddHouseDetailsPage extends StatefulWidget {
  static const routeName = '/addlanddetails';

  @override
  State<AddHouseDetailsPage> createState() => _AddHouseDetailsPageState();
}

class _AddHouseDetailsPageState extends State<AddHouseDetailsPage> {
  String? number_of_rooms;
  String? furnished;
  String? ready_title;
  String? ready_for_sale;
  String? available_amenities;


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
                          'Add house details',
                          style:
                              Theme.of(context).textTheme.headline3?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    Spacer(),


                    // OrRow(),
                    Spacer(),
                    CustomDropdown(
                      hint: 'Number of rooms',
                      options: ['1', '2', '3', '4', '5', '6'],
                      selectedValue: number_of_rooms,
                      onChanged: (value) {
                        setState(() {
                          number_of_rooms = value;
                        });
                      },
                    ),
                    Spacer(),

                    CustomDropdown(
                      hint: 'Furnished',
                      options: ['Yes', 'No'],
                      selectedValue: furnished,
                      onChanged: (value) {
                        setState(() {
                          furnished = value;
                        });
                      },
                    ),
                    Spacer(),
                    CustomDropdown(
                      hint: 'House has ready titles',
                      options: ['Yes', 'No'],
                      selectedValue: ready_title,
                      onChanged: (value) {
                        setState(() {
                          ready_title = value;
                        });
                      },
                    ),
                    Spacer(),
                    CustomDropdown(
                      hint: 'House ready for sale',
                      options: ['Yes', 'No'],
                      selectedValue: ready_for_sale,
                      onChanged: (value) {
                        setState(() {
                          ready_for_sale = value;
                        });
                      },
                    ),
                    Spacer(),
                    CustomDropdown(
                      hint: 'Available amenities',
                      options: ['Gym', 'Swimming pool','Kids playing ground','Parking', 'CCTV'],
                      selectedValue: available_amenities,
                      onChanged: (value) {
                        setState(() {
                          available_amenities = value;
                        });
                      },
                    ),

                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(AddPostDocumentsPage());

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
