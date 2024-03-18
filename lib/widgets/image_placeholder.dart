import 'package:depi/api/api_endpoints.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class ImagePlaceholder extends StatefulWidget {
  final String image_url;
  const ImagePlaceholder({
    Key? key, required this.image_url,
  }) : super(key: key);

  @override
  State<ImagePlaceholder> createState() => _ImagePlaceholderState();
}

class _ImagePlaceholderState extends State<ImagePlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.network(
            ApiEndpoints.upload_url+widget.image_url, // Replace with your actual image path
            width: double.infinity,
            height: 250, // Adjust the height as needed
            fit: BoxFit.cover, // You can choose a different BoxFit as per your requirement
          ),
          color: kGreyShade5,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(16.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: kGreyShade1,
                  radius: getProportionateScreenWidth(4),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(8.0),
                ),
                CircleAvatar(
                  backgroundColor: kGreyShade3,
                  radius: getProportionateScreenWidth(4),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(8.0),
                ),
                CircleAvatar(
                  backgroundColor: kGreyShade3,
                  radius: getProportionateScreenWidth(4),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(8.0),
                ),
                CircleAvatar(
                  backgroundColor: kGreyShade3,
                  radius: getProportionateScreenWidth(4),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
