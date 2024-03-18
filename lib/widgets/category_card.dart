import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/property_by_category_name.dart';
import '../utils/screen_utils.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard(
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Get.to(CategoryPostScreen(category_name: category.catName,));
          },
          child: CircleAvatar(
            radius: getProportionateScreenWidth(24),
            backgroundColor: category.color,
            child: SizedBox(
              width: getProportionateScreenWidth(28),
              child: Image.asset(
                category.catIcon,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(category.catName)
      ],
    );
  }
}
