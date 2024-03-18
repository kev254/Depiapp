import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class PriceTag extends StatefulWidget {
  final String price;
  const PriceTag({
    Key? key, required this.price,
  }) : super(key: key);

  @override
  State<PriceTag> createState() => _PriceTagState();
}

class _PriceTagState extends State<PriceTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(8.0),
        horizontal: getProportionateScreenWidth(16.0),
      ),
      decoration: ShapeDecoration(
        color: kAccentGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8.0),
          ),
        ),
      ),
      child: Text(
        'Kes. '+widget.price,
        style: Theme.of(context).textTheme.headline3?.copyWith(
              color: kPrimaryGreen,
            ),
      ),
    );
  }
}
