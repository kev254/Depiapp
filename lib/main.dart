import 'package:depi/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import './screens/landing_screen.dart';
import './utils/custom_theme.dart';
import './models/item.dart';
import './routes/route.dart' as route;
import 'api/shared_preference_service.dart';
import 'models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserDetails();
  }
  Future<void> _getUserDetails() async {
    User? user = await SharedPreferencesService.getUser();
    setState(() {
      _user = user; // If user is null, assign a default User object
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Items(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final customTheme = CustomTheme(constraints);
          return GetMaterialApp(
              title: 'Depi Real Estate',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.green,
                textTheme: customTheme.nunito(),
                elevatedButtonTheme: customTheme.elevatedButtonTheme(),
                outlinedButtonTheme: customTheme.outlinedButtonTheme(),
                textButtonTheme: customTheme.textButtonTheme(),
                dividerTheme: customTheme.dividerTheme(),
              ),
              home: _user ==null
                  ?LandingScreen()
                  :LandingScreen(),
              routes: route.Route().routes);
        },
      ),
    );
  }
}
