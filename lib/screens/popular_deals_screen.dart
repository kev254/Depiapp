import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/api_service.dart';
import '../models/property_model.dart';
import '../widgets/indi_deal_card.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';

class PopularDealsScreen extends StatefulWidget {
  static const routeName = '/popular_deals';
  final String? widget_appbarr;

  const PopularDealsScreen({super.key, this.widget_appbarr});

  @override
  _PopularDealsScreenState createState() => _PopularDealsScreenState();
}

class _PopularDealsScreenState extends State<PopularDealsScreen> {
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
      List<Property> loadedProperties = await ApiService.getProperties();
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
        title: Text(widget.widget_appbarr ?? ""),
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
