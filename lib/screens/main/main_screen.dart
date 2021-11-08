
import 'package:allo_thieb/controllers/MenuController.dart';
import 'package:allo_thieb/help/app_colors.dart';
import 'package:allo_thieb/help/custom_text.dart';
import 'package:allo_thieb/help/onHoverbutton.dart';
import 'package:allo_thieb/models/Settings/BoissonsSettings.dart';
import 'package:allo_thieb/models/Settings/PlatSettings.dart';
import 'package:allo_thieb/screens/dashboard/dashboard_screen.dart';
import 'package:allo_thieb/screens/main/side_menu_pages/boissons.dart';
import 'package:allo_thieb/screens/main/side_menu_pages/edit_plat_jour.dart';
import 'package:allo_thieb/screens/main/side_menu_pages/list_clients.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';
import 'components/side_menu.dart';


class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
  Widget screen = DashboardScreen();
}

class _MainScreenState extends State<MainScreen> {

  Drawer sideMenu() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
                children: [
                  Icon(Icons.food_bank_rounded,color: white,size: 55,),
                  SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "Allo",
                          size: 25,
                          color: Colors.yellow.shade600),
                      CustomText(
                          text: "Thieb",
                          size: 25,
                          color: Colors.white),
                    ],
                  )
                ],
              )

          ),
          OnHoverText(

            child: DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                setState(() => widget.screen = DashboardScreen());
              },
            ),
          ),

          OnHoverText(

            child: DrawerListTile(
              title: "Liste des plats",
              svgSrc: "assets/icons/food_fresh.svg",
              press: () {
                setState(() => widget.screen = EditPlatJour());
              },
            ),
          ),

          OnHoverText(

            child: DrawerListTile(
              title: "Liste des boissons",
              svgSrc: "assets/icons/jus.svg",
              press: () {
                setState(() => widget.screen = GestionBoissons());
              },
            ),
          ),

          OnHoverText(

            child: DrawerListTile(
              title: "Clients",
              svgSrc: "assets/icons/user1.svg",
              press: () {
                setState(() => widget.screen = ListClient());
              },
            ),
          ),

          OnHoverText(

            child: DrawerListTile(
              title: "Commandes",
              svgSrc: "assets/icons/cmd.svg",
              press: () {
                // setState(() => screen = ListCommande());
              },
            ),
          ),

          OnHoverText(

            child: DrawerListTile(
              title: "Facturation",
              svgSrc: "assets/icons/fact.svg",
              press: () {
                // setState(() => screen = ListFacture());
              },
            ),
          ),


          OnHoverText(

            child: ExpansionTile(
              trailing: Icon(EvaIcons.arrowDown,color: white,),
              leading: SvgPicture.asset(
                "assets/icons/param.svg",
                color: Colors.white,
                height: 16,
              ),
              title: CustomText(
                color: white,
                text: 'Parametres',
                weight: FontWeight.normal,
                size: 16,
              ),
              children: [
                OnHoverText(

                  child: DrawerListTile(
                    title: "Ajouter un plat",
                    svgSrc: "assets/icons/add.svg",
                    press: () {
                      setState(() => widget.screen = DefaultPlat());
                    },
                  ),
                ),
                OnHoverText(

                  child: DrawerListTile(
                    title: "Ajouter une boisson",
                    svgSrc: "assets/icons/add.svg",
                    press: () {
                      setState(() => widget.screen = Boissons());
                    },
                  ),
                ),
              ],

            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: SideMenuColor,
          ),
          child: sideMenu()),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: SideMenuColor,
                    ),
                    child: sideMenu()),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: widget.screen,
            ),
          ],
        ),
      ),
    );
  }
}