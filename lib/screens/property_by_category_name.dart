import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/api_service.dart';
import '../models/property_model.dart';
import '../widgets/indi_deal_card.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';

class CategoryPostScreen extends StatefulWidget {
  static const routeName = '/popular_deals';
  final String category_name;

  const CategoryPostScreen({super.key, required this.category_name});

  @override
  _CategoryPostScreenState createState() => _CategoryPostScreenState();
}

class _CategoryPostScreenState extends State<CategoryPostScreen> {
  bool isAdded = false;
  List<Property> properties = [];
  bool isLoading = true; // New boolean to track loading state

  @override
  void initState() {
    super.initState();
    loadProperties();
  }

  void loadProperties() async {
    try {
      List<Property> loadedProperties =
      await ApiService.getPropertiesByCategoryName(widget.category_name);
      setState(() {
        properties = loadedProperties;
        isLoading = false; // Update loading state when properties are loaded
      });
    } catch (error) {
      print('Failed to load properties: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category_name),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                isLoading
                    ? Center(
                  child: CircularProgressIndicator(), // Show CircularProgressIndicator while loading
                )
                    : CustomStaggerGrid(() {
                  setState(() {
                    isAdded = true;
                  });
                }, properties),
              ],
            ),
          ),
          if (isAdded)
            Positioned(
              bottom: getProportionateScreenHeight(40),
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                height: getProportionateScreenHeight(80),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(8.0),
                    ),
                  ),
                  color: kPrimaryGreen,
                  shadows: [
                    BoxShadow(
                      color: kShadowColor,
                      offset: Offset(
                        getProportionateScreenWidth(24),
                        getProportionateScreenWidth(40),
                      ),
                      blurRadius: 80,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '5 items',
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Dragon Fruits, Oranges, Apples, Dragon Fruits, Oranges, Apples, ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Text(
                      '\$240',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}


class CustomStaggerGrid extends StatelessWidget {
  final Function()? addCallback;
  final List<Property> properties;

  const CustomStaggerGrid(this.addCallback, this.properties);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: properties.length,
        crossAxisSpacing: getProportionateScreenWidth(8),
        mainAxisSpacing: getProportionateScreenHeight(8),
        itemBuilder: (ctx, index) {
          // Ensure properties list is not empty
          if (properties.isEmpty) {
            return SizedBox.shrink(); // Or return an empty widget
          }

          // Handle index out of range
          if (index >= properties.length) {
            return SizedBox.shrink(); // Or return an empty widget
          }

          if (index % 2 != 0) {
            return IndiDealCard(
              property: properties[index],
              isLeft: false,
              isSelected: false,
            );
          } else if (index == 0) {
            return IndiDealCard(
              isLeft: true,
              isSelected: true,
              addHandler: addCallback, property: properties[index],
            );
          }
          return IndiDealCard(
            isLeft: true,
            isSelected: false,
            property: properties[index],
          );
        },
        staggeredTileBuilder: (index) {
          // Adjust this logic based on your requirements
          if (index == 0 || index == 2 || index == 3)
            return StaggeredTile.count(1, 1.3);
          return StaggeredTile.count(1, 2);
        },
      ),
    );
  }
}
