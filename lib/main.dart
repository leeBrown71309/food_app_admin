import 'package:allo_thieb/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'authentification/sign_and_login.dart';
import 'controllers/MenuController.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return buildMaterialApp(context, MainScreen());
    });
  }
}

MaterialApp buildMaterialApp(BuildContext context, var main) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Allo Thieb',
        initialRoute: '/',
        routes: {
          '/': (context) =>  LoginSignupScreen(),
          '/MainScreen': (context) => MainScreen(),
          '/refreshMainScreen': (context) => MainScreen(),
          // '/DefaultPlat': (context) => DefaultPlat(),
        },
      ),
    ),
    // MainScreen(),
  );
}
