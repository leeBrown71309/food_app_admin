// @dart=2.14
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'authentification/login.dart';

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
              debugShowCheckedModeBanner: false,
              title: 'Allo Thieb',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: bgColor1,
                textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                    .apply(bodyColor: Colors.white70),
                canvasColor: Color(0xdfea2424),
              ),

              initialRoute: '/',
              routes:  {
                '/': (context) => LoginScreen(),
                '/MainScreen': (context) => MainScreen(),
                // '/DefaultPlat': (context) => DefaultPlat(),
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
