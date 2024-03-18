import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../api/api_endpoints.dart';
import '../constants/colors.dart';
import '../models/property_model.dart';
import '../screens/dragon_fruit_screen.dart';
import '../utils/screen_utils.dart';

class IndiDealCard extends StatelessWidget {
  final bool? isLeft;
  final bool isSelected;
  final bool noPadding;
  final Function()? addHandler;
  final Property property;

  const IndiDealCard(
      {this.isLeft, required this.isSelected, this.addHandler, this.noPadding = false, required this.property});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DragonFruitScreen(property: property,));
      },
      child: Padding(
        padding: !noPadding
            ? EdgeInsets.only(
          left: isLeft! ? getProportionateScreenWidth(16.0) : 0,
          right: isLeft! ? 0 : getProportionateScreenWidth(16.0),
        )
            : EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.all(
            getProportionateScreenWidth(8.0),
          ),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(
                8,
              ),
            ),
            boxShadow: [
              isSelected
                  ? BoxShadow(
                color: kShadowColor,
                offset: Offset(
                  getProportionateScreenWidth(24),
                  getProportionateScreenWidth(40),
                ),
                blurRadius: 80,
              )
                  : BoxShadow(color: Colors.white),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add your image here

              Expanded(
                child: Container(
                  child: Image.network(
                    ApiEndpoints.upload_url+property.filesData[0].photoUrl, // Replace with your actual image path
                    width: double.infinity,
                    height: 50, // Adjust the height as needed
                    fit: BoxFit.cover, // You can choose a different BoxFit as per your requirement
                  ),
                  decoration: BoxDecoration(
                    color: kGreyShade5,
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.title,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      property.description,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        color: kTextColorAccent,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Kes.'+property.price,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
