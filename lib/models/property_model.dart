import 'dart:io';

import 'package:depi/models/file_model.dart';
import 'package:depi/models/user_model.dart';

class Property {
  final String id;
  final String title;
  final String property_type;
  final String description;
  final String suit_for;
  final String accessibilities;
  final User user;
  final String price;
  final String lnad_size;
  final String geolocation;
  final String location;

  final String property_of_use;
  final String land_use;
  final String land_category;

  final String ownership_structure;
  final String structure_status;
  final String number_of_rooms;
  final String furnished;
  final String house_has_ready_title;
  final String house_ready_for_sale;
  final String availables_amenities;
  final List<FileData> filesData;


  Property(
      this.id,
      this.title,
      this.property_type,
      this.description,
      this.suit_for,
      this.accessibilities,
      this.user,
      this.price,
      this.lnad_size,
      this.geolocation,
      this.location,
      this.property_of_use,
      this.land_use,
      this.land_category,
      this.ownership_structure,
      this.structure_status,
      this.number_of_rooms,
      this.furnished,
      this.house_has_ready_title,
      this.house_ready_for_sale,
      this.availables_amenities,
      this.filesData);


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'property_type': property_type,
      'description': description,
      'suit_for': suit_for,
      'accessibilities': accessibilities,
      'user': user.toJson(), // Assuming User has its own toJson() method
      'price': price,
      'lnad_size': lnad_size,
      'geolocation': geolocation,
      'location': location,
      'property_of_use': property_of_use,
      'land_use': land_use,
      'land_category': land_category,
      'ownership_structure': ownership_structure,
      'structure_status': structure_status,
      'number_of_rooms': number_of_rooms,
      'furnished': furnished,
      'house_has_ready_title': house_has_ready_title,
      'house_ready_for_sale': house_ready_for_sale,
      'availables_amenities': availables_amenities,
      'files': filesData,
    };
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      json['id'].toString(),
      json['title'].toString(),
      json['property_type'].toString(),
      json['description'].toString(),
      json['suit_for'].toString(),
      json['accessibilities'].toString(),
      User.fromJson(json['user']), // Assuming User has its own fromJson() method
      json['price'].toString(),
      json['land_size'].toString(), // Corrected typo here
      json['geolocation'].toString(),
      json['location'].toString(),
      json['property_of_use'].toString(),
      json['land_use'].toString(),
      json['land_category'].toString(),
      json['ownership_structure'].toString(),
      json['structure_status'].toString(),
      json['number_of_rooms'].toString(),
      json['furnished'].toString(),
      json['house_has_ready_title'].toString(),
      json['house_ready_for_sale'].toString(),
      json['available_amenities'].toString(), // Corrected typo here
      (json['files'] as List).map((fileJson) => FileData.fromJson(fileJson)).toList(),
    );
  }




}
