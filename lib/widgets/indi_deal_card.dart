import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constants/colors.dart';
import '../screens/dragon_fruit_screen.dart';
import '../utils/screen_utils.dart';

class IndiDealCard extends StatelessWidget {
  final bool? isLeft;
  final bool isSelected;
  final bool noPadding;
  final Function()? addHandler;

  const IndiDealCard(
      {this.isLeft, required this.isSelected, this.addHandler, this.noPadding = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(DragonFruitScreen());
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
              Expanded(
                child: Container(
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
                      'Juja plots for sale',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Spacer(),
                    Text(
                      'All social amenties available, title ready',
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
                            'Kes. 1.5M',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        // RawMaterialButton(
                        //   onPressed: (){
                        //
                        //   },
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(8.0),
                        //   ),
                        //   fillColor: kPrimaryGreen,
                        //   constraints: BoxConstraints.tightFor(
                        //     width: getProportionateScreenWidth(
                        //       40,
                        //     ),
                        //     height: getProportionateScreenWidth(
                        //       40,
                        //     ),
                        //   ),
                        //   elevation: 0,
                        //   child: Icon(
                        //     Icons.add,
                        //     color: Colors.white,
                        //   ),
                        // )
                      ],
                    )
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
