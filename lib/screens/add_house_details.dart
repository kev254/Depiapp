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
import 'add_land_documents.dart';

class AddHouseDetailsPage extends StatefulWidget {
  static const routeName = '/addlanddetails';
  final Map<String, dynamic> form2object;
  AddHouseDetailsPage({
    required this.form2object,
  });

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


  static List<String> house_amenities = [
    "Gym","Swimming pool","Kids playing ground","Parking","CCTV"
  ];
  final _items2 = house_amenities
      .map((house) => MultiSelectItem<String>(house, house))
      .toList();
  List<String> _selectedHouseAmenities = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedHouseAmenities=house_amenities;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add house details"),),
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
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Add house details',
                    //       style:
                    //           Theme.of(context).textTheme.headline3?.copyWith(
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //     ),
                    //   ],
                    // ),
                    Spacer(),


                    CustomDropdown(
                      hint: 'Number of rooms',
                      options: ['1 Room', '2 Rooms', '3 Rooms', '4 rooms', '5 Rooms', '6 Rooms'],
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
                    // CustomDropdown(
                    //   hint: 'Available amenities',
                    //   options: ['Gym', 'Swimming pool','Kids playing ground','Parking', 'CCTV'],
                    //   selectedValue: available_amenities,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       available_amenities = value;
                    //     });
                    //   },
                    // ),
                    MultiSelectDialogField(
                      items: _items2,
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
                        "Available amenities",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          _selectedHouseAmenities=results;
                        });
                        //_selectedAnimals = results;
                      },
                    ),

                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        var house_amen=jsonEncode(_selectedHouseAmenities);
                        print(house_amen);

                        var form2object = {
                          "land_usage": widget.form2object['land_usage'],
                          "property_type": widget.form2object['property_type'],
                          "title": widget.form2object['title'],
                          "description": widget.form2object['description'],
                          "price": widget.form2object['price'],
                          "land_size": widget.form2object['land_size'],
                          "geolocation": widget.form2object['geolocation'],
                          "amenitiesType": widget.form2object['amenitiesType'],
                          "zoning": widget.form2object['zoning'],
                          "ownership_type": widget.form2object['ownership_type'],
                          "zonig_duraion": widget.form2object['zonig_duraion'],
                          "land_cat": widget.form2object['land_cat'],
                          "land_use": widget.form2object['land_use'],
                          "structure_type": widget.form2object['structure_type'],
                          "structure_status": widget.form2object['structure_status'],
                          "land_loc": widget.form2object['land_loc'],
                          "purpose_of_use": widget.form2object['purpose_of_use'],
                          "number_of_room": number_of_rooms,
                          "furnished": furnished,
                          "ready_title": ready_title,
                          "ready_for_sale": ready_for_sale,
                          "available_amenities": house_amen,
                        };

                        Get.to(AddPostDocumentsPage(form2object: form2object,));

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
