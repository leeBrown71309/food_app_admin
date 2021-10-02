

import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:allo_thieb/responsive.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'help/app_colors.dart';
import 'help/custom_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    backgroundColor: white,
                    floating: true,
                    snap: true,
                    leading: Icon(EvaIcons.arrowRight,color: Colors.black54,),
                    title: CustomText(
                      text: 'Bienvenue',
                      size: 3.h,
                      color: Colors.black54,
                    ),
                    actions: [
                      Center(child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: NavBar(),
                      )),
                    ],
                  )
                ],
            body: Scrollbar(
              isAlwaysShown: true,
                child: DestinationCarousel())),
      );
}

class DestinationCarousel extends StatefulWidget {
  @override
  _DestinationCarouselState createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel> {
  final CarouselController _controller = CarouselController();

  List _isSelected = [true, false, false, false, false, false, false];

  int _current = 0;

  final List<String> images = [
    'assets/images/plat1.jpg',
    'assets/images/plat2.jpg',
    'assets/images/plat3.jpg',
    'assets/images/plat4.jpg',
    'assets/images/plat6.jpg',
    'assets/images/plat5.jpg',
  ];

  final List<String> places = [
    'ISSEU',
    'YASSA ',
    'DOMADA',
    'MAFE',
    'THIEB',
    'CALDOU',
  ];

  List<Widget> generateImageTiles(screenSize) {
    return images
        .map(
          (element) => ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              element,
              fit: BoxFit.cover,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSliders = generateImageTiles(screenSize);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
            padding: const EdgeInsets.only(top: 50),
            color: Colors.white,
            child: Column(
              children: [
                OnHoverText(

                  child: CustomText(
                      text: "Bienvenue sur le panel de Allo Thieb",
                      size: 10.sp,
                      color: Colors.black54,),
                ),
                SizedBox(height: 10,),
                OnHoverButton( child: Icon(EvaIcons.arrowDown,color: Colors.black54,size: 30,)),
                SizedBox(
                  height: screenSize.height / 10,
                ),
                OnHoverButton(
                  child: Stack(
                    children: [
                      CarouselSlider(
                        items: imageSliders,
                        options: CarouselOptions(
                            enlargeCenterPage: true,
                            aspectRatio: 18 / 8,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                                for (int i = 0; i < imageSliders.length; i++) {
                                  if (i == index) {
                                    _isSelected[i] = true;
                                  } else {
                                    _isSelected[i] = false;
                                  }
                                }
                              });
                            }),
                        carouselController: _controller,
                      ),
                      AspectRatio(
                        aspectRatio: 18 / 8,
                        child: Center(
                          child: Text(
                            places[_current],
                            style: TextStyle(
                              letterSpacing: 8,
                              decoration: TextDecoration.none,
                              fontFamily: 'Electrolize',
                              fontSize: screenSize.width / 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Responsive.isMobile(context)
                          ? AspectRatio(
                              aspectRatio: 14 / 8,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: screenSize.width / 8,
                                        right: screenSize.height / 8),
                                    child: Card(
                                      elevation: 0,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 0, bottom: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            for (int i = 0; i < places.length; i++)
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: screenSize.height / 80,
                                                      bottom:
                                                          screenSize.height / 80,
                                                    ),
                                                    child: Text("°"),
                                                  ),
                                                  Visibility(
                                                      visible: _isSelected[i],
                                                      child: Container(
                                                        height: 5,
                                                        width:
                                                            screenSize.width / 40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5),
                                                            color: Colors.blue),
                                                      ))
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : AspectRatio(
                              aspectRatio: 17 / 8,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: screenSize.width / 8,
                                        right: screenSize.width / 8),
                                    child: Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: screenSize.height / 50,
                                          bottom: screenSize.height / 50,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            for (int i = 0; i < places.length; i++)
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: screenSize.height / 80,
                                                      bottom: screenSize.height / 80,
                                                    ),
                                                    child: Text(places[i]),
                                                  ),
                                                  Visibility(
                                                      visible: _isSelected[i],
                                                      child: Container(
                                                        height: 5,
                                                        width:
                                                            screenSize.width / 40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5),
                                                            color: Colors.blue),
                                                      ))
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height/60,),
                OnHoverButton(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left:  screenSize.width / 8,
                      right:  screenSize.width / 8,
                    ),
                    child: Responsive.isMobile(context)?
                    MobkBody():DeskBody()
                  ),
                ),
                SizedBox(height: 2.h,),
                Button(),
              ],
            )
        ),
      ),
    );
  }
}
//*******************************************************************
//*******************************************************************
//*******************************************************************
class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w, left: 2.w),
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnHoverText(
                child: Text(
                    "$title",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                    ),
                  ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _menuItem(title: 'Accueil'),
                _menuItem(title: 'A Propos'),
                _menuItem(title: 'Contact'),
                _menuItem(title: 'Aide'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------

class DeskBody extends StatelessWidget {

  Widget img(){
    return Container(
      child: Image.asset(
        'images/illustration-1.png',
        width: 300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(

      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width:  30.w,
              // color: red,
              child: Column(
                children: [
                  Text(
                    ' Bienvenue \nSur Allo Thieb',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 7.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Votre espace de travail",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'images/plat8-removebg.png',
                    width: 700,
                  ),
                ],
              ),
            ),
            img(),
          ],
        ),
      ),
    );

  }


}

//--------------------------------------------
class MobkBody extends StatelessWidget {

  Widget img(){
    return Container(
      child: Image.asset(
        'images/illustration-1.png',
        width: 300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(

      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                  width:  30.w,
                  // color: red,
                  child: Column(
                    children: [
                      Text(
                        'Bienvenue \nSur Allo Thieb',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Votre espace de travail",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'images/plat8-removebg.png',
                        width: 700,
                      ),
                    ],
                  ),
                ),

            img(),
          ],
        ),
      ),
    );

  }


}


class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnHoverButton(
      child: RaisedButton(
        mouseCursor: SystemMouseCursors.click,
        autofocus: true,
          elevation: 10,
          color: blueFont,
          hoverColor: red,
          textColor: white,
          child: Text("Suivant",
            style: TextStyle(fontSize: 2.h),),
          onPressed: ()=> Navigator.pushReplacementNamed(context, '/auth')),
    );
  }
}
