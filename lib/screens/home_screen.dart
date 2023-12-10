import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../models/category.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_nav_bar.dart';
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

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category(
        'For Leasing',
        'assets/images/egg.png',
        kAccentYellow,
      ),

      Category(
        'For sale',
        'assets/images/drinks.png',
        kAccentPurple,
      ),
      Category(
        'Residential',
        'assets/images/cannedfood.png',
        kAccentTosca,
      ),
      Category(
        'Commercial',
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
          DealsTab(),
          Spacer(),
          PopularDealTab(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RawMaterialButton(
        fillColor: Colors.white,
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
              Image.asset('assets/images/create_post_icon.png',height: 30,),
              Text(
                'Create add',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class PopularDealTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Column(
        children: [
          TabTitle(
              title: 'Top rated',
              seeAll: () {
                Navigator.of(context).pushNamed(PopularDealsScreen.routeName);
              }),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: getProportionateScreenWidth(8),
              ),
              children: [
                IndiDealCard(
                  addHandler: (){
                    print("Item tapped");
                  },
                  isLeft: true,
                  isSelected: true,
                ),
                IndiDealCard(
                  isLeft: false,
                  isSelected: false,
                ),
                IndiDealCard(
                  isLeft: false,
                  isSelected: false,
                ),
                IndiDealCard(
                  addHandler: (){
                    // Get.to()
                  },
                  isLeft: false,
                  isSelected: false,
                ),
                IndiDealCard(
                  isLeft: false,
                  isSelected: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DealsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle(
            title: 'Newly posted',
            seeAll: () {
              Navigator.of(context).pushNamed(SpecialDealScreen.routeName);
            }),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DealCard(onTap: (){
                Get.to(DragonFruitScreen());
              },),
              DealCard(onTap: (){
                Get.to(DragonFruitScreen());
              },),
              DealCard(onTap: (){
                Get.to(DragonFruitScreen());
              },),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

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
                  Navigator.of(context).pushNamed(CategoryScreen.routeName);
                },
                child: Text(
                  'See All',
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(categories[index]),
            ),
          )
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
          16,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test user',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'Nairobi, Kenya',
                  style: TextStyle(
                    color: kTextColorAccent,
                    fontSize: getProportionateScreenWidth(
                      12,
                    ),
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
    );
  }
}
