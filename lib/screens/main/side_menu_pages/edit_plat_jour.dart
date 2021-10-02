import 'package:allo_thieb/controllers/MenuController.dart';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:allo_thieb/models/Plats/ListPlats.dart';
import 'package:allo_thieb/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../responsive.dart';

class EditPlatJour extends StatefulWidget {
  @override
  _EditPlatJourState createState() => _EditPlatJourState();
}

class _EditPlatJourState extends State<EditPlatJour> {
  @override
  Widget build(BuildContext context) => Scaffold(

    body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled)=>[
          SliverAppBar(
            shadowColor: Colors.blue,
            backgroundColor: white,
            elevation: 10.0,
            forceElevated: true,
            floating: true,
            snap: true,
            title: CustomText(
              text: "Dashboard",
              size: 20,
              color: SideMenuColor,
              weight: FontWeight.bold,
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Row(
                children: [
                  if (!Responsive.isDesktop(context))
                    IconButton(
                      icon: Icon(Icons.menu,color: SideMenuColor,),
                      onPressed: context.read<MenuController>().controlMenu,
                    ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Notifycation(),
                    ProfileCard(),

                  ],
                ),
              ),
            ],
          )
        ],
        body: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(

            child: Column(
            children: [
              SizedBox(height: 10,),
              HeaderPageName(namePage: ' Liste des plats',),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Banner(),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(
                    padding: EdgeInsets.all(7),
                    // decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(3),
                    //
                    //     boxShadow: const [
                    //       BoxShadow(
                    //           color: Colors.grey, offset: Offset(0, 3), blurRadius: 2)]),
                    child: Column(
                      children: [
                        CustomText(
                          text: "Plats enregistrés",
                          size: 5.sp,
                          color: black,
                        ),
                        ListPlats(),
                        SizedBox(height: 20,),
                        Footer()
                      ],
                    )),
              ),
            ],
      ),
          ),
        )
    ),
  );
}

class Banner extends StatelessWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget miniBox() {
      return OnHoverText(
        child: Container(
          height: 70,
          width: 150,
          margin: EdgeInsets.only(left: defaultPadding),
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Color(0x980e183e),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white54),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.forward_outlined,color: Colors.white54,),
              Column(
                children: [
                  CustomText(
                      text: "20",
                      size: 15,
                      color: Colors.white70),
                  SizedBox(height: 10,),
                  CustomText(
                      text: "NB plats",
                      size: 10,
                      color: Colors.white54)
                ],
              )
            ],
          ),
        ),
      );
    }



    Widget banner(){
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(colors: [
              Color(0xf3f4761c),
              Color(0xfe840eec),
              Color(0xff3f65ee)
            ])),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    OnHoverText(
                      child: Image.asset(
                        'images/plat8-removebg.png',
                        width: 20.w,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Bienvenue dans la liste des plats",
                    style: TextStyle(
                      color: white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    Text("Vous retrouverez ici la liste de tous les plats",
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal
                    ),)
                  ],
                ),
              ],
            ),
            !Responsive.isDesktop(context) ?
              OnHoverButton(
                child: IconButton(
                  splashColor: Colors.white70,
                  icon: Icon(Icons.keyboard_arrow_down_sharp,color: white,),
                  onPressed: () {
                    // _showDialog();
                    },

                ),
              ) :
           Row(
             children: [
               miniBox(),

             ],
           )


          ],
        ),
      );
    }
    return banner();
  }
}
class Footer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget footer(){
      return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(colors: [
              Color(0xf3f4761c),
              Color(0xfe840eec),
              Color(0xff3f65ee)
            ])),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Powered by Evannaissance industry",
                  style: TextStyle(
                      color: white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),


              ],
            ),
          ],
        ),
      );
    }
    return footer();
  }
}

