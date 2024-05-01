import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/api_service.dart';
import '../models/property_model.dart';
import '../widgets/indi_deal_card.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';

class UserPostScreen extends StatefulWidget {
  static const routeName = '/popular_deals';

  @override
  _UserPostScreenState createState() => _UserPostScreenState();
}

class _UserPostScreenState extends State<UserPostScreen> {
  bool isAdded = false;
  bool isLoaded = false;
  List<Property> properties = [];

  @override
  void initState() {
    super.initState();
    loadProperties();
  }

  void loadProperties() async {
    try {
      List<Property> loadedProperties = await ApiService.getPropertiesByUserId();
      setState(() {
        properties = loadedProperties;
        isLoaded = true;
      });
    } catch (error) {
      print('Failed to load properties: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("My properties")),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                if (!isLoaded)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  CustomStaggerGrid(
                        () {
                      setState(() {
                        isAdded = true;
                      });
                    },
                    properties,
                  ),
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
