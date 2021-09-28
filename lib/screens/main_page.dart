import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:flutter/material.dart';

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
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor1,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: SideMenuColor1),
          canvasColor: SideMenuColor1,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => main, //
          '/MainScreen': (context) => MainScreen(),
          '/refreshMainScreen': (context) => MainScreen(),
          // '/DefaultPlat': (context) => DefaultPlat(),
        },
      ),
    ),
    // MainScreen(),
  );
}
