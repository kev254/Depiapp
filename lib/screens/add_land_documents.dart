import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_service.dart';
import '../utils/screen_utils.dart';
import '../widgets/back_button_ls.dart';
import '../widgets/snackbar.dart';
import '../widgets/upload_media_button.dart';
import 'home_screen.dart';

class AddPostDocumentsPage extends StatefulWidget {
  static const routeName = '/signupScreen';

  final Map<String, dynamic> form2object;
  AddPostDocumentsPage({
    required this.form2object,
  });

  @override
  State<AddPostDocumentsPage> createState() => _AddPostDocumentsPageState();
}

class _AddPostDocumentsPageState extends State<AddPostDocumentsPage> {
  String? landUsage;
  String? amenitiesType;
  String? property_type;
  File? image;
  File? title_deed;
  File? survey_search;
  File? property_map;
  bool isLoading=false;

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
      appBar: AppBar(title: Text("Upload property documents"),),
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
                    Row(
                      children: [
                        Text(
                          '* This helps buyers to know the authenticity of the property ',
                          style:TextStyle(fontSize: 13, color: Colors.green),
                        ),
                      ],
                    ),
                    Spacer(),


                    Row(
                      children: [
                        UploadMediaButton(
                          onMediaSelected: (mediaItem) {
                            setState(() {
                              image = mediaItem;
                            });
                          }, label: 'Add photos', icon: Icons.image,
                        ),
                        if (image != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 40,
                            ),
                          ),
                      ],
                    ),

                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();

                        if (result != null) {
                          title_deed = File(result.files.single.path!);
                        } else {
                          // Handle the case when the user cancels the file picker
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Change this color to your desired color
                      ),
                      child: Text('Upload property title deed'),
                    ),

                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();

                        if (result != null) {
                          survey_search = File(result.files.single.path!);
                        } else {
                          // Handle the case when the user cancels the file picker
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Change this color to your desired color
                      ),
                      child: Text('Upload surveyer search'),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();

                        if (result != null) {
                          property_map = File(result.files.single.path!);
                        } else {
                          // Handle the case when the user cancels the file picker
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Change this color to your desired color
                      ),
                      child: Text('Upload property map'),
                    ),


                    Spacer(),
                    ElevatedButton(
                      onPressed: ()  {
                        print(widget.form2object);
                        setState(() {
                          isLoading = true;
                        });

                        ApiService.create_post(
                          context,
                          widget.form2object['title'].toString(),
                          widget.form2object['property_type'].toString(),
                          widget.form2object['description'].toString(),
                          widget.form2object['suit_for'].toString(),
                          widget.form2object['accessibilities'].toString(),
                          widget.form2object['price'].toString(),
                          widget.form2object['land_size'].toString(),
                          widget.form2object['geolocation'].toString(),
                          widget.form2object['location'].toString(), // Assuming 'land_loc' corresponds to 'location' in the function definition
                          widget.form2object['property_of_use'].toString(),
                          widget.form2object['land_use'].toString(),
                          widget.form2object['land_category'].toString(), // Assuming 'land_cat' corresponds to 'land_category' in the function definition
                          widget.form2object['ownership_structure'].toString(), // Assuming 'ownership_type' corresponds to 'ownership_structure' in the function definition
                          widget.form2object['structure_status'].toString(),
                          widget.form2object['number_of_rooms'].toString(),
                          widget.form2object['furnished'].toString(),
                          widget.form2object['house_has_ready_title'].toString(), // Assuming 'ready_title' corresponds to 'house_has_ready_title' in the function definition
                          widget.form2object['house_ready_for_sale'].toString(),
                          widget.form2object['available_amenities'].toString(),
                          image,
                          title_deed,
                          survey_search,
                          property_map,
                        );

                        // showSnackbar(title: "Success", subtitle: "Your post was submitted successfully.");
                        // Get.to(HomeScreen());



                      },
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text('Post property'),
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
