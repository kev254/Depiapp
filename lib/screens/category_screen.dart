import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/category.dart';
import '../utils/screen_utils.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_app_bar.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category_screen';
  final List<Category> categories;

  CategoryScreen({required this.categories});


  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {

    ScreenUtils().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("Filter Properies by Category"),),
      body: SafeArea(
        child: Column(
          children: [
            // CustomAppBar(
            //   'Categories',
            //   [
            //     Icon(
            //       Icons.search,
            //       color: kPrimaryGreen,
            //     ),
            //     SizedBox(
            //       width: getProportionateScreenWidth(16),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Expanded(
                child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: List.generate(
                widget.categories.length,
                (index) => CategoryCard(
                  widget.categories[index],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
