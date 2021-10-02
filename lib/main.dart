import 'package:allo_thieb/screens/dashboard/dashboard_screen.dart';
import 'package:allo_thieb/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'authentification/sign_and_login.dart';
import 'controllers/MenuController.dart';
import 'welcom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MenuController(),
              ),
            ],
            child:Sizer(builder: (contex, orientation, deviceType){
              return MaterialApp(
                title: 'Allo Thieb',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                initialRoute: '/',
                routes:  {
                  '/': (context) =>  WelcomePage(),
                      // WelcomePage(),
                  '/auth': (context) => LoginSignupScreen(),
                  '/mainscreen': (context) => MainScreen(),

                },
              );
            }
            )
        ),
        // MainScreen(),
      );
    }
    );
  }
}

/*
MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
// This is the theme of your application.
//
// Try running your application with "flutter run". You'll see the
// application has a blue toolbar. Then, without quitting the app, try
// changing the primarySwatch below to Colors.green and then invoke
// "hot reload" (press "r" in the console where you ran "flutter run",
// or simply save your changes to "hot reload" in a Flutter IDE).
// Notice that the counter didn't reset back to zero; the application
// is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: DestinationCarousel(),
      );
 */
