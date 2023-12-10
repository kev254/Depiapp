// import 'package:depi/models/item.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../constants/colors.dart';
//
// class SingleListingScreen extends StatefulWidget {
//   const SingleListingScreen({super.key, required this.item});
//   final Item item;
//
//   @override
//   State<SingleListingScreen> createState() => _SingleListingScreenState();
// }
//
// class _SingleListingScreenState extends State<SingleListingScreen> {
//   TextEditingController sellerMsgCtrl = TextEditingController();
//   int currentPhotoIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               iconSize: 20,
//               color: Colors.white,
//               onPressed: () => Navigator.of(context).pop(),
//             )),
//         body: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 350,
//                   alignment: Alignment.center,
//                   color: kAlertColor,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           width: MediaQuery.of(context).size.width * 0.25,
//                           height: 350,
//                           padding: const EdgeInsets.all(7),
//                           child: ListView.builder(
//                             itemCount: widget.item.photos.length,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       currentPhotoIndex = index;
//                                     });
//                                   },
//                                   child: Container(
//                                       width: 60,
//                                       height: 60,
//                                       alignment: Alignment.center,
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 10),
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: currentPhotoIndex == index
//                                                 ? kAlertColor
//                                                 : kAlertColor),
//                                         image: DecorationImage(
//                                           image: AssetImage(
//                                               widget.item.photos[index]),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       )));
//                             },
//                           )),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.75,
//                         height: 350,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(
//                                 widget.item.photos[currentPhotoIndex]),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.item.name,
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         widget.item.originalPrice,
//                         style: const TextStyle(
//                             color: kAlertColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.star,
//                             color: Colors.yellow,
//                             size: 16,
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             "${widget.item.discountPrice}",
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         widget.item.description,
//                         style: const TextStyle(
//                             color: kAlertColor,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//                 bottom: 5,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   color: Colors.white,
//                   padding: const EdgeInsets.all(14),
//                   child: Row(
//                     children: [
//                       // Expanded(
//                       //     child: CustomFormField(
//                       //       txtColor: kAlertColor,
//                       //       label: 'Send seller a message',
//                       //       require: true,
//                       //       controller: sellerMsgCtrl,
//                       //       type: TextInputType.number,
//                       //       validator: (value) {
//                       //         return null;
//                       //       },
//                       //     )),
//                       const SizedBox(
//                         width: 14,
//                       ),
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.send,
//                             color: kAlertColor,
//                           ))
//                     ],
//                   ),
//                 ))
//           ],
//         ));
//   }
// }
