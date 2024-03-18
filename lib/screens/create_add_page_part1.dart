import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
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
import 'create_add_part2.dart';

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
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController landSizeController = TextEditingController();
  TextEditingController geolocationController = TextEditingController();

  TextEditingController radioButtonController = TextEditingController();


  static List<String> amenities = [
    "Water","Road","School","Church","Electricity","Hospital"
  ];
  final _items = amenities
      .map((animal) => MultiSelectItem<String>(animal, animal))
      .toList();
  List<String> _selectedAmenities = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedAmenities=amenities;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("List property"),),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BackButtonLS(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                ),
                child: Column(
                  children: [
                    Spacer(),

                    CustomTextField(
                      controller: titleController,
                      hint: 'Title',
                    ),
                    Spacer(),
                    CustomDropdown(
                      hint: 'Property type',
                      options: ['Land','Private Land', 'Commercial Land', 'House','Office Space','Appartment'],
                      selectedValue: property_type,
                      onChanged: (value) {
                        setState(() {
                          property_type = value;
                        });
                      },
                    ),
                    Spacer(),
                    CustomTextField(controller: descController,hint: 'Description'),
                    Spacer(),

                    CustomDropdown(
                      hint: 'Property for',
                      options: ['Sale', 'Leasing','Rent'],
                      selectedValue: landUsage,
                      onChanged: (value) {
                        setState(() {
                          landUsage = value;
                        });
                      },
                    ),
                    Spacer(),
                    // CustomDropdown(
                    //   hint: 'Accessibilities',
                    //   options: ['Water', 'Electricity', ' Road', "School", "Church", "Hospital"],
                    //   selectedValue: amenitiesType,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       amenitiesType = value;
                    //     });
                    //   },
                    // ),
                    MultiSelectDialogField(
                      items: _items,
                      title: Text("Select available accesibilities"),
                      selectedColor: Colors.green,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue,
                      ),
                      buttonText: Text(
                        "Accessibilities",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          _selectedAmenities=results;
                        });
                        //_selectedAnimals = results;
                      },
                    ),
                    Spacer(),

                    CustomTextField(controller: priceController,hint: 'Price'),
                    Spacer(),
                    CustomTextField(controller: landSizeController,hint: 'Land size (in figures)'),

                    Spacer(),
                    CustomTextField(controller: geolocationController,hint: 'Geolocation'),
                    Spacer(),


                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        var accesibilities =jsonEncode(_selectedAmenities);
                        var form1object = {
                          "land_usage": landUsage,
                          "property_type": property_type,
                          "title": titleController.text,
                          "description": descController.text,
                          "price": priceController.text,
                          "land_size": landSizeController.text,
                          "geolocation": geolocationController.text,
                          "amenitiesType": accesibilities,
                        };


                        print(property_type);
                        print(accesibilities);
                        Get.to(CreateAddPart2Page(form1object: form1object,));


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
