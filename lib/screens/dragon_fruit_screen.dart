import 'dart:io';

import 'package:depi/api/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/api_service.dart';
import '../api/pdf_viewer.dart';
import '../constants/colors.dart';
import '../models/property_model.dart';
import '../screens/order_summary_screen.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_input_button.dart';
import '../widgets/discount_text.dart';
import '../widgets/fruit_title.dart';
import '../widgets/image_placeholder.dart';
import '../widgets/indi_deal_card.dart';
import '../widgets/price_tag.dart';
import '../widgets/quantity_input.dart';
import '../widgets/tab_title.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

class DragonFruitScreen extends StatefulWidget {
  static const routeName = '/dragonFruit';
  final Property property;

  DragonFruitScreen({required this.property});

  @override
  _DragonFruitScreenState createState() => _DragonFruitScreenState();
}

class _DragonFruitScreenState extends State<DragonFruitScreen> {
  final textController = TextEditingController(text: '1');
  bool isReviewTab = false;
  List<Property> properties = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProperties();
  }
  void loadProperties() async {
    try {
      List<Property> loadedProperties = await ApiService.getProperties();
      setState(() {
        properties = loadedProperties;
      });
    } catch (error) {
      // Handle error appropriately, e.g., show error message
      print('Failed to load properties: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.property.title,),),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CustomAppBar(
                    //   widget.property.title,
                    //   [
                    //     // SizedBox(
                    //     //   width: getProportionateScreenWidth(24),
                    //     //   child: Image.asset(
                    //     //     'assets/images/cart_nav_fill.png',
                    //     //     fit: BoxFit.cover,
                    //     //   ),
                    //     // ),
                    //     SizedBox(
                    //       width: getProportionateScreenWidth(16),
                    //     ),
                    //     Icon(
                    //       Icons.share,
                    //       color: kPrimaryGreen,
                    //     ),
                    //     SizedBox(
                    //       width: getProportionateScreenWidth(16),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(300),
                      width: double.infinity,
                      child: ImagePlaceholder(image_url: widget.property.filesData[0].photoUrl,),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DiscoutText(),
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          FruitTitle(title: widget.property.title),
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          Text(
                            widget.property.geolocation,
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: kTextColorAccent,
                                    ),
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // PreviousPriceTag(),
                              // SizedBox(
                              //   width: getProportionateScreenWidth(8),
                              // ),
                              PriceTag(price: widget.property.price,),
                              Spacer(),

                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(8.0),
                          ),
                          Container(
                            height: getProportionateScreenHeight(
                              32,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(2),
                              horizontal: getProportionateScreenWidth(4),
                            ),
                            decoration: ShapeDecoration(
                              color: kFillColorThird,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(8.0),
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!isReviewTab) {
                                        return;
                                      }

                                      setState(() {
                                        isReviewTab = !isReviewTab;
                                      });
                                    },
                                    child: DetailSelection(
                                      'Property details',
                                      !isReviewTab,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  endIndent: getProportionateScreenHeight(4),
                                  indent: getProportionateScreenHeight(4),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (isReviewTab) {
                                        return;
                                      }

                                      setState(() {
                                        isReviewTab = !isReviewTab;
                                      });
                                    },
                                    child: DetailSelection(
                                      'View Documents',
                                      isReviewTab,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(16),
                          ),
                          !isReviewTab
                              ? Text(
                                  widget.property.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                        color: kTextColorAccent,
                                      ),
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(PDFViewer(pdfUrl:ApiEndpoints.upload_url+widget.property.filesData[0].titleDealUrl, documents_name: 'Title Deed',));
                                  // _openPDFPreview(ApiEndpoints.upload_url+"receipt.pdf");
                                },
                                child: ReviewCard(
                                  title: "Title deed",
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  // showFile(ApiEndpoints.upload_url+"receipt.pdf");
                                  Get.to(PDFViewer(pdfUrl:ApiEndpoints.upload_url+widget.property.filesData[0].surveyorSearchUrl, documents_name: 'Surveyor search',));
                                },
                                child: ReviewCard(
                                  title: "Surveyor search",

                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(PDFViewer(pdfUrl:ApiEndpoints.upload_url+widget.property.filesData[0].propertyMapUrl, documents_name: 'Surveyor Map',));
                                },
                                child: ReviewCard(
                                  title: "Surveyor Map",

                                ),
                              ),
                            ],
                                ),
                          Divider(
                            height: getProportionateScreenHeight(48),
                          ),
                          TabTitle(
                            title: 'More Like this',
                            padding: 0,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(220),
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: properties.map((property) {
                                return IndiDealCard(
                                  addHandler: () {
                                    Get.to(DragonFruitScreen(property: property,));
                                  },
                                  isLeft: true, // Adjust as needed
                                  isSelected: true, // Adjust as needed
                                  property: property,
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(48),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16.0),
              ),
              child: Row(
                children: [
                  // Expanded(
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       Navigator.of(context)
                  //           .pushNamed(OrderSummaryScreen.routeName);
                  //     },
                  //     child: SizedBox(
                  //       width: getProportionateScreenWidth(32),
                  //       child: Image.asset(
                  //         'assets/images/cart_nav_fill.png',
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: getProportionateScreenWidth(16),
                  ),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () async {
                        await launch('tel:'+widget.property.user.phone);
                      },
                      child: Text('Contact Seller'),
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

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: kGreyShade5,
                      radius: getProportionateScreenWidth(24.0),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    UserDetails(
                      title: title,
                      allowedView: false,
                    ),
                  ],
                ),
                // Text(
                //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
                //   style: Theme.of(context).textTheme.headline4?.copyWith(
                //         color: kTextColorAccent,
                //       ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    required this.title,
    required this.allowedView,
    Key? key,
  }) : super(key: key);

  final String title;
  final bool allowedView;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(17.0),
                fontWeight: FontWeight.w700,
              ),
            ),
            allowedView
                ? Icon(Icons.remove_red_eye_outlined)
                : Icon(Icons.lock),
          ],
        ),
        // Row(
        //   children: [
        //     Image.asset('assets/images/star_rating.png'),
        //     SizedBox(
        //       width: getProportionateScreenWidth(4),
        //     ),
        //     Image.asset('assets/images/star_rating.png'),
        //     SizedBox(
        //       width: getProportionateScreenWidth(4),
        //     ),
        //     Image.asset('assets/images/star_rating.png'),
        //     SizedBox(
        //       width: getProportionateScreenWidth(4),
        //     ),
        //     Image.asset('assets/images/star_rating.png'),
        //     SizedBox(
        //       width: getProportionateScreenWidth(4),
        //     ),
        //     Image.asset('assets/images/star_rating.png'),
        //     Text(
        //       '29 February, 2099',
        //       style: TextStyle(
        //         color: kTextColorAccent,
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class DetailSelection extends StatelessWidget {
  final String text;
  final bool isSelected;

  const DetailSelection(this.text, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: isSelected
          ? ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(8.0),
                ),
              ),
              shadows: [
                  BoxShadow(
                    color: kShadowColor,
                    offset: Offset(0, 3),
                    blurRadius: 8,
                  )
                ])
          : null,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PreviousPriceTag extends StatelessWidget {
  const PreviousPriceTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Divider2.png'),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(8),
        ),
        decoration: ShapeDecoration(
          color: kFailColor.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8.0),
            ),
          ),
        ),
        child: Text(
          'Kes. 1.5 M',
          style: TextStyle(
            color: kFailColor,
          ),
        ),
      ),
    );
  }
}
