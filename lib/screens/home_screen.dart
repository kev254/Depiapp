import 'dart:convert';
import 'package:depi/api/api_service.dart';
import 'package:depi/screens/support_screen.dart';
import 'package:depi/screens/tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../api/shared_preference_service.dart';
import '../constants/colors.dart';
import '../models/category.dart';
import '../models/property_model.dart';
import '../models/user_model.dart';
import '../utils/screen_utils.dart';
import '../widgets/deal_card.dart';
import '../widgets/indi_deal_card.dart';
import '../widgets/tab_title.dart';
import '../widgets/category_card.dart';
import './search_screen.dart';
import './category_screen.dart';
import './popular_deals_screen.dart';
import './special_deal_screen.dart';
import 'create_add_page_part1.dart';
import 'dragon_fruit_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Property> properties = [];
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey keyPos = GlobalKey();
  GlobalKey keyTrans = GlobalKey();
  GlobalKey keyBanking = GlobalKey();
  GlobalKey keyCustomers = GlobalKey();
  GlobalKey keySuppliers = GlobalKey();
  GlobalKey keyInventory = GlobalKey();
  GlobalKey keyAppBar = GlobalKey();
  GlobalKey createAdd = GlobalKey();
  bool showcoach = true;
  bool isLoaded = false;

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
        isLoaded = true;
      });
    } catch (error) {
      // Handle error appropriately, e.g., show error message
      print('Failed to load properties: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category(
        'Land',
        'assets/images/egg.png',
        kAccentYellow,
      ),
      Category(
        'Private Land',
        'assets/images/drinks.png',
        kAccentPurple,
      ),
      Category(
        'Commercial Land',
        'assets/images/cannedfood.png',
        kAccentTosca,
      ),
      Category(
        'House',
        'assets/images/dairy.png',
        kAccentGreen,
      ),
      Category(
        'Office Space',
        'assets/images/dairy.png',
        kAccentGreen,
      ),
      Category(
        'Apartment',
        'assets/images/dairy.png',
        kAccentGreen,
      ),
    ];

    ScreenUtils().init(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          HomeAppBar(),
          Spacer(),
          CategoryTab(categories: categories),
          Spacer(),
          isLoaded
              ? DealsTab(properties: properties)
              : Center(child: CircularProgressIndicator()),
          Spacer(),
          // Show progress indicator or popular deals tab based on loading status
          isLoaded
              ? PopularDealTab(properties: properties)
              : Center(child: CircularProgressIndicator()),
          Spacer(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: RawMaterialButton(
        fillColor: Colors.white,
        key: createAdd,
        shape: StadiumBorder(),
        elevation: 10.0,
        onPressed: () {
          Get.to(CreatAddPage());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(8.0),
            horizontal: getProportionateScreenWidth(16.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/create_post_icon.png', height: 30),
              Text(
                'Create add',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //in app tutorial coach start
  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.green,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");

      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");

        showcoach = false;
        print(showcoach);
        return showcoach;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];



    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation20",
        keyTarget: createAdd,
        alignSkip: Alignment.bottomRight,
        color: kPrimaryGreen,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Create post",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "This is where you add your listing to the app",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Next"),
                        ElevatedButton(
                          onPressed: () {
                            controller.next();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kAccentGreen, // set the background color here
                          ),
                          child: const Text("Next"),
                        ),
                      ]),
                ],
              );
            },
          ),
        ],
      ),
    );




    return targets;
  }

// in app tutoial coach end

}

class PopularDealTab extends StatefulWidget {
  final List<Property> properties;

  PopularDealTab({required this.properties});
  @override
  State<PopularDealTab> createState() => _PopularDealTabState();
}

class _PopularDealTabState extends State<PopularDealTab> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Column(
        children: [
          TabTitle(
              title: 'Top rated',
              seeAll: () {
                Get.to(PopularDealsScreen( widget_appbarr: "Top rated",));

              }),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: getProportionateScreenWidth(8),
              ),
              children: widget.properties.map((property) {
                return IndiDealCard(
                  addHandler: () {
                    print("Item tapped");
                  },
                  isLeft: true, // Adjust as needed
                  isSelected: true, // Adjust as needed
                  property: property,
                );
              }).toList(),

            ),
          )
        ],
      ),
    );
  }
}

class DealsTab extends StatefulWidget {
  final List<Property> properties;

  DealsTab({required this.properties});

  @override
  State<DealsTab> createState() => _DealsTabState();
}

class _DealsTabState extends State<DealsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle(
          title: 'Newly posted',
          seeAll: () {
            Get.to(PopularDealsScreen( widget_appbarr: "Newly Posted",));
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.properties.map((property) {
              return DealCard(
                property: property,
                onTap: () {
                  Get.to(DragonFruitScreen(property: property,));
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}


class CategoryTab extends StatefulWidget {
  const CategoryTab({
    Key? key,
    required this.categories,
    this.targetKey,
  }) : super(key: key);

  final List<Category> categories;
  final GlobalKey? targetKey;

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(CategoryScreen(categories: widget.categories,));
                },
                child: Text(
                  'See All',
                ),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                widget.categories.length,
                    (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust the spacing here
                  child: CategoryCard(widget.categories[index]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeAppBar extends StatefulWidget {
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    User? user = await SharedPreferencesService.getUser();
    setState(() {
      _user = user ?? User(id: '', name: '', phone: '', email: '', idNumber: '', referralCode: '', password: '', otp: '', verified: '', createdAt: '', userCategory: ''); // If user is null, assign a default User object
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
      ),
      child: GestureDetector(
        onTap: (){
          Get.to(UserScreen());

        },
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _user.name ?? 'Test User',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    _user.userCategory ?? 'Nairobi, Kenya',
                    style: TextStyle(
                      color: kTextColorAccent,
                      fontSize: getProportionateScreenWidth(12),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SearchScreen.routeName);
              },
              child: Icon(
                Icons.search,
                color: kPrimaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
