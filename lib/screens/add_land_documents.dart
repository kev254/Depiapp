import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
import '../widgets/snackbar.dart';
import '../widgets/social_media.dart';
import '../widgets/upload_media_button.dart';
import 'add_house_details.dart';
import 'home_screen.dart';

class AddPostDocumentsPage extends StatefulWidget {
  static const routeName = '/signupScreen';

  @override
  State<AddPostDocumentsPage> createState() => _AddPostDocumentsPageState();
}

class _AddPostDocumentsPageState extends State<AddPostDocumentsPage> {
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

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      // Handle the selected file (file.path, file.bytes, file.name, etc.)
      print('Selected file: ${file.name}');
    } else {
      // User canceled the picker
      print('User canceled the file picker');
    }
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
                          'Upload documents',
                          style:
                          Theme.of(context).textTheme.headline3?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
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
                          File file = File(result.files.single.path!);
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
                          File file = File(result.files.single.path!);
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
                          File file = File(result.files.single.path!);
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
                        showSnackbar(title: "Success", subtitle: "Your post was submitted successfully.");
                        Get.to(HomeScreen());

                      },
                      child: Text('Create post'),
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
