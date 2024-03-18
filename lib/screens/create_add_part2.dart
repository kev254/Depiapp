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

class CreateAddPart2Page extends StatefulWidget {
  final Map<String, dynamic> form1object;
  CreateAddPart2Page({
    required this.form1object,
  });

  static const routeName = '/generalPostInfoPage';

  @override
  State<CreateAddPart2Page> createState() => _CreateAddPart2PageState();
}


class _CreateAddPart2PageState extends State<CreateAddPart2Page> {
  String? zoning;
  String? ownership_type;
  String? zonig_duraion;
  String? land_cat;
  String? land_use;
  String? structure_type;
  String? structure_status;
  String? land_loc;
  String? purpose_of_use;

  TextEditingController radioButtonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add general information"),),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // BackButtonLS(),
            SizedBox(height: 10,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                ),
                child: Column(
                  children: [



                    Spacer(),


                    CustomDropdown(
                      hint: 'Location',
                      options: ['Urban', 'Sub-Urbarn', 'Rural'],
                      selectedValue: land_loc,  // <-- Corrected variable
                      onChanged: (value) {
                        setState(() {
                          land_loc = value;  // <-- Corrected variable
                        });
                      },
                    ),

                    Spacer(),
                    CustomDropdown(
                      hint: 'Purpose of Use',
                      options: ['Primary Residence', 'Investment Property', 'Vacation Home', 'Business Premise'],
                      selectedValue: purpose_of_use,  // <-- Corrected variable
                      onChanged: (value) {
                        setState(() {
                          purpose_of_use = value;  // <-- Corrected variable
                        });
                      },
                    ),
                    Spacer(),

                    widget.form1object['property_type'] == "Land" || widget.form1object['property_type'] == "Private Land" || widget.form1object['property_type'] == "Commercial Land"
                        ? CustomDropdown(
                      hint: 'Land Use',
                      options: ['Residential Land', 'Commercial Land', 'Industrial Land', 'Agricultural Land'],
                      selectedValue: land_use,
                      onChanged: (value) {
                        setState(() {
                          land_use = value;
                        });
                      },
                    )
                        : CustomDropdown(
                      hint: 'Ownership Structure',
                      options: ['Sole Ownership', 'Joint Ownership', 'Corporate Ownership', 'Agricultural Land'],
                      selectedValue: structure_type,
                      onChanged: (value) {
                        setState(() {
                          structure_type = value;
                        });
                      },
                    ),
                    Spacer(),

                    widget.form1object['property_type'] == "Land" || widget.form1object['property_type'] == "Private Land" || widget.form1object['property_type'] == "Commercial Land"
                        ?CustomDropdown(
                      hint: 'Land Category',
                      options: ['Freehold Land', 'Leasehold Land'],
                      selectedValue: land_cat,
                      onChanged: (value) {
                        setState(() {
                          land_cat = value;
                        });
                      },
                    )
                        : CustomDropdown(
                      hint: 'Structure Status',
                      options: ['New Construction', 'Existing Structure'],
                      selectedValue: structure_status,
                      onChanged: (value) {
                        setState(() {
                          structure_status = value;
                        });
                      },
                    ),

                    Spacer(),



                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        print(widget.form1object);


                        var form2object = {
                          "land_usage": widget.form1object['land_usage'],
                          "property_type": widget.form1object['property_type'],
                          "title": widget.form1object['title'],
                          "description": widget.form1object['description'],
                          "price": widget.form1object['price'],
                          "land_size": widget.form1object['land_size'],
                          "geolocation": widget.form1object['geolocation'],
                          "amenitiesType": widget.form1object['amenitiesType'],
                          "zoning": zoning,
                          "ownership_type": ownership_type,
                          "zonig_duraion": zonig_duraion,
                          "land_cat": land_cat,
                          "land_use": land_use,
                          "structure_type": structure_type,
                          "structure_status": structure_status,
                          "land_loc": land_loc,
                          "purpose_of_use": purpose_of_use,
                          "number_of_room": "",
                          "furnished": "",
                          "ready_title": "",
                          "ready_for_sale": "",
                          "available_amenities": "",
                        };
                        print(form2object);
                        if (widget.form1object['property_type'] == "House" || widget.form1object['property_type'] == "Office Space" || widget.form1object['property_type'] == "Appartment") {
                          Get.to(AddHouseDetailsPage(form2object: form2object,));
                        } else if (widget.form1object['property_type'] == "Land" || widget.form1object['property_type'] == "Private Land" || widget.form1object['property_type'] == "Commercial Land") {
                          Get.to(AddPostDocumentsPage(form2object: form2object,));
                        }
                      },
                      child: Text('Next'),
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