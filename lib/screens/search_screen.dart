import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../api/api_service.dart';
import '../constants/colors.dart';
import '../models/property_model.dart';
import '../utils/screen_utils.dart';
import '../screens/vegetable_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/indi_deal_card.dart';
import '../widgets/snackbar.dart';
import '../widgets/tab_title.dart';
import './fruit_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Property> properties = [];
  TextEditingController seratchctrl= TextEditingController();
  bool isAdded = false;

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
  void loadSearchProperties() async {
    try {
      List<Property> loadedProperties = await ApiService.getPropertiesBySearchKey(seratchctrl.text);
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
    ScreenUtils().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("Search Property"),),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(children: [
                                  Expanded(
                                    child: SearchBar(
                                      controller: seratchctrl,
                                      hintText: "I'm looking for....",
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(10),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      //perform search
                                      print(seratchctrl.text);
                                      if(seratchctrl.text==null || seratchctrl.text==""){
                                        // SnackBar(content: Text("Search value cannot be empty"));
                                        showSnackbar(title: 'Error !', subtitle: "Search value cannot be empty ");
                                      }
                                      else{
                                        loadSearchProperties();
                                      }

                                    },
                                      child: Image.asset(
                                    'assets/images/arrow_forward.png',
                                    height: 50,
                                    width: 30,
                                  )),
                                ]),
                ),
                CustomStaggerGrid(() {
                  setState(() {
                    isAdded = true;
                  });
                },properties),
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
