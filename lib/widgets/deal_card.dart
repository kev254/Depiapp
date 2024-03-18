import 'package:depi/api/api_endpoints.dart';
import 'package:depi/models/property_model.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class DealCard extends StatelessWidget {
  final bool isHorizontalScrolling;
  final Function ()? onTap;
  final Property property;
  const DealCard({this.onTap, this.isHorizontalScrolling = true, required this.property});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.bottomLeft,
        width: getProportionateScreenWidth(280),
        height: getProportionateScreenHeight(170),
        margin: EdgeInsets.only(
          left: isHorizontalScrolling
              ? getProportionateScreenWidth(16)
              : getProportionateScreenWidth(0),
          bottom: !isHorizontalScrolling
              ? getProportionateScreenHeight(32)
              : getProportionateScreenHeight(0),
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8),
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              kGradientColor,
              kGradientColor.withOpacity(0),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add your image here
            Image.network(
              ApiEndpoints.upload_url+property.filesData[0].photoUrl, // Replace with your actual image path
              width: double.infinity,
              height: 70, // Adjust the height as needed
              fit: BoxFit.cover, // You can choose a different BoxFit as per your requirement
            ),
            Padding(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    property.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
