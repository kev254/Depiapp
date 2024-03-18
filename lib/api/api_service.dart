import 'dart:convert';
import 'dart:io';
import 'package:depi/api/shared_preference_service.dart';
import 'package:depi/models/property_model.dart';
import 'package:depi/screens/home_screen.dart';
import 'package:depi/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:panara_dialogs/panara_dialogs.dart';
import '../models/user_model.dart';
import '../screens/tab_screen.dart';
import '../widgets/snackbar.dart';
import 'api_endpoints.dart';

class ApiService {

  static Future<void> signUp(
      String name,
      String phone,
      String email,
      String idNumber,
      String referralCode,
      String password,
      String selectedCat,
      ) async {


    // Request body
    var body = {
      'name': name,
      'phone': phone,
      'email': email,
      'id_number': idNumber,
      'referral_code': referralCode,
      'password': password,
      'user_category': selectedCat,
    };



    try {
      print(body);
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.signUpUrl),
        body: body,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      var resData=json.decode(response.body);
      print(resData);

      if (resData["success"]) {
        showSnackbar(title: 'Success !', subtitle: 'Account created login');
        Get.to(LoginScreen());

      } else {
        // Request failed
        // Handle error response
        showSnackbar(title: 'Error !', subtitle: resData["message"]);
      }
    } catch (error) {
      // Error occurred
      print('Error: $error');
      showSnackbar(title: 'Error !', subtitle: '$error');
    }
  }


  static Future<void> login(
      BuildContext context,
      String email,
      String password,
      ) async {


    // Request body
    var body = {
      'email': email,
      'password': password,

    };



    try {
      print(body);
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.loginUrl),
        body: body,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      var resData=json.decode(response.body);
      print(resData);

      if (resData["success"]) {
        showSnackbar(title: 'Success !', subtitle: 'Login success');
        User user = User.fromJson(resData['user']);
        print(user.id);
        await SharedPreferencesService.saveUser(user);
        Navigator.of(context).pushNamed(TabScreen.routeName);

      } else {
        // Request failed
        // Handle error response
        showSnackbar(title: 'Error !', subtitle: resData["message"]);
      }
    } catch (error) {
      // Error occurred
      print('Error: $error');
      showSnackbar(title: 'Error !', subtitle: '$error');
    }
  }

  static Future<void> create_post(
      BuildContext context,
      String title,
      String propertyType,
      String description,
      String suitFor,
      String accessibilities,
      String price,
      String landSize,
      String geolocation,
      String location,
      String propertyOfUse,
      String landUse,
      String landCategory,
      String ownershipStructure,
      String structureStatus,
      String numberOfRooms,
      String furnished,
      String houseHasReadyTitle,
      String houseReadyForSale,
      String availableAmenities,
      File? photoUrl,
      File? titleDealUrl,
      File? surveyorSearchUrl,
      File? propertyMapUrl,
      ) async {
    var uri = Uri.parse(ApiEndpoints.addPropertyUrl);
    User? user = await SharedPreferencesService.getUser();

    var request = http.MultipartRequest('POST', uri);
    request.fields['title'] = title;
    request.fields['property_type'] = propertyType;
    request.fields['user_id'] = user!.id;
    request.fields['description'] = description;
    request.fields['suit_for'] = suitFor;
    request.fields['accessibilities'] = accessibilities;
    request.fields['price'] = price;
    request.fields['land_size'] = landSize;
    request.fields['geolocation'] = geolocation;
    request.fields['location'] = location;
    request.fields['property_of_use'] = propertyOfUse;
    request.fields['land_use'] = landUse;
    request.fields['land_category'] = landCategory;
    request.fields['ownership_structure'] = ownershipStructure;
    request.fields['structure_status'] = structureStatus;
    request.fields['number_of_rooms'] = numberOfRooms;
    request.fields['furnished'] = furnished;
    request.fields['house_has_ready_title'] = houseHasReadyTitle;
    request.fields['house_ready_for_sale'] = houseReadyForSale;
    request.fields['available_amenities'] = availableAmenities;
    request.headers['Content-Type'] = 'multipart/form-data';

    // Add files
    if (photoUrl != null) {
      request.files.add(await http.MultipartFile.fromPath('photo_url', photoUrl.path));
    }
    if (titleDealUrl != null) {
      request.files.add(await http.MultipartFile.fromPath('title_deal_url', titleDealUrl.path));
    }
    if (surveyorSearchUrl != null) {
      request.files.add(await http.MultipartFile.fromPath('surveyor_search_url', surveyorSearchUrl.path));
    }
    if (propertyMapUrl != null) {
      request.files.add(await http.MultipartFile.fromPath('property_map_url', propertyMapUrl.path));
    }
    print(request.fields);
    print(request.files);

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      var resData = json.decode(response.body);
      print(resData);

      if (resData["success"]) {
        // showSnackbar(title: 'Success !', subtitle: 'Property created successfully');
        PanaraInfoDialog.show(
          context,
          title: "Success",
          message: "Property created successfully",
          buttonText: "Okay",
          onTapDismiss: () {
            Navigator.pop(context);
            Get.to(HomeScreen());
          },
          panaraDialogType: PanaraDialogType.success,
          barrierDismissible: false, // optional parameter (default is true)
        );
        // Future.delayed(Duration(seconds: 1), () {
        //   Get.to(HomeScreen());
        // });
      } else {
        // Request failed
        showSnackbar(title: 'Error !', subtitle: resData["message"]);
      }
    } catch (error) {
      // Error occurred
      print('Error: $error');
      showSnackbar(title: 'Error !', subtitle: '$error');
    }
  }

  static Future<List<Property>> getProperties() async {
    List<Property> properties = [];
    properties.clear();
    try {
      var response = await http.post(Uri.parse(ApiEndpoints.getPropertyUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['success'] == true) {
          if (data['properties'] != null) {


            for (var propertyJson in data['properties']) {
              properties.add(Property.fromJson(propertyJson));
            }
            print(data);
            return properties;
          } else {
            // Properties field is null, return null to indicate this case
            return [];
          }
        } else {
          throw Exception('Failed to load properties: ${data["message"]}');
        }
      } else {
        throw Exception('Failed to load properties: Status Code ${response.statusCode}');
      }
    } catch (error) {
      // If an error occurs during the HTTP request, throw an exception
      throw Exception('Failed to load properties: $error');
    }
  }
  static Future<List<Property>> getPropertiesByUserId() async {
    List<Property> properties = [];
    User? user = await SharedPreferencesService.getUser();
    var body={"user_id": user!.id};
    properties.clear();
    print((body));
    try {
      var response = await http.post(Uri.parse(ApiEndpoints.getPropertyByUserIdUrl),
        body: body,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['success'] == true) {
          if (data['properties'] != null) {


            for (var propertyJson in data['properties']) {
              properties.add(Property.fromJson(propertyJson));
            }
            print(data);
            return properties;
          } else {
            // Properties field is null, return null to indicate this case
            return [];
          }
        } else {
          throw Exception('Failed to load properties: ${data["message"]}');
        }
      } else {
        throw Exception('Failed to load properties: Status Code ${response.statusCode}');
      }
    } catch (error) {
      // If an error occurs during the HTTP request, throw an exception
      throw Exception('Failed to load properties: $error');
    }
  }

  static Future<List<Property>> getPropertiesByCategoryName(String category_name) async {
    List<Property> properties = [];
    User? user = await SharedPreferencesService.getUser();
    var body={"category_name": category_name};
    properties.clear();
    print((body));
    try {
      var response = await http.post(Uri.parse(ApiEndpoints.getPropertyByCategoryNameUrl),
        body: body,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['success'] == true) {
          if (data['properties'] != null) {


            for (var propertyJson in data['properties']) {
              properties.add(Property.fromJson(propertyJson));
            }
            print(data);
            return properties;
          } else {
            // Properties field is null, return null to indicate this case
            return [];
          }
        } else {
          throw Exception('Failed to load properties: ${data["message"]}');
        }
      } else {
        throw Exception('Failed to load properties: Status Code ${response.statusCode}');
      }
    } catch (error) {
      // If an error occurs during the HTTP request, throw an exception
      throw Exception('Failed to load properties: $error');
    }
  }

  static Future<List<Property>> getPropertiesBySearchKey(String key) async {
    List<Property> properties = [];
    User? user = await SharedPreferencesService.getUser();
    var body={"key": key};
    properties.clear();
    print((body));
    try {
      var response = await http.post(Uri.parse(ApiEndpoints.getPropertyBySearchKeyUrl),
        body: body,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['success'] == true) {
          if (data['properties'] != null) {


            for (var propertyJson in data['properties']) {
              properties.add(Property.fromJson(propertyJson));
            }
            print(data);
            return properties;
          } else {
            // Properties field is null, return null to indicate this case
            return [];
          }
        } else {
          throw Exception('Failed to load properties: ${data["message"]}');
        }
      } else {
        throw Exception('Failed to load properties: Status Code ${response.statusCode}');
      }
    } catch (error) {
      // If an error occurs during the HTTP request, throw an exception
      throw Exception('Failed to load properties: $error');
    }
  }


}
