import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import './screens/landing_screen.dart';
import './utils/custom_theme.dart';
import './models/item.dart';
import './routes/route.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Items(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final customTheme = CustomTheme(constraints);
          return GetMaterialApp(
              title: 'Depi',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.green,
                textTheme: customTheme.nunito(),
                elevatedButtonTheme: customTheme.elevatedButtonTheme(),
                outlinedButtonTheme: customTheme.outlinedButtonTheme(),
                textButtonTheme: customTheme.textButtonTheme(),
                dividerTheme: customTheme.dividerTheme(),
              ),
              home: LandingScreen(),
              routes: route.Route().routes);
        },
      ),
    );
  }
}
